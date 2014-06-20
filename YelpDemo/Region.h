//
//  Region.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Center.h"
#import "Span.h"

@interface Region : NSObject

@property Span *span;
@property Center *center;

-(id) initWithDictionary: (NSDictionary*) data;

@end
