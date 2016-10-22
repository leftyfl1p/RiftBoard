#include "RBRootListController.h"
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@implementation RBRootListController

- (id)init {
    if (self = [super init]) {
        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1];
        self.hb_appearanceSettings = appearanceSettings;
    }
    return self;
}


- (NSArray *)specifiers {
	return [super specifiers];
}

+(NSString *)hb_specifierPlist {
	return @"Root";
}

+ (NSString *)hb_shareText {
	return @"I’m using #RiftBoard to use my homescreen icons in any app!";
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"https://cydia.saurik.com/package/com.leftyfl1p.springround"];
}

-(void)updateInteractionSwitch
{
	BOOL interactionValue = [[[self interactionSpecifier] propertyForKey:@"value"] boolValue];
	PSSpecifier *blurSpecifier = [_specifiersByID objectForKey:@"blur"];
	int blurValue = [[blurSpecifier propertyForKey:@"value"] intValue];
	if (blurValue != 0) {
		[self.interactionSwitch setEnabled:NO];
		[self.interactionSwitch setOn:NO animated:YES];
	} else {
		[self.interactionSwitch setEnabled:YES];
		[self.interactionSwitch setOn:interactionValue animated:YES];
	}
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier
{
	[super setPreferenceValue:value specifier:specifier];
	if ([[specifier propertyForKey:@"id"] isEqualToString:@"blur"]) {
		// for some reason animations aren't working on iPad
		if (self.interactionSwitch.enabled && !isiPad)
		{
			[self flash];
		}
		[self updateInteractionSwitch];
	}

}

-(void)viewDidLoad {
	[super viewDidLoad];
	//solves issue when app re-enters foreground and viewDidAppear isn't called.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
	if(isiPad)
	{
		//interaction specifier doesnt have control (UISwitch) property until after viewdidload.
		[self performSelector:@selector(updateInteractionSwitch) withObject:self afterDelay:0.2];
	}
	else
	{
		[self updateInteractionSwitch];
	}
	
	
}


- (void)appWillEnterForeground:(NSNotification *)notification
{
    [self updateInteractionSwitch];
}

- (void)viewDidAppear:(BOOL)arg1
{
	[super viewDidAppear:arg1];
	[self updateInteractionSwitch];
}

-(PSSpecifier *)interactionSpecifier
{
	return [_specifiersByID objectForKey:@"allowAppInteraction"];
}

-(UISwitch *)interactionSwitch
{
	return [[self interactionSpecifier] propertyForKey:@"control"];
}

//rename
-(void)flash
{
	UITableViewCell *interactionCell = [[self interactionSpecifier] propertyForKey:@"cellObject"];
	UIColor *backgroundColor = interactionCell.backgroundColor;
	[UIView animateWithDuration:0.05 animations:^{
		interactionCell.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
    	[UIView animateWithDuration:1.05 animations:^{
			interactionCell.backgroundColor = backgroundColor;
    	} completion:nil];

    }];

}

@end
