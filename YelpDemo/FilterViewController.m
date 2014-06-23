//
//  FilterViewController.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/20/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterTableViewCell.h"
#import "YelpHomeViewController.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (strong, nonatomic) NSMutableDictionary *sectionStatus;
@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.categoryValues = @[
                              @{@"name": @"American (New)", @"value": @"newamerican"},
                              @{@"name": @"American (Traditional)", @"value": @"tradamerican"},
                              @{@"name": @"Argentine", @"value": @"argentine"},
                              @{@"name": @"Asian Fusion", @"value": @"asianfusion"},
                              @{@"name": @"Australian", @"value": @"australian"},
                              @{@"name": @"Austrian", @"value": @"austrian"},
                              @{@"name": @"Beer Garden", @"value": @"beergarden"},
                              @{@"name": @"Belgian", @"value": @"belgian"},
                              @{@"name": @"Brazilian", @"value": @"brazilian"},
                              @{@"name": @"Breakfast & Brunch", @"value": @"breakfast_brunch"},
                              @{@"name": @"Buffets", @"value": @"buffets"},
                              @{@"name": @"Burgers", @"value": @"burgers"},
                              @{@"name": @"Burmese", @"value": @"burmese"},
                              @{@"name": @"Cafes", @"value": @"cafes"}
//                              ,
//                              @{@"name": @"Cajun/Creole", @"value": @"cajun"},
//                              @{@"name": @"Canadian", @"value": @"newcanadian"},
//                              @{@"name": @"Chinese", @"value": @"chinese"},
//                              @{@"name": @"Cantonese", @"value": @"cantonese"},
//                              @{@"name": @"Dim Sum", @"value": @"dimsum"},
//                              @{@"name": @"Cuban", @"value": @"cuban"},
//                              @{@"name": @"Diners", @"value": @"diners"},
//                              @{@"name": @"Dumplings", @"value": @"dumplings"},
//                              @{@"name": @"Ethiopian", @"value": @"ethiopian"},
//                              @{@"name": @"Fast Food", @"value": @"hotdogs"},
//                              @{@"name": @"French", @"value": @"french"},
//                              @{@"name": @"German", @"value": @"german"},
//                              @{@"name": @"Greek", @"value": @"greek"},
//                              @{@"name": @"Indian", @"value": @"indpak"},
//                              @{@"name": @"Indonesian", @"value": @"indonesian"},
//                              @{@"name": @"Irish", @"value": @"irish"},
//                              @{@"name": @"Italian", @"value": @"italian"},
//                              @{@"name": @"Japanese", @"value": @"japanese"},
//                              @{@"name": @"Jewish", @"value": @"jewish"},
//                              @{@"name": @"Korean", @"value": @"korean"},
//                              @{@"name": @"Venezuelan", @"value": @"venezuelan"},
//                              @{@"name": @"Malaysian", @"value": @"malaysian"},
//                              @{@"name": @"Pizza", @"value": @"pizza"},
//                              @{@"name": @"Russian", @"value": @"russian"},
//                              @{@"name": @"Salad", @"value": @"salad"},
//                              @{@"name": @"Scandinavian", @"value": @"scandinavian"},
//                              @{@"name": @"Seafood", @"value": @"seafood"},
//                              @{@"name": @"Turkish", @"value": @"turkish"},
//                              @{@"name": @"Vegan", @"value": @"vegan"},
//                              @{@"name": @"Vegetarian", @"value": @"vegetarian"},
//                              @{@"name": @"Vietnamese", @"value": @"vietnamese"}
                              ];
        
        self.distanceValues = @[@{@"name": @"Auto", @"value": @"16094"},
                                @{@"name": @"0.3 mile", @"value": @"483"},
                                @{@"name": @"1 mile", @"value": @"1609"},
                                @{@"name": @"5 miles", @"value": @"8047"},
                                @{@"name": @"20 miles", @"value": @"32187"}];
        
        self.mostPopularValues = @[@{@"name":@"Offering a Deal", @"value":@"deals"}
                                 ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:[self getButton:@"Cancel"]];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:[self getButton:@"Search"]];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    self.title = @"Filter";
    
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"FilterTableViewCell" bundle:nil] forCellReuseIdentifier:@"FilterTableViewCell"];
    
    self.sectionStatus = [[NSMutableDictionary alloc] init];
    
    [self.sectionStatus setObject:@"collapsed" forKey:@"2"];
    [self.sectionStatus setObject:@"collapsed" forKey:@"3"];
    [self.sectionStatus setObject:@"collapsed" forKey:@"4"];
    [self.sectionStatus setObject:@"selectedSortBy" forKey:@"-1"];
    [self.sectionStatus setObject:@"selectedDistance" forKey:@"-1"];
    
    [self.filterModel setOffersADeal:NO];
    
    //[self.filterTableView reloadData];

}

-(UIButton*) getButton:(NSString*)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 10, 50, 30);
    
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    btnGradient.frame = button.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor colorWithRed:181.0f / 255.0f green:21.0f / 255.0f blue:19.0f / 255.0f alpha:1.0f] CGColor],
                          (id)[[UIColor colorWithRed:181.0f / 255.0f green:19.0f / 255.0f blue:21.0f / 255.0f alpha:1.0f] CGColor],
                          nil];
    btnGradient.cornerRadius = 5.0f;
    [button.layer insertSublayer:btnGradient atIndex:0];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName: @"HelveticaNeue" size:13.0]];
    
    if([title  isEqual: @"Cancel"]){
        [button addTarget:self action:@selector(cancelActionPerformed:) forControlEvents: UIControlEventTouchUpInside];
    }else{
        [button addTarget:self action:@selector(searchActionPerformed:) forControlEvents: UIControlEventTouchUpInside];
    }
    
    return button;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"someId"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"someId"];
            }
        [cell.contentView addSubview:[self addPriceSegmentedControl]];
        return cell;
        
    }else if(indexPath.section == 1){
        
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
        
        [cell.switchControl addTarget:self
                               action:@selector(switchControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
//        switch (indexPath.row) {
//            case 0:
//            {
//
//                cell.filterTypeLabel.text = @"Open Now";
//                
//                NSDate *currTime = [NSDate date];
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                [dateFormatter setDateFormat:@"h:mm a"];
//                cell.timeLabel.text = [dateFormatter stringFromDate:currTime];
//                [cell.timeLabel.layer setBorderColor:[UIColor grayColor].CGColor];
//                [cell.timeLabel.layer setBorderWidth:0.5f];
//                [cell.switchControl setOn:NO animated:NO];
//                [cell.switchControl setTag:10];
//                
//                cell.radioButtonImageView.hidden = YES;
//               
//            }
//                break;
//                
//            case 1:
//            {
//                cell.filterTypeLabel.text = @"Hot & New";
//                cell.timeLabel.hidden = YES;
//                [cell.switchControl setOn:NO animated:NO];
//                [cell.switchControl setTag:11];
//                
//                cell.radioButtonImageView.hidden = YES;
//            }
//                break;
//
//            case 2:
//            {
//                cell.filterTypeLabel.text = @"Offering a Deal";
//                cell.timeLabel.hidden = YES;
//                [cell.switchControl setOn:NO animated:NO];
//                [cell.switchControl setTag:12];
//                
//                cell.radioButtonImageView.hidden = YES;
//            }
//                break;
//                
//            case 3:
//            {
//                cell.filterTypeLabel.text = @"Delivery";
//                cell.timeLabel.hidden = YES;
//                [cell.switchControl setOn:NO animated:NO];
//                [cell.switchControl setTag:13];
//                
//                cell.radioButtonImageView.hidden = YES;
//            }
//                break;
//                
//            default:
//                break;
//        }
        
        cell.filterTypeLabel.text = @"Offering a Deal";
        cell.timeLabel.hidden = YES;
        
        
        
        if([(NSString*)[self.filterModel.categories objectForKey:[NSString stringWithFormat:@"%d",indexPath.section * 10 + indexPath.row]] isEqualToString:@"Y"]){
                [cell.switchControl setOn:YES animated:NO];
        }else{
            [cell.switchControl setOn:NO animated:NO];
        }
        
        
        [cell.switchControl setTag:10];
        
        cell.radioButtonImageView.hidden = YES;
        cell.layer.borderColor = [[UIColor colorWithRed:201/255.0f green:200/255.0f blue:197/255.0f alpha:1.0f] CGColor];
        cell.layer.borderWidth = 1.0;
        cell.layer.masksToBounds = YES;
        return cell;
        
    }else if(indexPath.section == 2){
        
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
        
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(distanceTapped:)];
//        singleTap.numberOfTapsRequired = 1;
//        singleTap.numberOfTouchesRequired = 1;
        
        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]] isEqualToString:@"collapsed"]){
            
            cell.timeLabel.hidden = YES;
            cell.switchControl.hidden = YES;
            cell.radioButtonImageView.hidden = NO;
            
            switch ([[self.sectionStatus objectForKey:@"selectedDistance"] integerValue]) {
                case 20:
                    cell.filterTypeLabel.text = @"Auto";
                    [cell.radioButtonImageView setTag:20];
                    break;
                case 21:
                    cell.filterTypeLabel.text = @"0.3 mile";
                    [cell.radioButtonImageView setTag:21];
                    break;
                case 22:
                    cell.filterTypeLabel.text = @"1 mile";
                    [cell.radioButtonImageView setTag:22];
                    break;
                case 23:
                    cell.filterTypeLabel.text = @"5 miles";
                    [cell.radioButtonImageView setTag:23];
                    break;
                case 24:
                    cell.filterTypeLabel.text = @"20 miles";
                    [cell.radioButtonImageView setTag:24];
                    break;
                default:
                    cell.filterTypeLabel.text = @"Auto";
                    [cell.radioButtonImageView setTag:20];
                    break;
            }
            
            cell.radioButtonImageView.image = [UIImage imageNamed:@"triangle.png"];
            //[cell.radioButtonImageView addGestureRecognizer:singleTap];
            //[cell.radioButtonImageView setUserInteractionEnabled:YES];
            
            
        }else{
        
        
        switch (indexPath.row) {
                
            case 0:
            {
                cell.filterTypeLabel.text = @"Auto";
                cell.timeLabel.hidden = YES;
                cell.switchControl.hidden = YES;
                cell.radioButtonImageView.hidden = NO;
                if([[self.sectionStatus objectForKey:@"selectedDistance"] isEqualToString:[NSString stringWithFormat:@"%d",20]]){
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                }else{
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                }
                [cell.radioButtonImageView setTag:20];
            }
                break;
                
            case 1:
            {
                cell.filterTypeLabel.text = @"0.3 miles";
                cell.timeLabel.hidden = YES;
                cell.switchControl.hidden = YES;
                cell.radioButtonImageView.hidden = NO;
                if([[self.sectionStatus objectForKey:@"selectedDistance"] isEqualToString:[NSString stringWithFormat:@"%d",21]]){
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                }else{
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                }
                [cell.radioButtonImageView setTag:21];

            }
                break;
                
            case 2:
            {
                cell.filterTypeLabel.text = @"1 mile";
                cell.timeLabel.hidden = YES;
                cell.switchControl.hidden = YES;
                cell.radioButtonImageView.hidden = NO;
                if([[self.sectionStatus objectForKey:@"selectedDistance"] isEqualToString:[NSString stringWithFormat:@"%d",22]]){
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                }else{
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                }
                [cell.radioButtonImageView setTag:22];
                
            }
                break;
                
            case 3:
            {
                cell.filterTypeLabel.text = @"5 miles";
                cell.timeLabel.hidden = YES;
                cell.switchControl.hidden = YES;
                cell.radioButtonImageView.hidden = NO;
                if([[self.sectionStatus objectForKey:@"selectedDistance"] isEqualToString:[NSString stringWithFormat:@"%d",23]]){
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                }else{
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                }
                [cell.radioButtonImageView setTag:23];
                
            }
                break;
            
            case 4:
            {
                cell.filterTypeLabel.text = @"20 miles";
                cell.timeLabel.hidden = YES;
                cell.switchControl.hidden = YES;
                cell.radioButtonImageView.hidden = NO;
                if([[self.sectionStatus objectForKey:@"selectedDistance"] isEqualToString:[NSString stringWithFormat:@"%d",24]]){
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                }else{
                    
                    cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                }
                [cell.radioButtonImageView setTag:24];
                
            }
                break;
                
            default:
                break;
            }
        }
        cell.layer.borderColor = [[UIColor colorWithRed:201/255.0f green:200/255.0f blue:197/255.0f alpha:1.0f] CGColor];
        cell.layer.borderWidth = 1.0;
        cell.layer.masksToBounds = YES;
        return cell;
        
    }else if(indexPath.section == 3){
        
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
        
        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]] isEqualToString:@"collapsed"]){
            
            cell.timeLabel.hidden = YES;
            cell.switchControl.hidden = YES;
            cell.radioButtonImageView.hidden = NO;
            
            switch ([[self.sectionStatus objectForKey:@"selectedSortBy"] integerValue]) {
                case 30:
                    cell.filterTypeLabel.text = @"Best Match";
                    [cell.radioButtonImageView setTag:30];
                    break;
                case 31:
                    cell.filterTypeLabel.text = @"Distance";
                    [cell.radioButtonImageView setTag:31];
                    break;
                case 32:
                    cell.filterTypeLabel.text = @"Rating";
                    [cell.radioButtonImageView setTag:32];
                    break;
                case 33:
                    cell.filterTypeLabel.text = @"Most Reviewed";
                    [cell.radioButtonImageView setTag:33];
                    break;
                    
                default:
                    cell.filterTypeLabel.text = @"Best Match";
                    [cell.radioButtonImageView setTag:30];
                    break;
            }
            
            cell.radioButtonImageView.image = [UIImage imageNamed:@"triangle.png"];
            
        }else {
            switch (indexPath.row) {
                    
                case 0:
                {
                    cell.filterTypeLabel.text = @"Best Match";
                    cell.timeLabel.hidden = YES;
                    cell.switchControl.hidden = YES;
                    cell.radioButtonImageView.hidden = NO;
                    if([[self.sectionStatus objectForKey:@"selectedSortBy"] isEqualToString:[NSString stringWithFormat:@"%d",30]]){
                        
                        cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                    }else{
                        
                        cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                    }
                    
                    [cell.radioButtonImageView setTag:30];
                    
                }
                    break;
                    
                case 1:
                {
                    cell.filterTypeLabel.text = @"Distance";
                    cell.timeLabel.hidden = YES;
                    cell.switchControl.hidden = YES;
                    cell.radioButtonImageView.hidden = NO;
                    if([[self.sectionStatus objectForKey:@"selectedSortBy"] isEqualToString:[NSString stringWithFormat:@"%d",31]]){
                        
                        cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                    }else{
                        
                        cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                    }
                    [cell.radioButtonImageView setTag:31];
                   
                }
                    break;
                    
                case 2:
                {
                    cell.filterTypeLabel.text = @"Rating";
                    cell.timeLabel.hidden = YES;
                    cell.switchControl.hidden = YES;
                    cell.radioButtonImageView.hidden = NO;
                    if([[self.sectionStatus objectForKey:@"selectedSortBy"] isEqualToString:[NSString stringWithFormat:@"%d",32]]){
                        
                        cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                    }else{
                        
                        cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                    }
                    [cell.radioButtonImageView setTag:32];
                   
                }
                    break;
                    
                case 3:
                {
                    cell.filterTypeLabel.text = @"Most Reviewed";
                    cell.timeLabel.hidden = YES;
                    cell.switchControl.hidden = YES;
                    cell.radioButtonImageView.hidden = NO;
                    if([[self.sectionStatus objectForKey:@"selectedSortBy"] isEqualToString:[NSString stringWithFormat:@"%d",33]]){
                        
                        cell.radioButtonImageView.image = [UIImage imageNamed:@"checked.png"];
                    }else{
                        
                        cell.radioButtonImageView.image = [UIImage imageNamed:@"unchecked.png"];
                    }
                    
                    [cell.radioButtonImageView setTag:33];
                   
                }
                    break;
                    
                default:
                    break;
            }
        }
        cell.layer.borderColor = [[UIColor colorWithRed:201/255.0f green:200/255.0f blue:197/255.0f alpha:1.0f] CGColor];
        cell.layer.borderWidth = 1.0;
        cell.layer.masksToBounds = YES;
        return cell;
        
    }else if(indexPath.section == 4){
        
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
        [cell.switchControl addTarget:self
                               action:@selector(switchControlValueChanged:) forControlEvents:UIControlEventValueChanged];

        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]] isEqualToString:@"collapsed"]){
            
            if(indexPath.row < 4){
                
                cell.filterTypeLabel.text = self.categoryValues[indexPath.row][@"name"];
                cell.timeLabel.hidden = YES;
                cell.switchControl.hidden = NO;
                if([[self.filterModel categories] objectForKey:self.categoryValues[indexPath.row][@"value"]]){
                    [cell.switchControl setOn:YES animated:NO];
                }else{
                    [cell.switchControl setOn:NO animated:NO];
                }
                cell.radioButtonImageView.hidden = YES;
                cell.switchControl.tag = indexPath.row + 40;
                
            } else if(indexPath.row == 4){
                
                cell.filterTypeLabel.text = @"see more";
                cell.timeLabel.hidden = YES;
                cell.switchControl.hidden = NO;
                [cell.switchControl setOn:NO animated:NO];
                cell.switchControl.hidden = YES;
                cell.radioButtonImageView.hidden = YES;
            }
        }else{
         
            cell.filterTypeLabel.text = self.categoryValues[indexPath.row][@"name"];
            cell.timeLabel.hidden = YES;
            cell.switchControl.hidden = NO;
            
            if([[self.filterModel categories] objectForKey:self.categoryValues[indexPath.row][@"value"]]){
                [cell.switchControl setOn:YES animated:NO];
            }else{
                [cell.switchControl setOn:NO animated:NO];
            }
            
            
            cell.radioButtonImageView.hidden = YES;
            cell.switchControl.tag = indexPath.row + 40;
        }
        cell.layer.borderColor = [[UIColor colorWithRed:201/255.0f green:200/255.0f blue:197/255.0f alpha:1.0f] CGColor];
        cell.layer.borderWidth = 1.0;
        cell.layer.masksToBounds = YES;
        return cell;
        
    }else{
        
        NSLog(@"wrong place alert!");
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"someId"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"someId"];
        }
        
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section != 4){
        
        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]] isEqualToString:@"collapsed"]){
            
            [self.sectionStatus setObject:@"expanded" forKey:[NSString stringWithFormat:@"%d",indexPath.section]];
            
        }else{
            
            [self.sectionStatus setObject:@"collapsed" forKey:[NSString stringWithFormat:@"%d",indexPath.section]];
        }
    }
    
    if(indexPath.section == 2){
        
        FilterTableViewCell *cell = (FilterTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        [self.sectionStatus setObject:[NSString stringWithFormat:@"%d",[cell.radioButtonImageView tag]] forKey:@"selectedDistance"];
        [self.filterModel setDistance:[self.distanceValues objectAtIndex:indexPath.row][@"value"]];
        
        
    }else if(indexPath.section == 3){
        
        FilterTableViewCell *cell = (FilterTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        [self.sectionStatus setObject:[NSString stringWithFormat:@"%d",[cell.radioButtonImageView tag]] forKey:@"selectedSortBy"];
        [self.filterModel setSortBy:[NSString stringWithFormat:@"%d",indexPath.row]];
        
    }else if(indexPath.section == 4 && indexPath.row == 4){
        
        [self.sectionStatus setObject:@"expanded" forKey:[NSString stringWithFormat:@"%d",indexPath.section]];
    }
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.filterTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (IBAction) switchControlValueChanged: (UISwitch*) sender {
    
    if([sender isOn]){
        
        if([sender tag] < 40){
        
            //most popular
            int selectedTag = [sender tag];
            //int section = selectedTag / 10;
            int row = selectedTag % 10;
            //NSLog(@"you selected section: %d row: %d", section, row);
            
            if(row == 0){
                [self.filterModel setOffersADeal:YES];
            }
            //[[self.filterModel mostPopular] setObject:@"Y" forKey:[NSString stringWithFormat:@"%d",[sender tag]]];
            
        }else{
            
            //categories
            //NSLog(@"you selected category: %@", [self.categoryValues objectAtIndex:[sender tag] - 40][@"value"]);
            [[self.filterModel categories] setObject:[self.categoryValues objectAtIndex:[sender tag] - 40][@"value"] forKey:[self.categoryValues objectAtIndex:[sender tag] - 40][@"value"]];
        }
        
    }
    
}

-(UISegmentedControl*) addPriceSegmentedControl {
    CGFloat segmentWidth = 74.8;
    CGFloat segmentHeight = 39.1;
    
    UISegmentedControl *sharingSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"$", @"$$", @"$$$", @"$$$$"]];
    //[sharingSegmentControl setApportionsSegmentWidthsByContent:YES];
    sharingSegmentControl.frame = CGRectMake(0, 0, sharingSegmentControl.numberOfSegments * segmentWidth, segmentHeight);
    for (int i = 0; i < sharingSegmentControl.numberOfSegments; i++) {
        [sharingSegmentControl setWidth:segmentWidth forSegmentAtIndex:i];
        //[sharingSegmentControl setTitle:arr[i] forSegmentAtIndex:i];
    }
    //[sharingSegmentControl.layer setBorderColor:[UIColor grayColor].CGColor];
    //[sharingSegmentControl.layer setBorderWidth:1.0f];
    [sharingSegmentControl setSelectedSegmentIndex:0];
    //[sharingSegmentControl setBackgroundColor:[UIColor blueColor]];
    //[[sharingSegmentControl cell] setTrackingMode:NSSegmentedSwitchTrackingSelectAny];
    //[self.view addSubview:sharingSegmentControl];
    
    [sharingSegmentControl addTarget:self action:@selector(priceFilterSelected:) forControlEvents:UIControlEventValueChanged];
    
    return sharingSegmentControl;
}

- (IBAction)priceFilterSelected:(UIButton *)sender {
    NSLog(@"price filter selected. ");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
    if (section==0) {
        return @"Price";
    } else if (section==1) {
        return @"Most Popular";
    } else if (section==2) {
        return @"Distance";
    } else if (section==3) {
        return @"Sort by";
    } else if (section==4) {
        return @"Categories";
    }
    return @" ";
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
   
    if (section==0) {
        return 1;
    } else if (section==1) {
        //return 4;
        return 1;
    } else if (section==2) {
        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",section]] isEqualToString:@"collapsed"]){
            return 1;
        }else{
            return 5;
        }
    } else if (section==3) {
        
        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",section]] isEqualToString:@"collapsed"]){
            return 1;
        }else{
            return 4;
        }
        
    } else if (section==4) {
        
        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",section]] isEqualToString:@"collapsed"]){
            return 5;
        }else{
            return self.categoryValues.count;
        }
    }
    
    return 1;
}

- (IBAction)cancelActionPerformed:(UIButton *)sender {
    
    NSLog(@"cancel button clicked!");
    
    NSString *prevSearchTerm = [self.filterModel searchTerm];
    self.filterModel = [[Filter alloc] init];
    [self.filterModel setSearchTerm:prevSearchTerm];
    self.filterModel.distance = self.distanceValues[0][@"value"];
    self.filterModel.sortBy = [NSString stringWithFormat:@"%d",0];
    
    
    for(id vc in [[self navigationController] childViewControllers]){
        
        if([vc isKindOfClass:[YelpHomeViewController class]]){
            
            [(YelpHomeViewController*)vc setFilterModel:self.filterModel];
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    
}

- (IBAction)searchActionPerformed:(UIButton *)sender {
    
    NSLog(@"search button clicked!");
    
    if(!self.filterModel.distance){
        self.filterModel.distance = self.distanceValues[0][@"value"];
    }
    
    if(!self.filterModel.sortBy){
        self.filterModel.sortBy = [NSString stringWithFormat:@"%d",0];
    }
   
    
    NSLog(@"filter distance: %@", self.filterModel.distance);
    NSLog(@"filter sort by: %@", self.filterModel.sortBy);
    NSLog(@"filter categories: %@", self.filterModel.categories);
    NSLog(@"filter deals: %d", self.filterModel.offersADeal);
    
    for(id vc in [[self navigationController] childViewControllers]){
        
        if([vc isKindOfClass:[YelpHomeViewController class]]){
            
            [(YelpHomeViewController*)vc setFilterModel:self.filterModel];
            [self.navigationController popToViewController:vc animated:YES];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
