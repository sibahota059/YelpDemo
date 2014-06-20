//
//  Region.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "Region.h"
#import "Span.h"
#import "Center.h"

@implementation Region

-(id) initWithDictionary: (NSDictionary*) data{
    self = [super init];
    self.span = [[Span alloc] initWithDictionary:data[@"span"]];
    self.center = [[Center alloc] initWithDictionary:data[@"center"]];
    return self;
}


@end
