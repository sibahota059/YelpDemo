//
//  BusinessCategory.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/19/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "BusinessCategory.h"

@implementation BusinessCategory

-(id) initWithArray: (NSArray*) data{
    self = [super init];
    
    self.categoryName = data[0];
    self.categoryAlias = data[1];
    
    return self;
}
@end
