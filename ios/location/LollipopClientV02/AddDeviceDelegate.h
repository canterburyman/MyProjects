//
//  AddDeviceDelegate.h
//  LollipopClientV02
//
//  Created by Xinkai wang on 10/16/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddDeviceDelegate

- (void) saveNewDevice:(NSString*)lid nickname:(NSString*)nickname dotImageName:(NSString*)dotImageName;

@end
