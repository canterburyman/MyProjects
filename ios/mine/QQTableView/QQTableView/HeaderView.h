//
//  HeaderView.h
//  QQTableView
//
//  Created by Xinjun Email on 22/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *accessaryView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *totalNumLabel;
@property (retain, nonatomic) IBOutlet UIButton *buttonInHeader;
@property (retain, nonatomic) IBOutlet UIButton *disclosureButton;

@end
