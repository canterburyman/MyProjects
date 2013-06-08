//
//  CalculatorV2AppDelegate.h
//  CalculatorV2
//
//  Created by Jane Ching on 16/02/12.
//  Copyright 2012 UOW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorV2ViewController;

@interface CalculatorV2AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CalculatorV2ViewController *viewController;

@end
