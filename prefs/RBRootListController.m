#include "RBRootListController.h"

@implementation RBRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

+ (NSString *)hb_shareText {
	return [NSString stringWithFormat:@"I’m using RiftBoard on my %@ to use my homescreen on top of any app!", [UIDevice currentDevice].localizedModel];
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"https://cydia.saurik.com/package/com.leftyfl1p.springround"];
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1];
}

@end
