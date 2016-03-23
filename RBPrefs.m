#import "RBPrefs.h"

static BOOL useBlur;
static BOOL allowAppInteraction;
static BOOL useHomeButton;
static BOOL useQuickHomeButtonDismiss;
static BOOL debugEnabled;
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

	 //not the best way.
	 cSelf = self;
	 return self;

}

static void receivedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	//self doesn't get passed into c methods.
	[cSelf reloadPrefs];
}

-(void)reloadPrefs {
	if(debugEnabled)HBLogDebug(@"reloading prefs");
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.leftyfl1p.springround"];
    [preferences registerDefaults:@{
        @"useBlur": @YES,
        @"allowAppInteraction": @NO,
        @"useHomeButton": @NO,
        @"useQuickHomeButtonDismiss": @YES,
        @"debug": @NO
    }];

    useBlur = [[[preferences dictionaryRepresentation] objectForKey:@"useBlur"] boolValue];
    allowAppInteraction = [[[preferences dictionaryRepresentation] objectForKey:@"allowAppInteraction"] boolValue];
    useHomeButton = [[[preferences dictionaryRepresentation] objectForKey:@"useHomeButton"] boolValue];
    useQuickHomeButtonDismiss = [[[preferences dictionaryRepresentation] objectForKey:@"useQuickHomeButtonDismiss"] boolValue];

    if(debugEnabled)HBLogDebug(@"useBlur: %d", useBlur);
    if(debugEnabled)HBLogDebug(@"allowAppInteraction: %d", allowAppInteraction);
    if(debugEnabled)HBLogDebug(@"useHomeButton: %d", useHomeButton);
    if(debugEnabled)HBLogDebug(@"useQuickHomeButtonDismiss: %d", useQuickHomeButtonDismiss);

}

-(BOOL)useBlur {
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

-(BOOL)debug {
	return debugEnabled;
}

-(void)setDebug:(BOOL)debug {
	debugEnabled = debug;
}


@end