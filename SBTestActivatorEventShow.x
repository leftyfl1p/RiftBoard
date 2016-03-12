#import "SBTestActivatorEventShow.h"

@implementation SBTestActivatorEventShow

+ (id)sharedInstance {
  static dispatch_once_t p = 0;
  __strong static id _sharedObject = nil;
   
  dispatch_once(&p, ^{
    _sharedObject = [[self alloc] init];
  });

  return _sharedObject;
}

- (id)init {

  //if (self = [super init]) {

  return self;
}


//pointless
- (void)activator:(LAActivator *)activator didChangeToEventMode:(NSString *)eventMode {
  //NSLog(@"ACTIVATOR MODEEEEEEEEEE: %@", eventMode);
  if([eventMode isEqualToString:@"springboard"]) {
    //NSLog(@"SPRINGBOARD MODEEEEEEE");
  }
}

- (NSString *)activator:(id)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
    return @"Show SBTest";
}

- (NSString *)activator:(id)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
    return @"shows sbtest. better description";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
    return @"SBTest";
}


- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
  return [NSArray arrayWithObjects:@"application", @"lockscreen", @"springboard", nil];
}

- (BOOL)activator:(LAActivator *)activator receiveUnlockingDeviceEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
  return NO;

}



- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {

    if([event.mode isEqualToString:@"application"]) {

      [[SBTest sharedInstance] show];
      [event setHandled:YES];
    } else {
      [event setHandled:NO];
    }

    
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event {
    HBLogInfo(@"abort event");
}


@end