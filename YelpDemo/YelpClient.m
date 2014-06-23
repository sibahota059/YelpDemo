//
//  YelpClient.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "YelpClient.h"
#import <CoreLocation/CoreLocation.h>

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSDictionary *parameters = @{@"term": term, @"location" : @"San Jose", @"cll" : [NSString stringWithFormat:@"%f,%f",
                                                                                     CONST_LATITUDE,
                                                                                     CONST_LONGITUDE]};
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}


- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term parameters:(NSDictionary*) params success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
//    NSDictionary *parameters = @{@"term": term, @"location" : @"San Jose", @"cll" : [NSString stringWithFormat:@"%f,%f",
//                                                                                     CONST_LATITUDE,
//                                                                                     CONST_LONGITUDE]};
    
    return [self GET:@"search" parameters:params success:success failure:failure];
}

+(double) getDistanceBetweenTwoLocationsLatitude1: (double) lat1 Longitude1: (double) long1 Latitude2: (double) lat2 Longitude2: (double) long2 {
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:lat1 longitude:long1];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:lat2 longitude:long2];
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    NSLog(@"distance -> %f", distance/1610);
    return distance;
}

@end
