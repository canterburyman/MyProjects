//
//  ChatCellWithLeftIcon.m
//  Conversation
//
//  Created by Xinjun Email on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChatCellWithLeftIcon.h"
#import "MessageObject.h"
#import "ChatViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ChatCellWithLeftIcon
@synthesize iconImageView;
@synthesize contentView;
@synthesize chatMessageView;
@synthesize fromWhomLabel;
@synthesize sentTimeLabel;
@synthesize msgLabel;
@synthesize sentFromWhereLabel;
@synthesize backgroudImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) fillContent:(MessageObject*)message IconImage:(UIImage*) image
{
    UIImageView *msgBackground = nil;
    UILabel *msgText = nil;
    msgBackground = self.backgroudImageView;
    msgText = self.msgLabel;
    msgText.font = [UIFont systemFontOfSize:CHATVIEW_kMessageFontSize];
    
    // Configure the cell to show the message in a bubble. Layout message cell & its subviews.
    UIImage *bubbleImage = nil;
    CGFloat height = [message.msgContent sizeWithFont:[UIFont systemFontOfSize:CHATVIEW_kMessageFontSize]
                                    constrainedToSize:CGSizeMake(CHATVIEW_DEFAULT_MESSAGE_WIDTH, CGFLOAT_MAX)
                                        lineBreakMode:UILineBreakModeWordWrap].height;
    
    //according to the height, set the frame related to this height
    self.chatMessageView.frame = CGRectMake(self.iconImageView.bounds.size.width + CHATVIEW_DEFAULT_IMAGE_MESSAGE_GAP, 0, self.chatMessageView.bounds.size.width, height+self.fromWhomLabel.bounds.size.height+CHATVIEW_DEFAULT_MESSAGE_ADDRESS_GAP+self.sentFromWhereLabel.bounds.size.height+CHATVIEW_DEFAULT_ADDRESS_BOTTOM_GAP); 
    //self.fromWhomLabel.frame = CGRectMake(self.fromWhomLabel.frame.origin.x, 0, self.fromWhomLabel.frame.size.width, self.fromWhomLabel.frame.size.height);
    //self.sentFromWhereLabel.frame = CGRectMake(self.sentFromWhereLabel.frame.origin.x, 0, self.sentFromWhereLabel.frame.size.width, self.sentFromWhereLabel.frame.size.height);
    self.msgLabel.frame = CGRectMake(self.msgLabel.frame.origin.x, self.fromWhomLabel.bounds.size.height, 
                                     self.msgLabel.frame.size.width, height);
    self.sentFromWhereLabel.frame = CGRectMake(self.sentFromWhereLabel.frame.origin.x, self.fromWhomLabel.bounds.size.height+height+CHATVIEW_DEFAULT_MESSAGE_ADDRESS_GAP, self.sentFromWhereLabel.frame.size.width, self.sentFromWhereLabel.frame.size.height);
    msgBackground.frame = self.chatMessageView.bounds; //fill the chatMessageView
    
    bubbleImage = [[UIImage imageNamed:@"ChatBubbleGray.png"] stretchableImageWithLeftCapWidth:23 topCapHeight:15];
    
    msgBackground.image = bubbleImage;
    
    //recalculated the origin height 
    self.iconImageView.frame = CGRectMake(self.iconImageView.frame.origin.x, height+self.fromWhomLabel.bounds.size.height+CHATVIEW_DEFAULT_MESSAGE_ADDRESS_GAP+self.sentFromWhereLabel.bounds.size.height-self.iconImageView.bounds.size.height, self.iconImageView.bounds.size.width, self.iconImageView.bounds.size.height);
    self.iconImageView.image = image; 
    
    //add a black border for the image
    [self.iconImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.iconImageView.layer setBorderWidth: 2.0];
    
    self.fromWhomLabel.text = message.fromWhom;
    self.sentTimeLabel.text = [message.sendTime description];
    self.msgLabel.text = message.msgContent;
    self.sentFromWhereLabel.text = message.address;
}


- (void)dealloc {
    [iconImageView release];
    [contentView release];
    [chatMessageView release];
    [fromWhomLabel release];
    [sentTimeLabel release];
    [msgLabel release];
    [sentFromWhereLabel release];
    [backgroudImageView release];
    [super dealloc];
}
@end
