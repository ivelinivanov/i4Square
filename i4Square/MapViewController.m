//
//  MapViewController.m
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAnnotationKey];
}

-(void)locateMapOnLatitude:(float)latitude andLongitude:(float)longitude
{
    MKCoordinateRegion CSC;
    
    CSC.center.latitude = latitude;
    CSC.center.longitude = longitude;
    
    CSC.span.latitudeDelta = kLocationDelta;
    CSC.span.longitudeDelta = kLocationDelta;
    
    [self.mapView setRegion:CSC animated:NO];
}


-(void)checkInAtLocation
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    MapAnnotation *currentAnnotation = [[MapAnnotation alloc] initWithDictionary:[defaults objectForKey:kAnnotationKey]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:currentAnnotation.title
                                                    message:@"Do you really want to check in here?"
                                                   delegate:self cancelButtonTitle:@"Yes"
                                          otherButtonTitles:@"No", nil];
    [alert show];
}

-(void)sendCheckInRequestAtLocation:(MapAnnotation *)mapAnnotation
{
    CheckInWebService *service = [[CheckInWebService alloc] init];
    [service checkInWithResult:^(NSDictionary *resultDictionary)
     {
        
         NSString *title = nil;
         NSString *msg = nil;
         
         if([[resultDictionary valueForKeyPath:kMetaCode] intValue] >= 400)
         {
             title = @"Error";
             msg = @"Something went wrong while checking-in. Please try again.";
         }
         else
         {
             title = [[NSString alloc] initWithFormat:@"You checked at: %@", [resultDictionary valueForKeyPath:kVenueName]];
             msg = [[NSString alloc] initWithFormat:@"This is the %d check-in at this place!",[[resultDictionary valueForKeyPath:kCheckInsCount] intValue] ];
         }
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                         message:msg
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
         [alert show];
         
     } atVenue:mapAnnotation.venueID];
    
}

-(void)dropPins
{
    
    for (NSDictionary *currentVenue in self.venues)
    {
        float latitude = [[currentVenue valueForKeyPath:kLatitudeKey] floatValue];
        float longitude = [[currentVenue valueForKeyPath:kLongitudeKey] floatValue];
    
        CLLocationCoordinate2D  ctrpoint;
        ctrpoint.latitude = latitude;
        ctrpoint.longitude = longitude;
    
        MapAnnotation *addAnnotation = [[MapAnnotation alloc] init];
        addAnnotation.coordinate = ctrpoint;
        addAnnotation.title = [currentVenue valueForKeyPath:@"name"];
        if([[currentVenue valueForKeyPath:kLocationAddress] length] != 0)
        {
            addAnnotation.subtitle = [[NSString alloc] initWithFormat:@"%@", [currentVenue valueForKeyPath:kLocationAddress]];
        }
        addAnnotation.venueID = currentVenue[@"id"];
        
        [self.mapView addAnnotation:addAnnotation];
    }
}



#pragma mark - MapView Delegate Methods

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocation *userLoc = userLocation.location;
    
    [self locateMapOnLatitude:userLoc.coordinate.latitude andLongitude:userLoc.coordinate.longitude];
    
    VenuesWebService *service = [[VenuesWebService alloc] init];
    [service getInfoAboutProfileWithBlock:^(NSDictionary * resultDictionary)
     {
         NSArray *allVenues = [NSArray arrayWithArray:[resultDictionary valueForKeyPath:kVenues]];
         
         if([allVenues count] > kMaxVenues)
         {
             self.venues = [[NSMutableArray alloc] init];
             
             for(int i = 0; i < kMaxVenues; i++)
             {
                 [self.venues addObject:allVenues[i]];
             }
         }
         else
         {
             self.venues = [NSMutableArray arrayWithArray:allVenues];
         }
         
         
         [self dropPins];
         
     } atLatitude:userLoc.coordinate.latitude andLongitude:userLoc.coordinate.longitude];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pinView"];
    if (!pinView)
    {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:@"pinView"];
        if([annotation isKindOfClass:[MapAnnotation class]])
        {
            pinView.pinColor = MKPinAnnotationColorGreen;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
            
            [button addTarget:self
                       action:@selector(checkInAtLocation)
             forControlEvents:UIControlEventTouchUpInside];
            
            pinView.rightCalloutAccessoryView = button;
        }
        else
        {
            pinView.pinColor = MKPinAnnotationColorPurple;
            pinView.animatesDrop = NO;
            pinView.canShowCallout = YES;
        }
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    if([view.annotation isKindOfClass:[MapAnnotation class]])
    {
        MapAnnotation *selectedAnnotation = view.annotation;
        NSNumber *latitude = [[NSNumber alloc] initWithDouble:selectedAnnotation.coordinate.latitude];
        NSNumber *longitude = [[NSNumber alloc] initWithDouble:selectedAnnotation.coordinate.longitude];
        
        NSDictionary *annotationProperties = @{
                                               @"title": selectedAnnotation.title,
                                               @"subtitle" : ((selectedAnnotation.subtitle == nil) ? @"" : selectedAnnotation.subtitle),
                                               @"latitude" : latitude,
                                               @"longitude" : longitude,
                                               @"id" : selectedAnnotation.venueID
                                               };
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:annotationProperties forKey:kAnnotationKey];
    }
    
}

#pragma mark - Alert View Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        MapAnnotation *selectedAnnotation = [[MapAnnotation alloc] initWithDictionary:[defaults objectForKey:kAnnotationKey]];
        [self sendCheckInRequestAtLocation:selectedAnnotation];
    }
}

@end