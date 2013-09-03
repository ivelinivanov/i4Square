//
//  VenuesWebService.m
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "VenuesWebService.h"

@implementation VenuesWebService

-(void)getInfoAboutProfileWithBlock:(void (^)(NSDictionary *))block atLatitude:(float)latitude andLongitude:(float)longitude
{
    VenuesWebServiceWorker *serviceWorker = [[VenuesWebServiceWorker alloc] init];
    [serviceWorker getResultDictionaryForVenues:block atLatitude:latitude andLongitude:longitude];
}

@end
