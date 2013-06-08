//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Jane Ching on 9/06/11.
//  Copyright 2011 UOW. All rights reserved.
//

#import "CalculatorV2ViewController.h"
@interface CalculatorV2ViewController()
@property  (nonatomic) BOOL userIsInMiddleOfTypingANumber;

//@property (nonatomic) UILabel *display;
@end


@implementation CalculatorV2ViewController

@synthesize userIsInMiddleOfTypingANumber = _userIsInMiddleOfTypingANumber;

-(CalculatorBrain *)brain
{
    if (!brain) brain = [[CalculatorBrain alloc] init];
    return brain;
}


- (IBAction) digitPressed:(UIButton *)sender
{
    NSString *digit = [[sender titleLabel] text];
    if(userIsInMiddleOfTypingANumber)
    {
        [display setText:[[display text]  stringByAppendingString:digit]];
    }
    else
    {
        [display setText:digit];
        userIsInMiddleOfTypingANumber = YES;
    }
}


- (IBAction) operationPressed:(UIButton *)sender
{
    if(userIsInMiddleOfTypingANumber)
    {
        [brain pushOperand:[display.text doubleValue]];
        userIsInMiddleOfTypingANumber = NO;
    }
    NSString *operation = [[sender titleLabel] text];
    double result = [[self brain] performOperation: operation];
    [display setText:[NSString stringWithFormat:@"%g", result ]];
}

//- (IBAction)enterPressed:(UIButton *)sender 
//{
//    NSString *operation = [sender currentTitle]; 
//    double result = [brain performOperation:operation]; 
//    [display setText: [NSString stringWithFormat:@"%g", result]];
//}

@end
