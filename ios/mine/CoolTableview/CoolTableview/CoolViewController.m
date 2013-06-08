//
//  CoolViewController.m
//  CoolTableview
//
//  Created by Xinjun on 2/06/13.
//  Copyright (c) 2013 Xinjun. All rights reserved.
//

#import "CoolViewController.h"
#import "CustomCellBackground.h"
#import "TableHeaderView.h"

@interface CoolViewController ()

@property (copy) NSMutableArray *thingsToLearn;
@property (copy) NSMutableArray *thingsLearned;

@end

@implementation CoolViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Core Graphics 101";
    self.thingsToLearn = [@[@"Drawing Rects", @"Drawing Gradients", @"Drawing Arcs"] mutableCopy];
    self.thingsLearned = [@[@"Table Views", @"UIKit", @"Objective-C"] mutableCopy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.thingsToLearn.count;
    } else {
        return self.thingsLearned.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString * entry;
    
    
    if(![cell.backgroundView isKindOfClass:[CustomCellBackground class]])
    {
        cell.backgroundView = [[CustomCellBackground alloc] init];
    }
    
    if(![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]])
    {
        cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    }
    
    if (indexPath.section == 0) {
        entry = self.thingsToLearn[indexPath.row];
    } else {
        entry = self.thingsLearned[indexPath.row];
    }
    cell.textLabel.text = entry;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Things We'll Learn";
    } else {
        return @"Things Already Covered";
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableHeaderView *header = [[TableHeaderView alloc] init];
    header.titleLabel.text = [self tableView:self.tableView titleForHeaderInSection:section];
    
    return header;
}

@end
