#import "SBTest.h"

#define isiOS10Up (kCFCoreFoundationVersionNumber >= 1333.2)
#define isiOS89 (kCFCoreFoundationVersionNumber >= 1129.15 && kCFCoreFoundationVersionNumber < 1333.2)

@implementation SBTest

+(id)sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init
{
    if (self = [super init])
    {        
        //get main springboard window
        self.SBWindow = MSHookIvar<SBWindow*>([%c(SBUIController) sharedInstance],"_window");
        //set contentView
        self.SBContentView = [[%c(SBUIController) sharedInstance] contentView];
        self.origWindowLevel = self.SBWindow.windowLevel;
    }
    return self;
}

//load everything here
-(void)show
{
    //cant open twice or open while app switcher is showing
    if(self.isActive || [[%c(SBUIController) sharedInstance] isAppSwitcherShowing])
        return;
        
    debug(@"Start Loading...");
    debug(@"handle initial rotation");
    //so springboard is in the correct orientation when loaded.
    if ([[RBPrefs sharedInstance] allowRotation] && [(SpringBoard *)[%c(SpringBoard) sharedApplication] homeScreenSupportsRotation])
    {
        [[SBTest sharedInstance] handleRotationWithDuration:0.0];
    }

    //light blur
    if([[RBPrefs sharedInstance] blurStyle] == 1)
    {
        self.blurView = [[CKBlurView alloc] initWithFrame:[[[%c(SBUIController) sharedInstance] contentView] bounds]];
        [self.blurView setAlpha:0.0f];
        [self.blurView setHidden:NO];
        //set blur view behind contentView
        [self.SBContentView.superview insertSubview:self.blurView belowSubview:self.SBContentView];

        //dark blur
    } else if([[RBPrefs sharedInstance] blurStyle] == 2)
    {
        //NC BLUR VIEW
        _UIBackdropViewSettings *settings = [%c(_UIBackdropViewSettingsNone) settingsForPrivateStyle:1];
        self.blurView = [[_UIBackdropView alloc] initWithFrame:[[[%c(SBUIController) sharedInstance] contentView] bounds] autosizesToFitSuperview:YES settings:settings];
        
        [self.blurView setAlpha:0.0f];
        [self.blurView setHidden:NO];
        
        [self.SBContentView.superview insertSubview:self.blurView belowSubview:self.SBContentView];
    }
    
    if(!self.blurView && ![[RBPrefs sharedInstance] allowAppInteraction])
    {
        //create transparent view. explain more how this works.
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        UIGraphicsBeginImageContextWithOptions(screenSize, NO, 0.0);
        UIImage *clearImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [[%c(SBUIController) sharedInstance] contentView].backgroundColor = [UIColor colorWithPatternImage:clearImage];
    }
    
    //get springboard status bar
    UIStatusBar *SBstatusBar = [(SpringBoard *)[%c(SpringBoard) sharedApplication] statusBar];
    //set level right under the status bar
    self.SBWindow.windowLevel = ((UIWindow *)[SBstatusBar statusBarWindow]).windowLevel - 1;
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.blurView setAlpha:1.0f];
        //show status bar
        [[%c(SpringBoard) sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    } completion:^(BOOL completed) {
        debug(@"completed");
    }];
    
    //show icons
    [[%c(SBUIController) sharedInstance] restoreContentAndUnscatterIconsAnimated:YES];
}

-(void)dismiss
{
    [self dismissWithBundleIdentifier:nil];
}

-(void)dismissWithBundleIdentifier:(NSString *)bundleIdentifier
{
    if(!self.isActive) return;
    
    debug(@"dismissing...");

    //animate views out
    [UIView animateWithDuration:0.2f animations:^{
        [self.SBContentView setAlpha:0.0f];
        //doesn't exist in 9.3, but couldn't get it to work smoothly anyways.
        //[[%c(SBIconController) sharedInstance] scatterAnimated:YES withCompletion:nil];
        [self.blurView setAlpha:0.0f];
        
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
        
        [self.blurView setHidden:YES];
        [self.blurView removeFromSuperview];
        self.blurView = nil;
        
        //put springboard back where we found it
        self.SBWindow.windowLevel = self.origWindowLevel;
        
        //reset legibility
        //[self updateLegibility];
        
        if(bundleIdentifier)
            [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleIdentifier suspended:NO];
    }];
    
    //make sure spotlight is closed
    if(isiOS89) [[%c(SBSearchViewController) sharedInstance] dismiss];

    if(isiOS10Up)
    {
        SBRootFolderController *_rootFolderController = MSHookIvar<SBRootFolderController *>([%c(SBIconController) sharedInstance], "_rootFolderController");
        SBHomeScreenPullDownSearchViewController *_pullDownSearchViewController = MSHookIvar<SBHomeScreenPullDownSearchViewController *>([_rootFolderController contentView], "_pullDownSearchViewController");
        [_pullDownSearchViewController dismissSearchViewWithReason:1];
    }

    //make sure folders are closed too
    if(isiOS89) [[%c(SBIconController) sharedInstance] closeFolderAnimated:YES];

    if(isiOS10Up)
    {
        [[%c(SBIconController) sharedInstance] closeFolderAnimated:YES withCompletion:nil];
    }
    //and deactivate reachability
    [(SpringBoard *)[%c(SpringBoard) sharedApplication] _deactivateReachability];
    [[%c(SBUIController) sharedInstance] tearDownIconListAndBar];

    //harbor ios 10 fix 
    if(isiOS10Up)
    {
        SBDockIconListView *dockListView = [[%c(SBIconController) sharedInstance] dockListView];
        if([dockListView respondsToSelector:@selector(collapseAnimated:)])
        {
            [dockListView collapseAnimated:YES];
        }
           
    }
    
}

-(void)handleRotationWithDuration:(double)duration
{
    //[(SpringBoard *)[%c(SpringBoard) sharedApplication] updateNativeOrientationWithOrientation:[(SpringBoard *)[%c(SpringBoard) sharedApplication] _frontMostAppOrientation] updateMirroredDisplays: YES];
    [[%c(SBUIController) sharedInstance] forceIconInterfaceOrientation:[(SpringBoard *)[%c(SpringBoard) sharedApplication] _frontMostAppOrientation] duration:duration];
    [[%c(SpringBoard) sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    if(self.blurView)
        [self.blurView setFrame:[[[%c(SBUIController) sharedInstance] contentView] bounds]];
}

-(void)handleRotation
{
    [self handleRotationWithDuration:0.4];
}

-(BOOL)isAsssignedToHomeButton
{
    for(LAEvent *event in [[LAActivator sharedInstance] eventsAssignedToListenerWithName:@"com.leftyfl1p.springround/show"])
    {
        if([event.name isEqualToString:@"libactivator.menu.press.single"])
        {
            debug(@"isAsssignedToHomeButton: YES");
            return YES;
        }
    }
    return NO;
}

-(BOOL)isInApplication
{
    return [[%c(SpringBoard) sharedApplication] _accessibilityFrontMostApplication] != nil;
}

//check if blur view is visible. make blur view not init everytime and just hide it
-(BOOL)isActive
{
    _isActive = self.SBWindow.windowLevel != self.origWindowLevel? YES : NO;   
    return _isActive;
}

//unused
-(void)updateLegibility
{
    [[%c(SBUIController) sharedInstance] _updateLegibility];
    [[%c(SBUIController) sharedInstance] updateStatusBarLegibility];
    [[%c(SBUIController) sharedInstance] wallpaperDidChangeForVariant:1];
}

-(void)showHomeButtonActivatorAlert
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"RiftBoard" message:nil preferredStyle:UIAlertControllerStyleAlert];

    if([[LAActivator sharedInstance] hasEventWithName:@"HomeButtonFixf"])
    {
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Open Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
        {
            [alert dismissViewControllerAnimated:YES completion:nil];
            NSURL *url = [NSURL URLWithString:@"prefs:root=RiftBoard"];
            [[UIApplication sharedApplication] openURL:url];
        }];
        [alert setMessage:@"Please assign this listener to the Single Press event under Home Button Fix in Activator."];
        [alert addAction:ok];

    }
    else
    {
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Open In Cydia" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
        {
            [alert dismissViewControllerAnimated:YES completion:nil];
            NSURL *url = [NSURL URLWithString:@"cydia://url/https://cydia.saurik.com/api/share#?source=https://leftyfl1p.github.io/&package=com.leftyfl1p.activatorfix"];
            [[UIApplication sharedApplication] openURL:url];
        }];
        [alert setMessage:@"Activator's Single (home button) Press is broken in 9.3. Please install an alternative event in Cydia to use the Single Press event."];
        [alert addAction:ok];
    }

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
    {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];

    [alert addAction:cancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end