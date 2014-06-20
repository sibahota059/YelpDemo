//
//  BusinessCategory.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/19/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessCategory : NSObject

@property NSString *categoryName;
@property NSString *categoryAlias;

-(id) initWithArray: (NSArray*) data;

@end
