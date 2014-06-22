//
//  FilterTableViewCell.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/21/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *filterTypeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

@end
