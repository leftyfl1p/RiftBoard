#include "RiftBoardSupportListController.h"

@implementation RiftBoardSupportListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"RiftBoardSupport" target:self] retain];
    }
    return _specifiers;
}

+ (NSString *)hb_supportEmailAddress {
	return @"leftyfl1p@me.com";
}

@end