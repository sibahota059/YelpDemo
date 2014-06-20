//
//  BusinessTableViewCell.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/19/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Business.h"

@interface BusinessTableViewCell : UITableViewCell

-(id) initWithBusiness:(Business*) business currentIndex: (int) index ;
-(id) initWithBlank;

@end
