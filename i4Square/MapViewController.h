//
//  MapViewController.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "VenuesWebService.h"
#import "MapAnnotation.h"
#import "MapViewControllerConstants.h"
#import "CheckInWebService.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *venues;

@end