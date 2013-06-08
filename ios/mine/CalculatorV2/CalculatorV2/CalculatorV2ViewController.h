//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Jane Ching on 9/06/11.
//  Copyright 2011 UOW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorV2ViewController : UIViewController {
    IBOutlet UILabel *display;
    CalculatorBrain *brain;
    BOOL userIsInMiddleOfTypingANumber;
}


- (IBAction) digitPressed:(UIButton *)sender;
- (IBAction) operationPressed:(UIButton *)sender;
   
@end
