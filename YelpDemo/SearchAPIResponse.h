//
//  SearchAPIResponse.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Region.h"

@interface SearchAPIResponse : NSObject

@property NSArray *businesses;
@property int totalBusinesses;
@property Region *region;

-(id) initWithDictionary:(NSDictionary*) data;

@end
