//
//  Address.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/19/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "Address.h"

@implementation Address

-(id) initWithFullAddressArray: (NSArray*) data{
    
    self = [super init];
    
    if(data.count == 3){
        self.addressLineOne = data[0];
        self.addressLineTwo = data[1];
        self.addressLineThree = data[2];
    }else if(data.count == 2){
        self.addressLineOne = data[0];
        self.addressLineThree = data[1];
    }else if(data.count == 1){
        self.addressLineOne = data[0];
    }
    
    
    return self;
}

-(id) initWithSingleAddressLine: (NSArray*) data{
    
    self = [super init];
    self.addressLineOne = data[0];
    return self;
}


@end
