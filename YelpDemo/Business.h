//
//  Business.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Business : NSObject

@property NSString *identifier;
@property NSString *isClaimed;
@property NSString *isClosed;
@property NSString *name;
@property NSString *photoURL;
@property NSString *websiteURL;
@property NSString *mobileWebsiteURL;
@property NSString *phone;
@property NSString *displayPhone;
@property int reviewCount;
@property NSArray *categories;
@property double distance;
@property float rating;
@property NSString *ratingImageURL;
@property NSString *ratingImageURLLarge;
@property Location *location;
@property NSString *menuProvider;
@property long menuDateUpdated;

-(id) initWithDictionary: (NSDictionary*) data;
    
@end
