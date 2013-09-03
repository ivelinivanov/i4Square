//
//  ProfileViewController.m
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.activityIndicator startAnimating];
    [self hideAllControls];
	
    ProfileWebService *service = [[ProfileWebService alloc] init];
    [service getInfoAboutProfileWithBlock:^(NSDictionary * resultDictionary)
     {
         self.activityIndicator.hidesWhenStopped = YES;
         
         self.profileInfo = [NSDictionary dictionaryWithDictionary:resultDictionary];
        [self configureView];
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barMapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(showMapView)];
    
    UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(logOut)];
    
    self.navigationItem.rightBarButtonItem = barMapButton;
    self.navigationItem.leftBarButtonItem = logOutButton;
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    
}

-(void)configureView
{
    //set up name label
    NSString *name = [[NSString alloc] initWithFormat:@"%@ %@", [self.profileInfo valueForKeyPath:kFirstNameKey], [self.profileInfo valueForKeyPath:kLastNameKey]];
    self.nameLabel.text = name;
    
    //set up badges label
    NSString *badges = [[NSString alloc] initWithFormat:@"Badges: %d", [[self.profileInfo valueForKeyPath:kBadgesKey] intValue]];
    self.badgesLabel.text = badges;
    
    //set up checkins label
    NSString *checkins = [[NSString alloc] initWithFormat:@"CheckIns: %d", [[self.profileInfo valueForKeyPath:kCheckInsKey] intValue]];
    self.checkInLabel.text = checkins;
    
    //set up image view
    NSString *prefixURL = [self.profileInfo valueForKeyPath:kUserPhotoPrefix];
    NSString *suffixURL = [self.profileInfo valueForKeyPath:kUserPhotoSuffix];
    NSString *fullURL = [[NSString alloc] initWithFormat:@"%@/500x500/%@", prefixURL, suffixURL];
    
    NSURL *imageURL = [NSURL URLWithString: fullURL];
    NSData *data = [[NSData alloc] initWithContentsOfURL: imageURL];
    self.profileImage.image = [UIImage imageWithData: data];
    
    //set up last check in
    NSArray *checkIns = [self.profileInfo valueForKeyPath:kCheckInsItemsKey];
    
    NSDictionary *lastCheckIn = [checkIns lastObject];
    NSString *locationName = [lastCheckIn valueForKeyPath:kVenueNameKey];
    NSDictionary *location = [lastCheckIn valueForKeyPath:kVenueLocationKey];
    NSString *locationAddress = [[NSString alloc] initWithFormat:@"%@ %@ %@", (location[kCCKey] == nil ? @"" : location[kCCKey]),
                                                                                (location[kCityKey] == nil ? @"" : location[kCityKey]),
                                                                                (location[kAddressKey] == nil ? @"" : location[kAddressKey])];
    NSString *latitude = location[kLatitude];
    NSString *longitude = location[kLongitude];
    
    
    self.lastCheckInTextView.text = [[NSString alloc] initWithFormat:@"Name: %@\n%@\nLatitude: %@ Longitude: %@",locationName,locationAddress, latitude, longitude];
    
    [self.activityIndicator stopAnimating];
    [self showAllControls];
    
}

#pragma mark - Toggle Hidden Controls Methods

-(void)hideAllControls
{
    self.nameLabel.hidden = YES;
    self.profileImage.hidden = YES;
    self.badgesLabel.hidden = YES;
    self.checkInLabel.hidden = YES;
    self.lastCheckInLabel.hidden = YES;
    self.lastCheckInTextView.hidden = YES;
}

-(void)showAllControls
{
    self.nameLabel.hidden = NO;
    self.profileImage.hidden = NO;
    self.badgesLabel.hidden = NO;
    self.checkInLabel.hidden = NO;
    self.lastCheckInLabel.hidden = NO;
    self.lastCheckInTextView.hidden = NO;
}

#pragma mark - Bar Button Methods

-(void)showMapView
{
    [self hideAllControls];
    [self performSegueWithIdentifier:@"toMapView" sender:self];
}

-(void)logOut
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"access_token"];
    [self hideAllControls];
    [self performSegueWithIdentifier:@"backToLogin" sender:self];
    
}

@end