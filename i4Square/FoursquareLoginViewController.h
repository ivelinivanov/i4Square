//
//  FoursquareLoginViewController.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoursquareLoginViewConstants.h"

@interface FoursquareLoginViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end