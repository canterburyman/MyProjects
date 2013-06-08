//
//  ChatViewController.m
//  Conversation
//
//  Created by Xinjun Email on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCellWithLeftIcon.h"
#import "ChatCellWithRightIcon.h"
#import "MessageObject.h"

@interface ChatViewController ()

@end


#define MSG1 @"http://a007.stracking.com/RestHomeService/v0/json/UserQueryTrackers?auth_token=eeea6f7bebb9fea0846e7c4c34b6970f&updatetypes=1,3,15&times"
#define MSG2 @"msg2:Very good!\nSend from iphone"
#define MSG3 @"msg3:\nhow are you?\nSend from ipad"
#define MSG4 @"msg4:Very good!\nSend from iphone\n"
@implementation ChatViewController
@synthesize leftIconCell, rightIconCell;
@synthesize leftCellNib, rightCellNib;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray *) msgArray
{
    return [NSArray arrayWithObjects:MSG1, MSG2, MSG3, MSG4, nil];
}


- (MessageObject*)getMessageByIndex:(int) index
{
    MessageObject *message = [[[MessageObject alloc] init] autorelease];
    message.fromWhom = @"Xinjun";
    message.sendTime = [NSDate date];
    message.msgContent = [[self msgArray] objectAtIndex:index];
    message.address = @"send from:11/112 chuter avenue";
    return message;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.leftCellNib = [UINib nibWithNibName:@"ChatCellWithLeftIcon" bundle:nil];
    self.rightCellNib = [UINib nibWithNibName:@"ChatCellWithRightIcon" bundle:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageObject *message = [self getMessageByIndex:indexPath.row%4];
    CGFloat height = [message.msgContent sizeWithFont:[UIFont systemFontOfSize:CHATVIEW_kMessageFontSize]
                      constrainedToSize:CGSizeMake(CHATVIEW_DEFAULT_MESSAGE_WIDTH, CGFLOAT_MAX)
                      lineBreakMode:UILineBreakModeWordWrap].height;
    return 20.0 + height + CHATVIEW_DEFAULT_MESSAGE_ADDRESS_GAP+ 12.0 + CHATVIEW_DEFAULT_CELL_GAP; // 20.0f:fromWhomLabel.height and 12.0f:sentFromWhereLabel.heigth, come from the xib file 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChatCellWithLeftIcon";
    static NSString *CellIdentifier1 = @"ChatCellWithRightIcon";
    if (indexPath.row%2 == 0) {
        ChatCellWithLeftIcon *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        //create the cell
        if (cell == nil) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.leftCellNib instantiateWithOwner:self options:nil];
            cell = leftIconCell;
            self.leftIconCell = nil;
            cell.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        } 
        
        [cell fillContent:[self getMessageByIndex:indexPath.row%4] IconImage:[UIImage imageNamed:@"wxj.png"]];
        return cell;
    }
    else {
        ChatCellWithRightIcon *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        //create the cell
        if (cell == nil) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.rightCellNib instantiateWithOwner:self options:nil];
            cell = rightIconCell;
            self.rightIconCell = nil;
            cell.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        } 
        
        [cell fillContent:[self getMessageByIndex:indexPath.row%4] IconImage:[UIImage imageNamed:@"111-user.png"]];
        return cell;

    }
    return nil;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    UIImageView *msgBackground;
//    UILabel *msgText;
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                       reuseIdentifier:CellIdentifier] autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        // Create message background image view
//        msgBackground = [[UIImageView alloc] init];
//        msgBackground.clearsContextBeforeDrawing = NO;
//        msgBackground.tag = BACKGROUND_TAG;
//        msgBackground.backgroundColor = CHAT_BACKGROUND_COLOR; // clearColor slows performance
//        [cell.contentView addSubview:msgBackground];
//        [msgBackground release];
//        
//        // Create message text label
//        msgText = [[UILabel alloc] init];
//        msgText.clearsContextBeforeDrawing = NO;
//        msgText.tag = TEXT_TAG;
//        msgText.backgroundColor = [UIColor clearColor];
//        msgText.numberOfLines = 0;
//        msgText.lineBreakMode = UILineBreakModeWordWrap;
//        msgText.font = [UIFont systemFontOfSize:kMessageFontSize];
//        [cell.contentView addSubview:msgText];
//        [msgText release];
//    } else {
//        msgBackground = (UIImageView *)[cell.contentView viewWithTag:BACKGROUND_TAG];
//        msgText = (UILabel *)[cell.contentView viewWithTag:TEXT_TAG];
//    }
//    
//    // Configure the cell to show the message in a bubble. Layout message cell & its subviews.
//    UIImage *bubbleImage = nil;
//    if (indexPath.row == 0) { // right bubble
//        CGSize size = [MSG1 sizeWithFont:[UIFont systemFontOfSize:kMessageFontSize]
//                       constrainedToSize:CGSizeMake(kMessageTextWidth, CGFLOAT_MAX)
//                           lineBreakMode:UILineBreakModeWordWrap];
//
//        CGFloat editWidth = tableView.editing ? 32.0f : 0.0f;
//        msgBackground.frame = CGRectMake(tableView.frame.size.width-size.width-34.0f-editWidth,
//                                         kMessageFontSize-13.0f, size.width+34.0f,
//                                         size.height+12.0f);
//        bubbleImage = [[UIImage imageNamed:@"ChatBubbleGreen.png"]
//                       stretchableImageWithLeftCapWidth:15 topCapHeight:13];
//        msgText.frame = CGRectMake(tableView.frame.size.width-size.width-22.0f-editWidth,
//                                   kMessageFontSize-9.0f, size.width+5.0f, size.height);
//        msgBackground.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
//        msgText.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
//        
//        msgText.text = MSG1;
//    } 
//    else {
//        CGSize size = [MSG2 sizeWithFont:[UIFont systemFontOfSize:kMessageFontSize]
//                       constrainedToSize:CGSizeMake(kMessageTextWidth, CGFLOAT_MAX)
//                           lineBreakMode:UILineBreakModeWordWrap];
//        msgBackground.frame = CGRectMake(0.0f, kMessageFontSize-13.0f,
//                                         size.width+34.0f, size.height+12.0f);
//        bubbleImage = [[UIImage imageNamed:@"ChatBubbleGray.png"]
//                       stretchableImageWithLeftCapWidth:23 topCapHeight:15];
//        msgText.frame = CGRectMake(22.0f, kMessageFontSize-9.0f, size.width+5.0f, size.height);
//        msgBackground.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//        msgText.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//        msgText.text = MSG2;
//    }
//    msgBackground.image = bubbleImage;
//
//
//    
//    return cell;
//}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
