//
//  MapAnnotation.m
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

-(id)initWithDictionary:(NSDictionary *)properties
{
    if(self = [super init])
    {
        self.title = properties[@"title"];
        self.subtitle = properties[@"subtitle"];
        self.venueID = properties[@"id"];
        
        CLLocationCoordinate2D newCoordinate;
        
        newCoordinate.latitude = [properties[@"latitude"] doubleValue];
        newCoordinate.longitude = [properties[@"longitude"] doubleValue];
        
        self.coordinate = newCoordinate;
    }
    return self;
}

@end
