@class Message;

@interface Conversation : NSManagedObject {

}

- (void)addMessages:(NSSet *)value;

@property (nonatomic, retain) id lastMessage;
@property (nonatomic, retain) NSSet *messages;

@end
