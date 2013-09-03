//
//  ProfileWebService.m
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "ProfileWebService.h"

@implementation ProfileWebService

#pragma mark - Get Info Methods

-(void)getInfoAboutProfileWithBlock:(void (^)(NSDictionary *))block
{
    ProfileWebServiceWorker *serviceWorker = [[ProfileWebServiceWorker alloc] init];
    [serviceWorker getResultDictionaryForProfile:block];
}

@end
