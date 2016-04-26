#include "RiftBoardBlurListController.h"

@implementation RiftBoardBlurListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"RiftBoardBlur" target:self] retain];
    }
    return _specifiers;
}

@end