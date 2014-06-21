//
//  BusinessTableViewCell.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/19/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "BusinessTableViewCell.h"
#import "Business.h"
#import "UIImageView+AFNetworking.h"
#import "BusinessCategory.h"

@interface BusinessTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *businessImageView;
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *ratingsImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation BusinessTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(id) initWithBusiness:(Business*) business currentIndex: (int) index {
    
    self = [super init];
    
    [self.businessImageView setImageWithURL:[NSURL URLWithString:business.photoURL]];

    NSString *businessName = [NSMutableString stringWithFormat:@"%d. %@",index+1, business.name];
    self.businessName.text = businessName;
    [self.ratingsImageView setImageWithURL:[NSURL URLWithString:business.ratingImageURL]];
    
    NSMutableString *reviews = [NSMutableString stringWithFormat:@"%d reviews",business.reviewCount];
    self.reviewsLabel.text = reviews;
    
    NSMutableString *address;
    if(business.location.displayAddress.addressLineOne){
        address = [NSMutableString stringWithString:business.location.displayAddress.addressLineOne];
        [address appendString:@", "];
        
        if(business.location.displayAddress.addressLineTwo){
            [address appendString:business.location.displayAddress.addressLineTwo];
        }
    }else{
        address = [NSMutableString stringWithString:business.location.address.addressLineOne];
    }
    
    self.addressLabel.text = address;
    
    //need to specify latitude & longitude to get distance
    self.distance.text = [NSString stringWithFormat:@"%0.2f mi",business.distance];
    
    if(business.categories){
        
        NSMutableString *categories;
        
        for (int i = 0; i < business.categories.count; i++) {
            
            BusinessCategory *category = [business.categories objectAtIndex:i];
            
            categories = [NSMutableString stringWithString:[category categoryName]];
            
            [categories appendString:@", "];
        }
        
        NSRange range = NSMakeRange(0, categories.length - 2);
        
        self.categoryLabel.text = [categories substringWithRange:range];
    }
    
    self.price.text = @"$$";
    
    return self;
}

-(id) initWithBlank {
    self = [super init];
    self.businessName.text = @"";
    self.distance.text = @"";
    self.reviewsLabel.text = @"";
    self.price.text = @"";
    self.addressLabel.text = @"";
    self.categoryLabel.text = @"";
    return self;
}

@end
