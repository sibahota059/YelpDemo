//
//  FilterViewController.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/20/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filter.h"

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSArray *categoryValues;
@property (strong, nonatomic) Filter *filterModel;
@property (strong, nonatomic) NSArray *distanceValues;
@property (strong, nonatomic) NSArray *mostPopularValues;

@end
