#import "RBPreviewCell.h"
 
@implementation RBPreviewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier specifier:specifier];
	if (self) {
		[self setBackgroundColor:[UIColor blueColor]];

		CPDistributedMessagingCenter *messagingCenter;
		messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.leftyfl1p.springround"];
		 
		// Two-way (wait for reply)
		NSDictionary *reply;
		reply = [messagingCenter sendMessageAndReceiveReplyName:@"ContentViewImage" userInfo:nil];
		UIImage *image = [UIImage imageWithData:[reply objectForKey:@"image"]];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		[self addSubview:imageView];

	}
	return self;
}

@end