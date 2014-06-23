//
//  Business.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "Business.h"
#import "BusinessCategory.h"
#import "Location.h"


@implementation Business

-(id) initWithDictionary:(NSDictionary *)data {
    
    self = [super init];
    
    self.identifier = data[@"id"];
    self.isClaimed = data[@"is_claimed"];
    self.isClosed = data[@"is_closed"];
    self.name = data[@"name"];
    self.photoURL = data[@"image_url"];
    self.websiteURL = data[@"url"];
    self.mobileWebsiteURL = data[@"mobile_url"];
    self.phone = data[@"phone"];
    self.displayPhone = data[@"display_phone"];
    self.reviewCount = [data[@"review_count"] integerValue];
    
    NSMutableArray* mutableCategoriesList = [[ NSMutableArray alloc ] initWithCapacity: 2];
    BusinessCategory *category;
    for(id cat in [data valueForKey:@"categories"]){
        
        category = [[BusinessCategory alloc] initWithArray:cat];
        [mutableCategoriesList addObject: category];
    }
    self.categories = [NSArray arrayWithArray:mutableCategoriesList];
    
    self.distance = [data[@"distance"] floatValue];
    self.rating = [data[@"rating"] floatValue];
    self.ratingImageURL = data[@"rating_img_url"];
    self.ratingImageURLLarge = data[@"rating_img_url_large"];
    self.location = [[Location alloc] initWithDictionary:data[@"location"]];
    self.menuProvider = data[@"menu_provider"];
    self.menuDateUpdated = [data[@"menu_date_updated"] longValue];
    
    return self;

}

@end
