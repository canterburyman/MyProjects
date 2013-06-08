//
//  StatsViewController.h
//  statistic
//
//  Created by Jane Ching on 8/11/12.
//  Copyright (c) 2012 Software Tracking LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextView *textView;
- (IBAction)clickStatsRefresh:(id)sender;

@end
