//
//  VenuesWebService.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VenuesWebServiceWorker.h"

@interface VenuesWebService : NSObject

-(void)getInfoAboutProfileWithBlock:(void (^)(NSDictionary *))block atLatitude:(float)latitude andLongitude:(float)longitude;

@end
