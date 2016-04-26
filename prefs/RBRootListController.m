#include "RBRootListController.h"

@implementation RBRootListController

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

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1];
}

-(void)setBlurStyle:(NSString *)value {
	int val = [value intValue];
	HBLogInfo(@"value: %@", [value class]);

	PSSpecifier *interactionSpecifier = [_specifiersByID objectForKey:@"allowAppInteraction"];
	UISwitch *interactionSwitch = [interactionSpecifier propertyForKey:@"control"];

	if (val != 0) {
		HBLogInfo(@"value is not zero???");
		[interactionSwitch setEnabled:NO];
		[interactionSwitch setOn:NO];
	} else {
		[interactionSwitch setEnabled:YES];
		[interactionSwitch setOn:[[interactionSpecifier propertyForKey:@"value"] boolValue]];
	}

}

-(void)updateInteractionSwitch {
	PSSpecifier *interactionSpecifier = [_specifiersByID objectForKey:@"allowAppInteraction"];
	UISwitch *interactionSwitch = [interactionSpecifier propertyForKey:@"control"];
	BOOL interactionValue = [[interactionSpecifier propertyForKey:@"value"] boolValue];

	PSSpecifier *blurSpecifier = [_specifiersByID objectForKey:@"blur"];
	int blurValue = [[blurSpecifier propertyForKey:@"value"] intValue];
	HBLogInfo(@"blurValue: %d", blurValue);

	if (blurValue != 0) {
		[interactionSwitch setEnabled:NO];
		[interactionSwitch setOn:NO];
	} else {
		[interactionSwitch setEnabled:YES];
		[interactionSwitch setOn:interactionValue];
	}
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
	[super setPreferenceValue:value specifier:specifier];
	HBLogInfo(@"value: %@", value);
	
	if ([[specifier propertyForKey:@"id"] isEqualToString:@"blur"]) {

		[self updateInteractionSwitch];
		/*
		PSSpecifier *interactionSpecifier = [_specifiersByID objectForKey:@"allowAppInteraction"];
		UISwitch *interactionSwitch = [interactionSpecifier propertyForKey:@"control"];
		BOOL interactionValue = [[interactionSpecifier propertyForKey:@"value"] boolValue];

		int blurValue = [value intValue];

		if (blurValue != 0) {
			[interactionSwitch setEnabled:NO];
			[interactionSwitch setOn:NO];
		} else {
			[interactionSwitch setEnabled:YES];
			[interactionSwitch setOn:interactionValue];
		}*/

	}



}

-(UISwitch *)interactionSwitch {
	for (PSSpecifier *specifier in [self specifiers]) {
		if ([[specifier propertyForKey:@"control"] isKindOfClass:[UISwitch class]] && [[specifier propertyForKey:@"key"] isEqualToString:@"allowAppInteraction"]) {
			return [specifier propertyForKey:@"control"];
		}
	}

	return nil;
}

- (void)viewDidAppear:(BOOL)arg1 {
	[super viewDidAppear:arg1];

	PSSpecifier *blurSpecifier = [_specifiersByID objectForKey:@"blur"];
	//int blurValue = [[blurSpecifier propertyForKey:@"value"] intValue];
	[self setBlurStyle:[blurSpecifier propertyForKey:@"value"]];
}

@end
