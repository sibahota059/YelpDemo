//
//  Span.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Span : NSObject
@property double latitudeDelta;
@property double longitudeDelta;

-(id) initWithDictionary: (NSDictionary*) data;
@end
