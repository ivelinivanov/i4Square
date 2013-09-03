//
//  ProfileWebServiceWorker.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileWebServiceConstants.h"

@interface ProfileWebServiceWorker : NSObject

@property (strong, nonatomic) NSMutableData *receivedData;
@property (copy, nonatomic) void (^block)(NSDictionary *);

-(void)connectToServerUsingURL:(NSString *) url;
-(void)getResultDictionaryForProfile:(void (^)(NSDictionary *))block;

@end
