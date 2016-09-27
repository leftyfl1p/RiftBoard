#define debug(text, ...) if([[RBPrefs sharedInstance] debug]) HBLogDebug((text), ##__VA_ARGS__)

@interface SBWindow : UIWindow
@end

@interface SBApplication : NSObject
// @property(copy) NSString* displayIdentifier;
@property(copy) NSString* bundleIdentifier;
// //@property(copy, nonatomic, setter=_setDeactivationSettings:) SBDeactivationSettings *_deactivationSettings;
// - (id)valueForKey:(id)arg1;
// - (NSString *)displayName;
// - (int)pid;
// - (id)mainScene;
// - (NSString *)path;
// - (id)mainScreenContextHostManager;
// - (void)setDeactivationSetting:(unsigned int)setting value:(id)value;
// - (void)setDeactivationSetting:(unsigned int)setting flag:(BOOL)flag;
// - (id)bundleIdentifier;
// - (id)displayIdentifier;
// - (void)notifyResignActiveForReason:(int)reason;
// - (void)notifyResumeActiveForReason:(int)reason;
// - (void)activate;
// - (void)setFlag:(long long)arg1 forActivationSetting:(unsigned int)arg2;
// - (BOOL)statusBarHidden;

// -(id)statusBarStyleRequest;
@end

// @interface SBApplicationController : NSObject
// + (id)sharedInstance;
// - (id)applicationWithBundleIdentifier:(NSString *)bid;
// @end


// @interface FBWindowContextHostManager : NSObject
// - (void)enableHostingForRequester:(id)arg1 orderFront:(BOOL)arg2;
// - (void)enableHostingForRequester:(id)arg1 priority:(int)arg2;
// - (void)disableHostingForRequester:(id)arg1;
// - (id)hostViewForRequester:(id)arg1 enableAndOrderFront:(BOOL)arg2;
// @end

// @interface FBSMutableSceneSettings
// - (void)setBackgrounded:(bool)arg1;
// @end

// @interface FBScene
// - (id)contextHostManager;
// - (id)mutableSettings;
// -(void)_applyMutableSettings:(id)arg1 withTransitionContext:(id)arg2 completion:(id)arg3;
// @end


// @interface UIApplication (Private) 
// - (void)_relaunchSpringBoardNow;
// - (id)_accessibilityFrontMostApplication;
// - (void)launchApplicationWithIdentifier: (NSString*)identifier suspended: (BOOL)suspended;
// - (id)displayIdentifier;
// - (void)setStatusBarHidden:(bool)arg1 animated:(bool)arg2;
// void receivedStatusBarChange(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo);
// void receivedLandscapeRotate();
// void receivedPortraitRotate();
// @end

@interface SBUIController : NSObject {
	SBWindow* _window;
	// UIView* _iconsView;
}

- (void)restoreContentAndUnscatterIconsAnimated:(BOOL)animated;
// -(void)activateApplicationAnimated:(id)arg1 ;
// +(SBUIController *)sharedInstance;
// -(void)activateApplicationAnimatedFromIcon:(id)arg1 fromLocation:(int)arg2;
// -(id)window;
// -(UIView *)contentView;
// -(BOOL)isHandlingHomeButtonPress;
-(void)tearDownIconListAndBar;
// -(void)_deviceLockStateChanged:(id)arg1 ;
// -(BOOL)clickedMenuButton;
// -(void)_ignoreEvents;
// -(int)_dismissSheetsAndDetermineAlertStateForMenuClickOrSystemGesture;
-(BOOL)isAppSwitcherShowing;
// -(BOOL)handleMenuDoubleTap;

- (void)forceIconInterfaceOrientation:(long long)arg1 duration:(double)arg2;
// - (void)setFakeSpringBoardStatusBarVisible:(_Bool)arg1;

@end

@interface SBUIController (iOS8)
-(BOOL)_activateAppSwitcher;

@end

//unused
@interface SBUIController (iOS933) //find out when these were really added
-(void)_updateLegibility;
-(void)updateStatusBarLegibility;
-(void)wallpaperDidChangeForVariant:(long long)arg1;
-(id)_legibilitySettings;

@end

@interface SpringBoard
-(void)_menuButtonUp:(id)arg1;
-(BOOL)isLocked;
-(BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2 ;
// -(void)_rotateView:(id)arg1 toOrientation:(int)arg2;
// -(void)showSpringBoardStatusBar;
-(id)statusBar;
// -(int)interfaceOrientationForCurrentDeviceOrientation;
// -(long long)activeInterfaceOrientation;
// -(void)noteInterfaceOrientationChanged:(int)arg1 duration:(float)arg2 ;
// -(SBApplication *)_accessibilityFrontMostApplication;
// -(id)_accessibilityTopDisplay;
// -(id)_accessibilityRunningApplications;
// //-(int)_frontMostAppOrientation;
// -(void)_revealSpotlight;
- (void)_deactivateReachability;
// -(BOOL)isLocked;
-(BOOL)homeScreenSupportsRotation;



//rotation
- (long long)_frontMostAppOrientation;


@end

@interface UIApplication (extras)
-(id)_accessibilityFrontMostApplication;
// -(id)_accessibilityTopDisplay;
// -(id)_accessibilityRunningApplications;
-(BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2 ;
// -(void)_revealSpotlight;
@end

@interface UIStatusBar
-(id)statusBarWindow;
// -(void)setHidden:(BOOL)arg1 ;
// -(void)setStatusBarWindow:(id)arg1 ;
@end


@interface SBIconController : NSObject {
	BOOL _showingSearch;
}
+(id)sharedInstance;
-(void)iconTapped:(id)arg1 ;
-(void)handleHomeButtonTap;

-(void)closeFolderAnimated:(BOOL)arg1;

// //using
-(void)setIsEditing:(BOOL)arg1 ;

// //using
-(BOOL)hasOpenFolder;

// //using
-(BOOL)isEditing;

// - (_Bool)dismissSpotlightAnimated:(_Bool)arg1;

// //using
// - (_Bool)iconShouldAllowTap:(id)arg1;

// - (void)scatterAnimated:(_Bool)arg1 withCompletion:(id)arg2;




-(void)openFolder:(id)arg1 animated:(BOOL)arg2;



// -(id)rootFolder;

-(id)_rootFolderController;

// - (void)removeAllIconAnimations;
// - (_Bool)isAnimatingForUnscatter;

@end

@interface SBIcon : NSObject
// -(id)applicationBundleID;
@end


// @interface SBIconView : UIView
// @property (nonatomic,retain) SBIcon * icon; 

// @end



@interface SBFolderIcon : SBIcon
-(void)launchFromLocation:(int)arg1 ;
-(id)folder;
@end


@interface SBFolderIconView
-(id)folder;
@end




// @interface SBSecureWindow : SBWindow
// +(BOOL)_isSecure;
// @end

// @interface SBWallpaperController : NSObject {
// 	UIWindow* _wallpaperWindow;
// }
// //-(void)setWindowLevel:(double)arg1 ;
// -(void)beginRequiringWithReason:(id)arg1 ;

// -(void)setHomescreenWallpaperScale:(double)arg1 ;

// @end


// @interface SBAppWindow : UIWindow

// @end

// @interface SBIconScrollView : UIScrollView

// @end


// @interface SBUIMainScreenAnimationController : NSObject {

// }
// -(id)initWithActivatingApp:(id)arg1 deactivatingApp:(id)arg2 ;


// @end

// @interface SBUIAnimationZoomUpApp : SBUIMainScreenAnimationController {
// }
// @property (assign,nonatomic) long long animationTransition;              //@synthesize animationTransition=_animationTransition - In the implementation block
// -(void)prepareZoom;
// -(double)animationDelay;
// -(void)animateZoomWithCompletion:(/*^block*/id)arg1 ;
// -(void)_prepareAnimation;
// -(void)_cleanupAnimation;
// -(id)_animationProgressDependency;
// -(void)_applicationDependencyStateChanged;
// -(id)initWithActivatingApp:(id)arg1 ;
// -(void)animateFakeStatusBarWithParameters:(id)arg1 ;
// -(void)cleanupZoom;
// -(void)_maybeStartCrossfade;
// -(void)_noteContextHostCrossfadeDidFinish;
// -(void)_maybeReportAnimationFinished;
// -(BOOL)_waitsForApplicationActivationIfNecessary;
// -(BOOL)isReasonableMomentToInterrupt;
// -(void)_noteZoomDidFinish;
// -(id)appStatusBarTransitionInfoWithStartStyleRequest:(id)arg1 startOrientation:(long long)arg2 ;
// -(void)noteDependencyDidInvalidate;
// -(BOOL)_shouldWaitForSiriDismissBeforeZooming;
// -(long long)animationTransition;
// -(void)setAnimationTransition:(long long)arg1 ;
// -(void)_startAnimation;
// -(void)dealloc;
// -(double)animationDuration;

// @end

@interface SBAssistantController : NSObject
// +(BOOL)shouldEnterAssistant;
+(BOOL)isAssistantVisible;

@end

@interface SBFolderView : UIView {
	//SBIconListPageControl* _pageControl;
}

//ios 8.4
//@property (nonatomic,readonly) long long currentPageIndex;

//8.3 NEEDS THIS
@property(readonly, assign, nonatomic) int currentPageIndex;
@end

@interface SBRootFolderView : SBFolderView

@end

@interface SBRootFolderController : NSObject

//@property (nonatomic,retain) SBRootFolder * folder; 
@property (nonatomic,retain,readonly) SBRootFolderView * contentView; 

@end


// @interface SBSearchViewController : UIViewController
// // +(id)sharedInstance;
// // -(void)dismiss;
// // -(BOOL)isVisible;

// @end


// @interface SBLaunchAppListener : NSObject
// - (id)initWithBundleIdentifier:(id)arg1 handlerBlock:(id /* block */)arg2;

// @end


@interface SPSearchResult
// -(id)initWithData:(id)arg1 ;
// -(void)setTitle:(id)arg1 ;
// -(void)setUrl:(id)arg1 ;
-(NSString *)url;
@end

@interface SBSearchResultsAction
-(SPSearchResult *)result;
@end


// @interface SBDeckSwitcherViewController
// - (void)viewDidLoad;

// @end



// @interface SBBookmark
// // @property(readonly, retain, nonatomic) NSURL *launchURL;
// // -(BOOL)icon:(id)arg1 launchFromLocation:(int)arg2 context:(id)arg3;

// @end

@interface SBLeafIcon : SBIcon
- (id)applicationBundleID;
@end

@interface UIWebClip
@property (assign) BOOL fullScreen;
@property (nonatomic,retain) NSURL * pageURL;
@end

@interface SBBookmarkIcon : SBLeafIcon
@property(readonly, retain, nonatomic) NSURL *launchURL;
@property(readonly, retain, nonatomic) UIWebClip *webClip;
// -(SBBookmark *)bookmark;

@end



@interface SBApplicationIcon : SBLeafIcon
@end

// @interface SBIconListView
// - (void)prepareToRotateToInterfaceOrientation:(long long)arg1;
// @end


@interface _UILegibilitySettings
- (void)setShadowColor:(id)arg1;
@end

@interface _UIBackdropViewSettings
+ (id)settingsForPrivateStyle:(int)arg1;
@end

@interface _UIBackdropView : UIView
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
@end

@interface _UIBackdropViewSettingsNone : _UIBackdropViewSettings
@end