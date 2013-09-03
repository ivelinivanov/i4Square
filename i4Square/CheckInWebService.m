//
//  CheckInWebService.m
//  i4Square
//
//  Created by Ivelin Ivanov on 7/26/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "CheckInWebService.h"

@implementation CheckInWebService

-(void)checkInWithResult:(void (^)(NSDictionary *))block atVenue:(NSString *)venueID
{
    CheckInWebServiceWorker *serviceWorker = [[CheckInWebServiceWorker alloc] init];
    [serviceWorker checkInWithResult:block atVenue:venueID];
}

@end
