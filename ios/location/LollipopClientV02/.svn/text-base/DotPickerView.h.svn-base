//
//  DotPickerView.h
//  Popover
//
//  Created by Xinkai wang on 10/14/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotPickerDelegate.h"


@interface DotPickerView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
	IBOutlet UIPickerView * picker;
	int currentSelection;
	
	id<DotPickerDelegate> delegate;
}

@property (nonatomic, retain) id<DotPickerDelegate> delegate;

- (IBAction) onOK:(id)sender;

// this name includes extention. "BlueDot.png"
- (void) setCurrentSelection:(NSString*)dotImageName;

@end
