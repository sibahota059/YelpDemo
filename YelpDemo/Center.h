//
//  Center.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Center : NSObject
@property double latitude;
@property double longitude;

-(id) initWithDictionary: (NSDictionary*) data;
@end
