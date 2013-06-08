//
//  Resources.m
//  Popover
//
//  Created by Xinkai wang on 10/14/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "Resources.h"


@implementation Resources

static NSArray * dotImageNames = nil;

+ (NSArray *) dotImageNames
{
	if (dotImageNames == nil) {
		dotImageNames = [[NSArray alloc] initWithObjects:@"BlueDot",@"PinkDot",@"GreenDot",@"RedDot",@"LightBlueDot",nil];
	}
	return dotImageNames;
}

@end
