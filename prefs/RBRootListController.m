#include "RBRootListController.h"
#include <substrate.h>

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
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

+ (NSString *)hb_shareText {
	return [NSString stringWithFormat:@"I’m using the #RiftBoard beta on my %@ to use my homescreen icons in any app!", [UIDevice currentDevice].localizedModel];
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"https://cydia.saurik.com/package/com.leftyfl1p.springround"];
}

/*+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1];
}*/

-(void)updateInteractionSwitch {
	BOOL interactionValue = [[[self interactionSpecifier] propertyForKey:@"value"] boolValue];

	PSSpecifier *blurSpecifier = [_specifiersByID objectForKey:@"blur"];
	int blurValue = [[blurSpecifier propertyForKey:@"value"] intValue];

	//HBLogInfo(@"asdfasdfsad: %d", self.interactionSwitch.enabled);
	if (blurValue != 0) {
		[self.interactionSwitch setEnabled:NO];
		[self.interactionSwitch setOn:NO animated:YES];
	} else {
		[self.interactionSwitch setEnabled:YES];
		[self.interactionSwitch setOn:interactionValue animated:YES];
	}
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
	[super setPreferenceValue:value specifier:specifier];

	if ([[specifier propertyForKey:@"id"] isEqualToString:@"blur"]) {

		if (self.interactionSwitch.enabled)
		{
			[self flash];
		}
		[self updateInteractionSwitch];
	}

}

- (void)viewDidAppear:(BOOL)arg1 {
	[super viewDidAppear:arg1];

	[self updateInteractionSwitch];

}

-(PSSpecifier *)interactionSpecifier {
	return [_specifiersByID objectForKey:@"allowAppInteraction"];
}

-(UISwitch *)interactionSwitch {
	return [[self interactionSpecifier] propertyForKey:@"control"];
}


-(void)flash {
	UITableViewCell * interactionCell = [[self interactionSpecifier] propertyForKey:@"cellObject"];
	//UIView *background = [[UIView alloc] initWithFrame:interactionCell.frame];
	UIColor *backgroundColor = interactionCell.backgroundColor;

	[UIView animateWithDuration:0.05 animations:^{
		interactionCell.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
    	[UIView animateWithDuration:1.05 animations:^{
			interactionCell.backgroundColor = backgroundColor;
    	} completion:^(BOOL finished) {
    	
    	}];

    }];

}

@end
