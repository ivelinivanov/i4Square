//
//  ProfileWebService.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileWebServiceWorker.h"

@interface ProfileWebService : NSObject

-(void)getInfoAboutProfileWithBlock:(void (^)(NSDictionary *))block;

@end
