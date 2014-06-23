//
//  YelpHomeViewController.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "YelpHomeViewController.h"
#import "YelpClient.h"
#import "SearchAPIResponse.h"
#import "BusinessCategory.h"
#import "Business.h"
#import "BusinessTableViewCell.h"
#import "FilterViewController.h"
#import "Filter.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface YelpHomeViewController ()

    @property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) SearchAPIResponse *searchResponse;

@end

@implementation YelpHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    }
    
    return self;
}

-(void) addFilterButton {
    
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
    
    [button setTitle:@"Filter" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName: @"HelveticaNeue" size:13.0]];
    
    [button addTarget:self action:@selector(gotoFilterView:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:filterButton, nil];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 150.0, 44.0)];
    self.navigationItem.titleView = searchBar;
    
    searchBar.delegate = self;
    self.businessesTableView.delegate = self;
    self.businessesTableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.searchResponse.businesses.count;
}


//search button was tapped
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"inside searchBarSearchButtonClicked");
    [self handleSearch:searchBar];
}


//do our search on the remote server using HTTP request
- (void)handleSearch:(UISearchBar *)searchBar {
    
    NSLog(@"User searched for %@", searchBar.text);
    [searchBar resignFirstResponder];
    self.filterModel = [[Filter alloc] init];
    [self.filterModel setSearchTerm:searchBar.text];
    [self callYelpSearch:searchBar.text parameters:nil];
}

-(void) callYelpSearch: (NSString*)searchTerm parameters: (NSDictionary*) params{
    
    if(params){
     
        [self.client searchWithTerm:searchTerm parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
            
            self.searchResponse = [[SearchAPIResponse alloc] initWithDictionary:response];
            //NSLog(@"response: %@",response);
            
            [self.businessesTableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];

    }else{
    
    [self.client searchWithTerm:searchTerm success:^(AFHTTPRequestOperation *operation, id response) {

        NSLog(@"response: %@",response);
        self.searchResponse = [[SearchAPIResponse alloc] initWithDictionary:response];
        [self.businessesTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BusinessTableViewCell";
    
    // Dequeue or create a cell of the appropriate type.
    BusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if(self.searchResponse && self.searchResponse.businesses.count > 0){
        cell = [cell initWithBusiness:self.searchResponse.businesses[indexPath.row] currentIndex:indexPath.row];
    }else{
        cell = [cell initWithBlank];
    }
    
    return cell;
}
- (IBAction)gotoFilterView:(UIButton *)sender {
    NSLog(@"Filter button clicked!");
    FilterViewController *filtervc = [[FilterViewController alloc] init];
    
    if(!self.filterModel){
        self.filterModel = [[Filter alloc]init];
    }
    
    self.filterModel.categories = [[NSMutableDictionary alloc]init];
    self.filterModel.mostPopular = [[NSMutableDictionary alloc]init];
    
    if(!self.filterModel.searchTerm){
        [self.filterModel setSearchTerm:@"restaurants"];
    }
    
    
    [filtervc setFilterModel:self.filterModel];
    [self.navigationController pushViewController:filtervc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 115.0;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addFilterButton];
    
    [self.businessesTableView registerNib:[UINib nibWithNibName:@"BusinessTableViewCell" bundle:nil] forCellReuseIdentifier:@"BusinessTableViewCell"];
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    if(self.filterModel){
        
        NSLog(@"coming back from filter screen with values: ");
        NSLog(@"filter distance: %@", self.filterModel.distance);
        NSLog(@"filter sort by: %@", self.filterModel.sortBy);
        NSLog(@"filter categories: %@", self.filterModel.categories);
        NSLog(@"filter deals: %d", self.filterModel.offersADeal);
        
        NSMutableDictionary *newParams = [[NSMutableDictionary alloc] init];
        [newParams setObject:self.filterModel.searchTerm forKey:@"term"];
        [newParams setObject:@"San Jose" forKey:@"location"];
        [newParams setObject:[NSString stringWithFormat:@"%f,%f",
                              CONST_LATITUDE,
                              CONST_LONGITUDE] forKey:@"cll"];
        
        [newParams setObject:self.filterModel.distance forKey:@"radius_filter"];
        
        if(self.filterModel.offersADeal == YES){
            
            [newParams setObject:@"true" forKey:@"deals_filter"];
        }
        
        
        if(self.filterModel.categories && self.filterModel.categories.count > 0){
            
            NSMutableString *catFilter = [[NSMutableString alloc] init];
            
            NSEnumerator *enumerator = [self.filterModel.categories keyEnumerator];
            id key;
            while((key = [enumerator nextObject])){
                [catFilter appendString: key];
                [catFilter appendString:@","];
            }
            
            NSRange range = NSMakeRange(0, catFilter.length - 1);
            [newParams setObject:[catFilter substringWithRange:range] forKey:@"category_filter"];
        }
        
        [newParams setObject:self.filterModel.sortBy forKey:@"sort"];
        
        
        
        NSLog(@"calling yelp api with there new params: %@", newParams);
        
        [self callYelpSearch:@"restaurants" parameters:newParams];
        
        
    }else{
        NSLog(@"oops! came back with no values");
        
        [self callYelpSearch:@"restaurants" parameters:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
