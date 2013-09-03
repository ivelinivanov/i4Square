//
//  CheckInWebServiceWorker.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/26/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckInWebServiceConstants.h"

@interface CheckInWebServiceWorker : NSObject

@property (strong, nonatomic) NSMutableData *receivedData;
@property (copy, nonatomic) void (^block)(NSDictionary *);

-(void)connectToServerUsingURL:(NSString *) url;
-(void)checkInWithResult:(void (^)(NSDictionary *))block atVenue:(NSString *)venueID;

@end
