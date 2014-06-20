//
//  Address.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/19/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property NSString *addressLineOne;
@property NSString *addressLineTwo;
@property NSString *addressLineThree;

-(id) initWithFullAddressArray: (NSArray*) data;
-(id) initWithSingleAddressLine: (NSArray*) data;

@end
