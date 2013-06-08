//
//  ChatViewController.h
//  Conversation
//
//  Created by Xinjun Email on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatCellWithLeftIcon.h"
#import "ChatCellWithRightIcon.h"

#define CHATVIEW_BACKGROUND_COLOR [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f]
#define CHATVIEW_DEFAULT_MESSAGE_WIDTH 220.0f //cell.chatMessageView.width-30.0f
#define CHATVIEW_DEFAULT_IMAGE_MESSAGE_GAP 10.0f
#define CHATVIEW_DEFAULT_CELL_GAP 10.0f
#define CHATVIEW_DEFAULT_MESSAGE_ADDRESS_GAP 5.0f
#define CHATVIEW_DEFAULT_ADDRESS_BOTTOM_GAP 10.0f

static CGFloat const CHATVIEW_kMessageFontSize = 16.0f;   // 15.0f, 14.0f

@interface ChatViewController : UITableViewController

@property (nonatomic, retain) IBOutlet ChatCellWithLeftIcon *leftIconCell;
@property (nonatomic, retain) IBOutlet ChatCellWithRightIcon *rightIconCell;
@property (nonatomic, retain) UINib *leftCellNib, *rightCellNib;

@end
