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

  //dont use keywindow anymoref
  //get main springboard window
  _window = MSHookIvar<SBWindow*>([%c(SBUIController) sharedInstance],"_window");

  //init blur view
  //_blurView = [[CKBlurView alloc] initWithFrame:[[(SBUIController *)[%c(SBUIController) sharedInstance] contentView] bounds]];
  //_blurView = [[CKBlurView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  //[_blurView setAlpha:0.0f];
  //_blurView.hidden = YES;

  //set contentView
  _contentView = [(SBUIController *)[%c(SBUIController) sharedInstance] contentView];

  _beforeWindowLevel = -1.0f;

  }

  return self;
}



-(void)show {
  //load everything here

  //cant open twice or open while app switcher is showing
  if([self isActive] || [[%c(SBUIController) sharedInstance] isAppSwitcherShowing]) {
    return;
  }


  HBLogInfo(@"load SB TEST");

  //get rid of cast by making shreadinstance return the class instead of id

  if([[RBPrefs sharedInstance] useBlur]) {
    _blurView = [[CKBlurView alloc] initWithFrame:[[(SBUIController *)[%c(SBUIController) sharedInstance] contentView] bounds]];

    //animate it in
    //[_blurView setAlpha:0.0f];
    [_blurView setHidden:NO];

    //set blur view behind contentView
    [_contentView.superview insertSubview:_blurView belowSubview:_contentView];
  }

  if (![[RBPrefs sharedInstance] useBlur] && ![[RBPrefs sharedInstance] allowAppInteraction]){
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size; 
    UIGraphicsBeginImageContextWithOptions(screenSize, NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
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


    /************             SOLID BACKGROUND    *** *
  NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];

  NSString *imagePath = [bundle pathForResource:@"test" ofType:@"png"];

  UIImage *myImage = [UIImage imageWithContentsOfFile:imagePath];
*/
  //make this 1x1 px
  //[%c(SBUIController) sharedInstance].contentView.backgroundColor = [UIColor colorWithPatternImage:myImage];
  //////////[(SBUIController *)[%c(SBUIController) sharedInstance] contentView].backgroundColor = [UIColor redColor];//[UIColor colorWithPatternImage:myImage];
  //[(SBUIController *)[%c(SBUIController) sharedInstance] contentView].backgroundColor = [UIColor redColor];
  /************             SOLID BACKGROUND    *** */

  //on = YES;



  //UIView *test = [[UIView alloc] initWithFrame:[[(SBUIController *)[%c(SBUIController) sharedInstance] contentView] bounds]];


    //test.backgroundColor = UIColor.redColor;

    


    //[[%c(SpringBoard) sharedApplication] _revealSpotlight];


}

//change arg1 to just bundle id. maybe split into 2 methods?
-(void)dismiss {
  //HBLogInfo(@"DISMISS SB TEST");
  //HBLogInfo(@"_beforeWindowLevel:: %d", _beforeWindowLevel);
  //dismiss everything here

  //UIView *contentView = [(SBUIController *)[%c(SBUIController) sharedInstance] contentView];

  //HBLogInfo(@"springboard keywindow level from dismissWithApp: %f", [%c(SpringBoard) sharedApplication].keyWindow.windowLevel);


  //UIView *contentView = [(SBUIController *)[%c(SBUIController) sharedInstance] contentView];

  //check to see if active
  if(![self isActive]) {
    return;
  }
  HBLogInfo(@"DISMISS SB test continue");
  //animate views out
  [UIView animateWithDuration:0.2f animations:^{
    [_contentView setAlpha:0.0f];
    [_blurView setAlpha:0.0f];
    [[%c(SpringBoard) sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
  } completion:^(BOOL finished) {
    //HBLogInfo(@"clean up shit");
    //clean up

    //remove invisible image for app interaction
    [[%c(SBUIController) sharedInstance] contentView].backgroundColor = nil;

    [_blurView setHidden:YES];
    
    _blurView = nil;



    _window.windowLevel = _beforeWindowLevel;
    }];

    /*if something else fucks with the window level then dont touch it
    if([%c(SpringBoard) sharedApplication].keyWindow.windowLevel == _currentWindowLevel) {
      HBLogInfo(@"setting keyWindow level back to %f from _beforeWindowLevel", _beforeWindowLevel);
      [%c(SpringBoard) sharedApplication].keyWindow.windowLevel = _beforeWindowLevel;
    } else {
      HBLogInfo(@"something else touched window level so not resetting back to _beforeWindowLevel");
      HBLogInfo(@"_window: %f", _window.windowLevel);
      HBLogInfo(@"keyWindow: %f", [%c(SpringBoard) sharedApplication].keyWindow.windowLevel);
    }*/
    
    /*erase what we know
    _beforeWindowLevel = 0.0f;
    HBLogInfo(@"_beforeWindowLevel was reset to 0");*/

    /*_currentWindowLevel = 0.0f;
    HBLogInfo(@"_currentWindowLevel was reset to 0");*/
    
    

    
    //i think this is for the blur?
    //[(SBUIController *)[%c(SBUIController) sharedInstance] contentView].backgroundColor = nil;

    

    //i think springboard does this itself so we dont need to.
    //[_contentView setAlpha:1.0f];

  

  //not sure why this is needed.
  




}

-(void)dismissWithBundleIdentifier:(NSString *)bundleIdentifier {
  [self dismiss];
  if(bundleIdentifier) {
    [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleIdentifier suspended:NO];
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



//check if blur view is visible. make blur view not init everytime and just hide it
-(BOOL)isActive {
  //could maybe be improved

  //HBLogInfo(@"window level: %f", _window.windowLevel);

  /*HBLogInfo(@"_beforeWindowLevel:: %f", _beforeWindowLevel);

  if(!_beforeWindowLevel) {
    HBLogInfo(@"NO _beforeWindowLevel");
  }*/

  if(_window.windowLevel != _beforeWindowLevel) {
    _isActive = YES;
    HBLogInfo(@"is active");

  } else {
    _isActive = NO;
    HBLogInfo(@"isnt active");
  }

  return _isActive;

}






 


@end