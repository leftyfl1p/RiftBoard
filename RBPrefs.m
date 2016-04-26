#import "RBPrefs.h"

static BOOL useBlur;
static BOOL allowAppInteraction;
static BOOL useHomeButton;
static BOOL useQuickHomeButtonDismiss;
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
	//self doesn't get passed into c methods.
	[cSelf reloadPrefs];
}

-(void)reloadPrefs {
	if(_debug)HBLogDebug(@"reloading prefs");
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.leftyfl1p.springround"];
    [preferences registerDefaults:@{
        @"blur": @1,
        @"allowAppInteraction": @NO,
        @"useHomeButton": @NO,
        @"useQuickHomeButtonDismiss": @YES,
        @"debug": @NO
    }];

    [self setBlurStyle:[[[preferences dictionaryRepresentation] objectForKey:@"blur"] intValue]]; 
    //useBlur = [[[preferences dictionaryRepresentation] objectForKey:@"blur"] boolValue];
    allowAppInteraction = [[[preferences dictionaryRepresentation] objectForKey:@"allowAppInteraction"] boolValue];
    useHomeButton = [[[preferences dictionaryRepresentation] objectForKey:@"useHomeButton"] boolValue];
    useQuickHomeButtonDismiss = [[[preferences dictionaryRepresentation] objectForKey:@"useQuickHomeButtonDismiss"] boolValue];

    if(_debug)HBLogDebug(@"useBlur: %d", useBlur);
    if(_debug)HBLogDebug(@"allowAppInteraction: %d", allowAppInteraction);
    if(_debug)HBLogDebug(@"useHomeButton: %d", useHomeButton);
    if(_debug)HBLogDebug(@"useQuickHomeButtonDismiss: %d", useQuickHomeButtonDismiss);

}

-(BOOL)blurStyle {
	return useBlur;
}

-(void)setUseBlur:(BOOL)blur {
	useBlur = blur;
}


-(BOOL)allowAppInteraction {
	return allowAppInteraction;
}

-(void)setAllowAppInteraction:(BOOL)interaction {
	allowAppInteraction = interaction;
}


-(BOOL)useHomeButton {
	return useHomeButton;
}

-(void)setUseHomeButton:(BOOL)homeButton {
	useHomeButton = homeButton;
}


-(BOOL)useQuickHomeButtonDismiss {
	return useQuickHomeButtonDismiss;
}

-(void)setUseQuickHomeButtonDismiss:(BOOL)homeButtonDismiss {
	useQuickHomeButtonDismiss = homeButtonDismiss;
}


@end