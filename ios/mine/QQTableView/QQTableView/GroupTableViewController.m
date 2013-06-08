//
//  GroupTableViewController.m
//  QQTableView
//
//  Created by Xinjun Email on 21/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GroupTableViewController.h"
#import "RCSwitch.h"

@implementation SearchBarWithButton

- (void)layoutSubviews {
    UITextField *searchField;
    
    self.autoresizesSubviews = YES;
    CGSize boundSize = [self bounds].size;
    NSUInteger numViews = [self.subviews count];
    for(int i = 0; i < numViews; i++) {
        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) { //conform?
            searchField = [self.subviews objectAtIndex:i];
        }else {
            UIView *view = [self.subviews objectAtIndex:i];
            view.frame = CGRectMake(5, 8, boundSize.width - 50, boundSize.height - 8*2);

        }
    }
    if(!(searchField == nil)) {
        
        searchField.textColor = [UIColor whiteColor];
        searchField.clipsToBounds = NO;
        [searchField setBackground: [UIImage imageNamed:@"list-item.png"] ];
        [searchField setBorderStyle:UITextBorderStyleNone];
        searchField.frame = CGRectMake(5, 8, boundSize.width - 50, boundSize.height - 8*2);
        searchField.textColor = [UIColor blackColor];
        //searchField.backgroundColor = [UIColor clearColor];
    }
    
//    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [searchButton setTitle:@"search" forState:UIControlStateNormal];
//    [self addSubview:searchButton];
//    searchButton.frame = CGRectMake(bounds.size.width-60, 5, 50, bounds.size.height-5*2);
    
    [super layoutSubviews];
}

@end

@interface TrackerTableCell ()

@end

@implementation TrackerTableCell
@synthesize backgroundView;
@synthesize nameLabel;
@synthesize numberLabel;
@synthesize accessaryImageview;
@synthesize buttonInCell;
@synthesize subtitleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)dealloc {
    [nameLabel release];
    [backgroundView release];
    [numberLabel release];
    [accessaryImageview release];
    [buttonInCell release];
    [subtitleLabel release];
    [super dealloc];
}
@end



@interface GroupTableViewController ()

@property (nonatomic, retain) NSArray *groupNames; 
@property (nonatomic, retain) NSMutableArray *showUserList; //BOOL
@property (nonatomic, retain) NSDictionary *usersInGroupDict;
@property (nonatomic, retain) NSMutableArray *headerViewArray; // UIView*
@end

@implementation GroupTableViewController
@synthesize groupNames, usersInGroupDict, showUserList;
@synthesize headerView;
@synthesize headerViewArray;


- (void)createSearchBar
{
    if (self.tableView && !self.tableView.tableHeaderView) {
        UISearchBar *searchBar = [[[SearchBarWithButton alloc] init] autorelease];
        [[[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self] release];
        self.searchDisplayController.searchResultsDelegate = self;
        self.searchDisplayController.searchResultsDataSource = self;
        self.searchDisplayController.delegate = self;
        searchBar.backgroundImage = [UIImage imageNamed:@"bg.png"];
        
        //searchBar.showsSearchResultsButton = YES;
        searchBar.delegate = self;
        //searchBar.showsCancelButton = YES;
        searchBar.frame = CGRectMake(0, 0, 0, 44);
        self.tableView.tableHeaderView = searchBar;
    }

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.groupNames = [NSArray arrayWithObjects:@"group1", @"group2", nil];
        self.showUserList = [NSMutableArray arrayWithCapacity:5];
        [self.showUserList addObjectsFromArray:[NSArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], nil]];
        self.usersInGroupDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"user1", @"user2", nil], [self.groupNames objectAtIndex:0],
                            [NSArray arrayWithObjects:@"user222", @"user223", @"user233", nil], [self.groupNames objectAtIndex:1], nil];
        self.headerViewArray = [NSMutableArray arrayWithCapacity:5];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:[UIColor redColor]];
    [self createSearchBar];
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self.view setBackgroundColor:bgColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.groupNames.count;
}

-(NSArray *) getUserGroupByIndex:(NSInteger) index
{
    return [self.usersInGroupDict objectForKey:[self.groupNames objectAtIndex:index]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if ([[self.showUserList objectAtIndex:section] boolValue]) {
        return [[self getUserGroupByIndex:section] count];
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    static NSString *ReuseIdentifier = @"TrackerTableCell";
    
    TrackerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:ReuseIdentifier owner:nil options:nil] lastObject];
        //cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-item.png"]] autorelease];
    }
    
    cell.nameLabel.text = [[self getUserGroupByIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

-(void) headerClicked:(UIButton *) button
{
    BOOL isShow = [[self.showUserList objectAtIndex:button.tag] boolValue];
    [self.showUserList replaceObjectAtIndex:button.tag withObject:[NSNumber numberWithBool:!isShow]];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(void) enterGroup:(UIButton *) button
{
    NSLog(@"enterGroup gets pressed!");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section  // custom view for header. will be adjusted to default or specified header height
{

    HeaderView *_headerView = nil;
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    
    if ([[self.showUserList objectAtIndex:section] boolValue]) {
        _headerView.accessaryView.image = [UIImage imageNamed:@"arrow_down.png"];
    }
    else {

        _headerView.accessaryView.image = [UIImage imageNamed:@"arrow_right.png"];

    }
    
    _headerView.buttonInHeader.tag = section;
    [_headerView.buttonInHeader addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchDown];
    
    [_headerView.disclosureButton addTarget:self action:@selector(enterGroup:) forControlEvents:UIControlEventTouchDown];
    
    NSString *groupName = [self.groupNames objectAtIndex:section];
    _headerView.nameLabel.text = groupName;
    
    _headerView.totalNumLabel.text = [NSString stringWithFormat:@"%d", [[self.usersInGroupDict objectForKey:groupName] count]];
    return _headerView;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}


@end
