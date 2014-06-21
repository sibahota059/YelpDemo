//
//  FilterViewController.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/20/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger) titleForHeaderInSection:(UITableView *)aTableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
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
