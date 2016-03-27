#import <Foundation/Foundation.h>
#import <libactivator/libactivator.h>
#import "CKBlurView.h"
#import "headers.h"
#import "RBPrefs.h"




@interface SBTest : NSObject

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) CKBlurView *blurView;
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic) double beforeWindowLevel;
@property (nonatomic) double currentWindowLevel;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL deviceIsUnlocked;
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

@end
