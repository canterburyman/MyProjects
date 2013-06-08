//
//  GroupTableViewController.h
//  QQTableView
//
//  Created by Xinjun Email on 21/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"


@interface SearchBarWithButton : UISearchBar

@end

@interface TrackerTableCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *backgroundView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
@property (retain, nonatomic) IBOutlet UIImageView *accessaryImageview;
@property (retain, nonatomic) IBOutlet UIButton *buttonInCell;
@property (retain, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@interface GroupTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property (retain, nonatomic) IBOutlet HeaderView *headerView;

@end
