#import "SBTestActivatorEventShow.h"

@implementation SBTestActivatorEventShow

- (NSString *)activator:(id)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName
{
    return @"Show RiftBoard";
}

- (NSString *)activator:(id)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName
{
    return @"Opens RiftBoard in the current application.";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName
{
    return @"RiftBoard";
}

- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName
{
    return [NSArray arrayWithObjects:@"application", nil];
}

- (BOOL)activator:(LAActivator *)activator receiveUnlockingDeviceEvent:(LAEvent *)event forListenerName:(NSString *)listenerName
{
    return NO;   
}

- (UIImage *)activator:(LAActivator *)activator requiresSmallIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale
{
    return [UIImage imageWithContentsOfFile:@"/Library/Application Support/RiftBoard/icon-small.png"];
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
    if(![event.name isEqualToString:@"libactivator.menu.press.single"])
    {
        if([[SBTest sharedInstance] isActive])
        {
            [[SBTest sharedInstance] dismiss];
            [event setHandled:YES];
        }
        else
        {
            [[SBTest sharedInstance] show];
            [event setHandled:YES];
        }
        
    }
}

@end