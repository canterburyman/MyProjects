//
//  ChatCellWithLeftIcon.h
//  Conversation
//
//  Created by Xinjun Email on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObject.h"

@interface ChatCellWithLeftIcon : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;
@property (retain, nonatomic) IBOutlet UIView *chatMessageView;

@property (retain, nonatomic) IBOutlet UILabel *fromWhomLabel;
@property (retain, nonatomic) IBOutlet UILabel *sentTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *msgLabel;

@property (retain, nonatomic) IBOutlet UILabel *sentFromWhereLabel;
@property (retain, nonatomic) IBOutlet UIImageView *backgroudImageView;

-(void) fillContent:(MessageObject*)message IconImage:(UIImage*) image;
@end
