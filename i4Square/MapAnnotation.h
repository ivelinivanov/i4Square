//
//  MapAnnotation.h
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *venueID;

-(id)initWithDictionary:(NSDictionary *)properties;

@end
