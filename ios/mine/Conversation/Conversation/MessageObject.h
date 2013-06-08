//
//  MessageObject.h
//  Conversation
//
//  Created by Xinjun Email on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageObject : NSObject
@property (retain, nonatomic) NSString * fromWhom;
@property (retain, nonatomic) NSDate *sendTime;
@property (retain, nonatomic) NSString *msgContent;
@property (retain, nonatomic) NSString *address;
@end
