//
//  FoursquareLoginViewController.m
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "FoursquareLoginViewController.h"

@implementation FoursquareLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *url = [NSString stringWithFormat:kAuthorizationURL,kClientID,kCallbackURI];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	self.webView.delegate = self;
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSString *url =[[request URL] absoluteString];
    
    if ([url rangeOfString:@"access_token="].length != 0)
    {
        NSArray *arr = [url componentsSeparatedByString:@"="];

        NSString *accsessToken = arr[1];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:accsessToken forKey:kAccessToken];
        [defaults synchronize];
        
        [self performSegueWithIdentifier:@"logInSegue" sender:self];
    }
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:kAccessToken] != nil)
    {
        [self performSegueWithIdentifier:@"logInSegue" sender:self];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webView = nil;
    
}


@end