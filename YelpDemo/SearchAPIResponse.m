//
//  SearchAPIResponse.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "SearchAPIResponse.h"
#import "Business.h"

@implementation SearchAPIResponse

-(id) initWithDictionary:(NSDictionary *)data {
    self = [super init];
    self.totalBusinesses = [data[@"total"] integerValue];
    
    NSMutableArray* mutableBusinessesList = [[ NSMutableArray alloc ] initWithCapacity: 10];
    
    Business *businessTemp;
    
    for(id business in [data valueForKey:@"businesses"]){
        
        businessTemp = [[Business alloc] initWithDictionary:business];
        [mutableBusinessesList addObject: businessTemp];
    }
    self.businesses = [NSArray arrayWithArray:mutableBusinessesList];
    
    self.region = [[Region alloc] initWithDictionary:data[@"region"]];
    
    return self;
}
@end
