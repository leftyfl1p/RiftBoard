#import "SBTestActivatorEventDismiss.h"

@implementation SBTestActivatorEventDismiss

- (NSString *)activator:(id)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
    return @"Dismiss RiftBoard";
}

- (NSString *)activator:(id)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
    return @"Closes RiftBoard.";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
    return @"RiftBoard";
}

- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
  return [NSArray arrayWithObjects:@"application", nil];
}

- (BOOL)activator:(LAActivator *)activator receiveUnlockingDeviceEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
  return NO;
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
  [[SBTest sharedInstance] dismiss];
  [event setHandled:YES];
}

@end