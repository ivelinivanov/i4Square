//
//  VenuesWebServiceWorker.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VenuesWebServiceConstants.h"

@interface VenuesWebServiceWorker : NSObject

@property (strong, nonatomic) NSMutableData *receivedData;
@property (copy, nonatomic) void (^block)(NSDictionary *);

-(void)connectToServerUsingURL:(NSString *) url;
-(void)getResultDictionaryForVenues:(void (^)(NSDictionary *))block atLatitude:(float)latitude andLongitude:(float)longitude;

@end
