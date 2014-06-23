//
//  Filter.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/22/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject

@property NSString* price;
@property NSMutableDictionary* mostPopular;
@property NSString* distance;
@property NSString* sortBy;
@property NSMutableDictionary* categories;
@property BOOL offersADeal;
@property NSString *searchTerm;

@end
