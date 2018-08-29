#define debug(text, ...) if([[RBPrefs sharedInstance] debug]) HBLogDebug((text), ##__VA_ARGS__)
#define isiOS93Up (kCFCoreFoundationVersionNumber >= 1280.30)

@interface SBWindow : UIWindow
@end

@interface SBApplication : NSObject

@property(copy) NSString* bundleIdentifier;

@end


@interface SBUIController : NSObject {
	SBWindow* _window;
}

-(void)restoreContentAndUnscatterIconsAnimated:(BOOL)animated;
-(void)tearDownIconListAndBar;
-(BOOL)isAppSwitcherShowing;
-(void)forceIconInterfaceOrientation:(long long)arg1 duration:(double)arg2;

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
-(id)statusBar;
- (void)_deactivateReachability;
-(BOOL)homeScreenSupportsRotation;

//rotation
- (long long)_frontMostAppOrientation;

@end

@interface UIApplication (extras)
-(id)_accessibilityFrontMostApplication;
-(BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2 ;

@end

@interface UIStatusBar
-(id)statusBarWindow;

@end


@interface SBIconController : NSObject {
	BOOL _showingSearch;
}
+(id)sharedInstance;
-(void)iconTapped:(id)arg1 ;
-(void)handleHomeButtonTap;
-(void)closeFolderAnimated:(BOOL)arg1;
-(void)setIsEditing:(BOOL)arg1 ;
-(BOOL)hasOpenFolder;
-(BOOL)isEditing;
-(void)openFolder:(id)arg1 animated:(BOOL)arg2;
-(id)_rootFolderController;
@end



@interface SBIcon : NSObject
@end

@interface SBFolderIcon : SBIcon
-(void)launchFromLocation:(int)arg1 ;
-(id)folder;
@end


@interface SBFolderIconView
-(id)folder;
@end

@interface SBAssistantController : NSObject
+(BOOL)isAssistantVisible;

@end

@interface SBFolderView : UIView

//ios 8.4
//@property (nonatomic,readonly) long long currentPageIndex;

//8.3 NEEDS THIS
@property(readonly, assign, nonatomic) int currentPageIndex;
@end

@interface SBHomeScreenPullDownSearchViewController : NSObject //(iOS10)
-(void)dismissSearchViewWithReason:(unsigned long long)arg1;
@end

@interface SBRootFolderView : SBFolderView {
	SBHomeScreenPullDownSearchViewController* _pullDownSearchViewController; //iOS10
}

@end


@interface SBRootFolderController : NSObject {
	SBRootFolderController* _rootFolderController; //iOS10
}

@property (nonatomic,retain,readonly) SBRootFolderView * contentView; 

@end

@interface SBDockIconListView : UIView
-(void)collapseAnimated:(BOOL)arg1;
@end

@interface SBIconController (iOS10) 

-(void)closeFolderAnimated:(BOOL)arg1 withCompletion:(/*^block*/id)arg2 ;
-(void)openFolderIcon:(id)arg1 animated:(BOOL)arg2 withCompletion:(/*^block*/id)arg3 ;

- (id)dockListView;
@end

@interface SPSearchResult
-(NSString *)url;
@end

@interface SBSearchResultsAction
-(SPSearchResult *)result;
@end

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

@end

@interface SBApplicationIcon : SBLeafIcon
@end

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