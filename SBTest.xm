#import "SBTest.h"


@implementation SBTest


+(id)sharedInstance {
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
        _contentView = [[%c(SBUIController) sharedInstance] contentView];
        
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
    
    
    debug(@"RiftBoard: Start Loading...");
    
    //get rid of cast by making shreadinstance return the class instead of id
    //???????
    /// [[(SBUIController *)[%c(SBUIController) sharedInstance]
    
    //light blur
    if([[RBPrefs sharedInstance] blurStyle] == 1) {
        _blurView = [[CKBlurView alloc] initWithFrame:[[[%c(SBUIController) sharedInstance] contentView] bounds]];
        
        [_blurView setAlpha:0.0f];
        [_blurView setHidden:NO];
        
        //set blur view behind contentView
        [_contentView.superview insertSubview:_blurView belowSubview:_contentView];
        
        //dark blur
    } else if([[RBPrefs sharedInstance] blurStyle] == 2) {
        //NC BLUR VIEW
        _UIBackdropViewSettings *settings = [%c(_UIBackdropViewSettingsNone) settingsForPrivateStyle:1];
        _blurView = [[_UIBackdropView alloc] initWithFrame:[[[%c(SBUIController) sharedInstance] contentView] bounds] autosizesToFitSuperview:YES settings:settings];
        
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
    
    //set level right under the status bar
    _window.windowLevel = ((UIWindow *)[status statusBarWindow]).windowLevel - 1;
    
    [UIView animateWithDuration:0.3f animations:^{
        [_blurView setAlpha:1.0f];
        //show status bar
        [[%c(SpringBoard) sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    } completion:^(BOOL completed) {
        debug(@"completed");
    }];
    
    //reveal icons
    [[%c(SBUIController) sharedInstance] restoreContentAndUnscatterIconsAnimated:YES];
}

-(void)dismiss {
    [self dismissWithBundleIdentifier:nil];
}

-(void)dismissWithBundleIdentifier:(NSString *)bundleIdentifier {
    //[self dismiss];
    if(![self isActive]) return;
    
    debug(@"dismissing...");
    //animate views out
    [UIView animateWithDuration:0.2f animations:^{
        [_contentView setAlpha:0.0f];
        //[[%c(SBIconController) sharedInstance] scatterAnimated:YES withCompletion:nil];
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
        //clean up
        debug(@"start cleaning up");
        
        //remove invisible image for app interaction
        [[%c(SBUIController) sharedInstance] contentView].backgroundColor = nil;
        
        [_blurView setHidden:YES];
        
        _blurView = nil;
        
        //put springboard back where we found it
        _window.windowLevel = _beforeWindowLevel;
        
        //reset legibility
        [self updateLegibility];
        
        if(bundleIdentifier)
        {
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
        [_blurView setFrame:[[[%c(SBUIController) sharedInstance] contentView] bounds]];
    }
}

-(BOOL)asssignedToHomeButton {
    for(LAEvent *event in [[LAActivator sharedInstance] eventsAssignedToListenerWithName:@"com.leftyfl1p.sbtest/show"]) {
        if([event.name isEqualToString:@"libactivator.menu.press.single"]) {
            debug(@"single home button assigned, returning YES.");
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
    
    _isActive = _window.windowLevel != _beforeWindowLevel? YES : NO;
    
    return _isActive;
    
}

-(void)updateLegibility {
    [[%c(SBUIController) sharedInstance] _updateLegibility];
    [[%c(SBUIController) sharedInstance] updateStatusBarLegibility];
    [[%c(SBUIController) sharedInstance] wallpaperDidChangeForVariant:1];
}


@end