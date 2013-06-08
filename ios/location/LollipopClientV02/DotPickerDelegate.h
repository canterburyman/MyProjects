//
//  DotPickerDelegate.h
//  Popover
//
//  Created by Xinkai wang on 10/15/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DotPickerView;

@protocol DotPickerDelegate

- (void) DotImagePicked:(NSInteger)imageIndex source:(DotPickerView*)src;

@end
