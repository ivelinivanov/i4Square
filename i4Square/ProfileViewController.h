//
//  ProfileViewController.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileWebService.h"
#import "ProfileViewControllerConstants.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) NSDictionary *profileInfo;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgesLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkInLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckInLabel;
@property (weak, nonatomic) IBOutlet UITextView *lastCheckInTextView;

@end