//
//  DeviceListView.h
//  LollpopClientV1
//
//  Created by Xinkai wang on 10/14/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddDeviceView.h"
#import "RootView.h"
#import "AddDeviceDelegate.h"


@interface DeviceListView : UIViewController<UITableViewDelegate, UITableViewDataSource, AddDeviceDelegate> {
	IBOutlet UITableView * tableView;
	
	RootView * rootView;

	AddDeviceView * addDeviceViewController;
}

@property (nonatomic, assign) RootView * rootView;

// ******************************** UITableViewDataSource *********************************

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
