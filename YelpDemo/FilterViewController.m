//
//  FilterViewController.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/20/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterTableViewCell.h"

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
        
        switch (indexPath.row) {
            case 0:
            {

                cell.filterTypeLabel.text = @"Open Now";
                
                NSDate *currTime = [NSDate date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"h:mm a"];
                cell.timeLabel.text = [dateFormatter stringFromDate:currTime];
                [cell.timeLabel.layer setBorderColor:[UIColor grayColor].CGColor];
                [cell.timeLabel.layer setBorderWidth:0.5f];
                
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:10];
               
            }
                break;
                
            case 1:
            {
                cell.filterTypeLabel.text = @"Hot & New";
                cell.timeLabel.hidden = YES;
                
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:11];
            }
                break;

            case 2:
            {
                cell.filterTypeLabel.text = @"Offering a Deal";
                cell.timeLabel.hidden = YES;
                
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:12];
            }
                break;
                
            case 3:
            {
                cell.filterTypeLabel.text = @"Delivery";
                cell.timeLabel.hidden = YES;
                
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:13];
            }
                break;
                
            default:
                break;
        }
        
        return cell;
        
    }else if(indexPath.section == 2){
        
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
        
        [cell.switchControl addTarget:self
                               action:@selector(switchControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        switch (indexPath.row) {
                
            case 0:
            {
                cell.filterTypeLabel.text = @"Auto";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:20];
            }
                break;
                
            case 1:
            {
                cell.filterTypeLabel.text = @"0.3 miles";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:21];
            }
                break;
                
            case 2:
            {
                cell.filterTypeLabel.text = @"1 mile";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:22];
            }
                break;
                
            case 3:
            {
                cell.filterTypeLabel.text = @"5 miles";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:23];
            }
                break;
            
            case 4:
            {
                cell.filterTypeLabel.text = @"20 miles";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:24];
            }
                break;
                
            default:
                break;
        }
        
        return cell;
        
    }else if(indexPath.section == 3){
        
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
        [cell.switchControl addTarget:self
                               action:@selector(switchControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        switch (indexPath.row) {
                
            case 0:
            {
                cell.filterTypeLabel.text = @"Best Match";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:30];
            }
                break;
                
            case 1:
            {
                cell.filterTypeLabel.text = @"Distance";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:31];
            }
                break;
                
            case 2:
            {
                cell.filterTypeLabel.text = @"Rating";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:32];
            }
                break;
                
            case 3:
            {
                cell.filterTypeLabel.text = @"Most Reviewed";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:33];
            }
                break;
                
            default:
                break;
        }
        
        return cell;
        
    }else {
        
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
        [cell.switchControl addTarget:self
                               action:@selector(switchControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        switch (indexPath.row) {
                
            case 0:
            {
                cell.filterTypeLabel.text = @"Take-out";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:30];
            }
                break;
                
            case 1:
            {
                cell.filterTypeLabel.text = @"Good for Groups";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:31];
            }
                break;
                
            case 2:
            {
                cell.filterTypeLabel.text = @"Takes Reservations";
                cell.timeLabel.hidden = YES;
                [cell.switchControl setOn:NO animated:NO];
                [cell.switchControl setTag:32];
            }
                break;
                
            default:
                break;
        }
        
        return cell;
        
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]] isEqualToString:@"collapsed"]){
        
        [self.sectionStatus setObject:@"expanded" forKey:[NSString stringWithFormat:@"%d",indexPath.section]];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
        
        [self.filterTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

- (IBAction) switchControlValueChanged: (UISwitch*) sender {
    
    if([sender isOn]){
        
        int selectedTag = [sender tag];
        
        NSLog(@"selected tag value: %d", selectedTag);
        
        int section = selectedTag / 10;
        int row = selectedTag % 10;
        
        NSLog(@"you selected section: %d row: %d", section, row);
    }
    
}

-(UISegmentedControl*) addPriceSegmentedControl {
    CGFloat segmentWidth = 70;
    //CGFloat segmentHeight = 40;
    
    UISegmentedControl *sharingSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"$", @"$$", @"$$$", @"$$$$"]];
    //[sharingSegmentControl setApportionsSegmentWidthsByContent:YES];
    //sharingSegmentControl.frame = CGRectMake(0, 0, sharingSegmentControl.numberOfSegments * segmentWidth, segmentHeight);
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
    
//    if(indexPath.section == 1){
//        return 40.0;
//    }else{
//        return 60.0;
//    }
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
        return @"General Features";
    }
    return @" ";
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
   
    if (section==0) {
        return 1;
    } else if (section==1) {
        return 4;
    } else if (section==2) {
        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",section]] isEqualToString:@"collapsed"]){
            return 1;
        }else{
            NSLog(@"current status: %@", [self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",section]]);
            return 5;
        }
    } else if (section==3) {
        
        if([[self.sectionStatus objectForKey:[NSString stringWithFormat:@"%d",section]] isEqualToString:@"collapsed"]){
            return 1;
        }else{
            return 4;
        }
        
    } else if (section==4) {
        return 3;
    }
    
    return 1;
}

- (IBAction)cancelActionPerformed:(UIButton *)sender {
    
    NSLog(@"cancel button clicked!");
}

- (IBAction)searchActionPerformed:(UIButton *)sender {
    
    NSLog(@"search button clicked!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
