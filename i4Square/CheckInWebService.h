//
//  CheckInWebService.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/26/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckInWebServiceWorker.h"

@interface CheckInWebService : NSObject

-(void)checkInWithResult:(void (^)(NSDictionary *))block atVenue:(NSString *)venueID;

@end
