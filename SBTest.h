#import <Foundation/Foundation.h>
#import <libactivator/libactivator.h>
#import "CKBlurView.h"
#import "headers.h"
#import "RBPrefs.h"

@interface _UIBackdropViewSettings
+ (id)settingsForPrivateStyle:(int)arg1;
- (void)setColorTint:(id)arg1;
- (void)setColorTintAlpha:(float)arg1;
+ (id)darkeningTintColor;
- (void)setUsesColorTintView:(BOOL)arg1;
- (void)setRequiresColorStatistics:(BOOL)arg1;
- (void)setColorTintAlpha:(float)arg1;
- (void)setColorTintMaskAlpha:(float)arg1;

- (void)setGrayscaleTintAlpha:(float)arg1;
- (void)setGrayscaleTintLevel:(float)arg1;
@end

@interface _UIBackdropView : UIView
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;

@end

@interface _UIBackdropViewSettingsNone : _UIBackdropViewSettings

- (void)computeOutputSettingsUsingModel:(id)arg1;
- (void)setDefaultValues;

@end


@interface SBTest : NSObject

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIView *blurView;
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic) double beforeWindowLevel;
@property (nonatomic) double currentWindowLevel;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL deviceIsUnlocked;
@property (nonatomic) _UILegibilitySettings *legibilitySettings;
//@property (nonatomic) double orig;

+ (id)sharedInstance;
- (id)init;
-(void)show;
-(void)dismissWithBundleIdentifier:(NSString *)bundleIdentifier;
-(BOOL)isInApplication;
-(void)handleRotation;
//-(void)dismissWithCompletionHandler:(void(^)(void))arg3;
-(BOOL)asssignedToHomeButton;
-(void)dismiss;
-(BOOL)isActive;
-(void)flip;//idk????

-(void)updateLegibility;
@end
