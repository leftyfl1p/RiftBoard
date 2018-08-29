#import <Foundation/Foundation.h>
#import <libactivator/libactivator.h>
#import "headers/CKBlurView.h"
#import "headers/headers.h"
#import "RBPrefs.h"



@interface SBTest : NSObject

@property (nonatomic, retain) UIWindow *SBWindow;
@property (nonatomic, retain) UIView *SBContentView;
@property (nonatomic, retain) UIView *blurView;
@property double origWindowLevel;
@property double currentWindowLevel;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL deviceIsUnlocked;
//@property (nonatomic) _UILegibilitySettings *legibilitySettings;

+ (id)sharedInstance;
- (id)init;
-(void)show;
-(void)dismissWithBundleIdentifier:(NSString *)bundleIdentifier;
-(BOOL)isInApplication;
-(void)handleRotation;
-(void)handleRotationWithDuration:(double)duration;
//-(void)dismissWithCompletionHandler:(void(^)(void))arg3;
-(BOOL)isAsssignedToHomeButton;
-(void)dismiss;
-(BOOL)isActive;

-(void)updateLegibility;

-(void)showHomeButtonActivatorAlert;
@end
