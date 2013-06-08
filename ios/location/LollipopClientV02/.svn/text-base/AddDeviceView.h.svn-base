//
//  AddDeviceView.h
//  LollpopClientV1
//
//  Created by Xinkai wang on 10/14/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotPickerView.h"
#import "AddDeviceDelegate.h"

@interface AddDeviceView : UIViewController<DotPickerDelegate> {
	IBOutlet UITextField * lidTextField;
	IBOutlet UITextField * nicknameTextField;
	IBOutlet UIImageView * dotSampleImage;
	IBOutlet UILabel * statusLabel;
	
	// - (void) saveNewDevice:(NSString*)lid, nickname:(NSString*)nickname, dotImageName:(NSString*)dotImageName 
	id delegator; // normally it is a instance of DeviceListVie
	
	NSString * dotImageName;
}

@property (nonatomic, retain) id<AddDeviceDelegate> delegator;
@property (nonatomic, retain) NSString * dotImageName;

- (IBAction) onChangeImage:(id)sender;

// DotPickerDelegate
- (void) DotImagePicked:(NSInteger)imageIndex source:(DotPickerView*)src;

@end
