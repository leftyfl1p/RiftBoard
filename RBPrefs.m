#import "RBPrefs.h"

static id cSelf;

@implementation RBPrefs


+ (id)sharedInstance {
  static dispatch_once_t p = 0;
  __strong static id _sharedObject = nil;
   
  dispatch_once(&p, ^{
    _sharedObject = [[self alloc] init];
  });

  return _sharedObject;
}

- (id)init {

	 if (self = [super init]) {

	 	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		receivedNotification,
		CFSTR("com.leftyfl1p.springround/ReloadPrefs"),
		NULL,
		CFNotificationSuspensionBehaviorCoalesce);


	 	[self reloadPrefs];
	 }

	 //meh
	 cSelf = self;
	 return self;

}

static void receivedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	//self doesn't get passed into c methods. There is probably a better way of doing this.
	[cSelf reloadPrefs];
}

-(void)reloadPrefs {
	if(_debug)HBLogDebug(@"reloading prefs");
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.leftyfl1p.springround"];
    [preferences registerDefaults:@{
        @"blurStyle": @1,
        @"allowAppInteraction": @NO,
        @"useQuickHomeButtonDismiss": @YES,
        @"allowRotation": @NO,
        @"debug": @NO
    }];

    [self setBlurStyle:[[[preferences dictionaryRepresentation] objectForKey:@"blur"] intValue]]; 
    [self setAllowAppInteraction:[[[preferences dictionaryRepresentation] objectForKey:@"allowAppInteraction"] boolValue]];
    [self setUseQuickHomeButtonDismiss:[[[preferences dictionaryRepresentation] objectForKey:@"useQuickHomeButtonDismiss"] boolValue]];
    [self setAllowRotation:[[[preferences dictionaryRepresentation] objectForKey:@"allowRotation"] boolValue]];
    [self setDebug:[[[preferences dictionaryRepresentation] objectForKey:@"debug"] boolValue]];

    if(_debug)HBLogDebug(@"blurStyle: %d", _blurStyle);
    if(_debug)HBLogDebug(@"allowAppInteraction: %d", _allowAppInteraction);
    if(_debug)HBLogDebug(@"useQuickHomeButtonDismiss: %d", _useQuickHomeButtonDismiss);
    if(_debug)HBLogDebug(@"allowRotation: %d", _allowRotation);

}


@end