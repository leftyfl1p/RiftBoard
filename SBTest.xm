#import "SBTest.h"


@implementation SBTest


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

  //get main springboard window
  _window = MSHookIvar<SBWindow*>([%c(SBUIController) sharedInstance],"_window");

  //set contentView
  _contentView = [(SBUIController *)[%c(SBUIController) sharedInstance] contentView];

  _beforeWindowLevel = _window.windowLevel;

  }

  return self;
}



-(void)show {
  //load everything here

  //cant open twice or open while app switcher is showing
  if([self isActive] || [[%c(SBUIController) sharedInstance] isAppSwitcherShowing]) {
    return;
  }


  if([[RBPrefs sharedInstance] debug])HBLogInfo(@"RiftBoard: Start Loading...");

  //get rid of cast by making shreadinstance return the class instead of id
  //???????

  if([[RBPrefs sharedInstance] BlurStyle] == 1) {
    _blurView = [[CKBlurView alloc] initWithFrame:[[(SBUIController *)[%c(SBUIController) sharedInstance] contentView] bounds]];
    
    /* apple
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    //UIVisualEffectView *visualEffectView;
    _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    _blurView.frame = [[(SBUIController *)[%c(SBUIController) sharedInstance] contentView] bounds];*/


    //_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2060];

    

    //[settings setColorTint:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
    //[settings setColorTint:[_UIBackdropViewSettings darkeningTintColor]];
    
    //[settings setColorTint:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1]];
    //[settings setRequiresColorStatistics:YES];
    //[settings setUsesColorTintView:YES];
    //[settings setColorTintAlpha:0.8];
    //[settings setColorTintMaskAlpha:0.7];
    //[settings setGrayscaleTintLevel:0];
    //[settings setGrayscaleTintAlpha:0];
    //[settings setUsesGrayscaleTintView:NO];

    // initialization of the blur view
    
    
    // another way for initialization
    //_UIBackdropView *blurView = [[_UIBackdropView alloc] initWithSettings:settings];
     
    // or without settings object implementation
    //_UIBackdropView *blurView = [[_UIBackdropView alloc] initWithStyle:2060];


    //[imageView addSubview:visualEffectView];
    //animate it in
    [_blurView setAlpha:0.0f];
    [_blurView setHidden:NO];

    //set blur view behind contentView
    [_contentView.superview insertSubview:_blurView belowSubview:_contentView];

  //dark blur
  } else if([[RBPrefs sharedInstance] BlurStyle] == 2) {
    //NC BLUR VIEW
    _UIBackdropViewSettings *settings = [%c(_UIBackdropViewSettingsNone) settingsForPrivateStyle:1];
    _blurView = [[_UIBackdropView alloc] initWithFrame:[[(SBUIController *)[%c(SBUIController) sharedInstance] contentView] bounds] autosizesToFitSuperview:YES settings:settings];

    [_blurView setAlpha:0.0f];
    [_blurView setHidden:NO];

    [_contentView.superview insertSubview:_blurView belowSubview:_contentView];

  }

  if (!_blurView && ![[RBPrefs sharedInstance] allowAppInteraction]){
    //create transparent view. explain more how this works.
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size; 
    UIGraphicsBeginImageContextWithOptions(screenSize, NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext(); //leak? cuz no destroy ref
    UIGraphicsEndImageContext();
    [[%c(SBUIController) sharedInstance] contentView].backgroundColor = [UIColor colorWithPatternImage:blank];
  }

  //get springboard status bar
  UIStatusBar *status = [(SpringBoard *)[%c(SpringBoard) sharedApplication] statusBar];
 
  //HBLogInfo(@"setting keyWindow level to under status bar:%f", ((UIWindow *)[status statusBarWindow]).windowLevel - 1);

  //set level right under the status bar
  _window.windowLevel = ((UIWindow *)[status statusBarWindow]).windowLevel - 1;

  


  [UIView animateWithDuration:0.3f animations:^{
    [_blurView setAlpha:1.0f];
    //show status bar
    [[%c(SpringBoard) sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    } completion:^(BOOL completed) {
        HBLogInfo(@"completed");
    }];


  //reveal icons
  [[%c(SBUIController) sharedInstance] restoreContentAndUnscatterIconsAnimated:YES];


}

//change arg1 to just bundle id. maybe split into 2 methods?
-(void)dismiss {
  [self dismissWithBundleIdentifier:nil];
}

-(void)dismissWithBundleIdentifier:(NSString *)bundleIdentifier {
  //[self dismiss];
   if(![self isActive]) {
    return;
  }
  if([[RBPrefs sharedInstance] debug])HBLogInfo(@"RiftBoard: dismissing...");
  //animate views out
  [UIView animateWithDuration:0.2f animations:^{
    [_contentView setAlpha:0.0f];
    [_blurView setAlpha:0.0f];

    /* hax >:/
    need to hide status bar here so animation is in sync with
    others but at this moment in time riftboard is active.
    setStatusBarHidden:withAnimation: won't hide unless
    riftboard isn't active because springboard likes to
    try to hide the sb statusbar whenever it thinks it
    shouldnt be active (or whenever riftboard IS active).

    So the shitty solution is to send an out of bound enum
    to the animation param and to handle it as we would want
    it to before the real implementation is ran.

    I can't find any other methods that overrides this to run
    that instead, but maybe I'm just an idiot and this is a
    complete oversight by me.
    */
    [[%c(SpringBoard) sharedApplication] setStatusBarHidden:YES withAnimation:1337];
  } completion:^(BOOL finished) {
    //HBLogInfo(@"clean up shit");
    //clean up

    //remove invisible image for app interaction
    [[%c(SBUIController) sharedInstance] contentView].backgroundColor = nil;

    [_blurView setHidden:YES];
    
    _blurView = nil;


    //put springboard back where we found it
    _window.windowLevel = _beforeWindowLevel;

    if(bundleIdentifier) {
      [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleIdentifier suspended:NO];
    }
    }];

    //make sure spotlight is closed
    [[%c(SBSearchViewController) sharedInstance] dismiss];

    //make sure folders are closed too
    [[%c(SBIconController) sharedInstance] closeFolderAnimated:YES];

    //and deactivate reachability 
    [(SpringBoard *)[%c(SpringBoard) sharedApplication] _deactivateReachability];
  

}

-(void)handleRotation {
  //[(SpringBoard *)[%c(SpringBoard) sharedApplication] updateNativeOrientationWithOrientation:[(SpringBoard *)[%c(SpringBoard) sharedApplication] _frontMostAppOrientation] updateMirroredDisplays: YES];
  [[%c(SBUIController) sharedInstance] forceIconInterfaceOrientation:[(SpringBoard *)[%c(SpringBoard) sharedApplication] _frontMostAppOrientation] duration:0.4];
  [[%c(SpringBoard) sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
  if(_blurView) {
    [_blurView setFrame:[[(SBUIController *)[%c(SBUIController) sharedInstance] contentView] bounds]];
  }
}

/*-(void)fixWindowShit {
  if([%c(SpringBoard) sharedApplication].keyWindow.windowLevel != -1.0f) {
    HBLogInfo(@"windowfix: window wasnt -1: %f", [%c(SpringBoard) sharedApplication].keyWindow.windowLevel);
    [%c(SpringBoard) sharedApplication].keyWindow.windowLevel = -1.0f;
  } else {
    HBLogInfo(@"windowfix: window is -1");
  }
}*/

-(BOOL)asssignedToHomeButton {
  for(LAEvent *event in [[LAActivator sharedInstance] eventsAssignedToListenerWithName:@"com.leftyfl1p.sbtest/show"]) {
      if([event.name isEqualToString:@"libactivator.menu.press.single"]) {
        if([[RBPrefs sharedInstance] debug])HBLogDebug(@"single home button assigned, returning YES.");
        return YES;
      }
    }
    return NO;
}

-(BOOL)isInApplication {
  return [[%c(SpringBoard) sharedApplication] _accessibilityFrontMostApplication] != nil;
}


//check if blur view is visible. make blur view not init everytime and just hide it
-(BOOL)isActive {

  _window.windowLevel != _beforeWindowLevel? _isActive = YES : _isActive = NO;

  return _isActive;

}


-(void)flip {
  

   CGColor *_blurColor = MSHookIvar<CGColor*>([%c(_SBIconWallpaperColorProvider) sharedInstance],"_blurColor");
   //[_blurColor colorWithRed:0x33/255.0 green:0 blue:0x99/255.0 alpha:1.0]
   //_blurColor = [UIColor blueColor].CGColor;
   //_blurColor = MSHookIvar<CGColor*>([%c(_SBIconWallpaperColorProvider) sharedInstance],"_blurColor");
    HBLogDebug(@"asdf1: %@", [UIColor colorWithCGColor:_blurColor]);
    HBLogDebug(@"asdf: %@", _blurColor);

   NSHashTable *_clients = MSHookIvar<NSHashTable*>([%c(_SBIconWallpaperColorProvider) sharedInstance],"_clients");
   HBLogDebug(@"clients: %@", _clients);

   //CGColor *_blurColor2 = MSHookIvar<CGColor*>([%c(_SBIconWallpaperColorProvider) sharedInstance],"_blurColor");

  // HBLogDebug(@"asdf: %@", [UIColor colorWithCGColor:_blurColor2]);

  CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.apple.accessibility.cache.enhance.text.legibility"), NULL, NULL, YES);
  CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.apple.accessibility.increase.button.legibility"), NULL, NULL, YES);
  CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.apple.accessibility.text.legibility.status"), NULL, NULL, YES);
}

//check in frontmost changed if app is something because might be able to get aroudn when trying ot activate when app is loading then

 


@end