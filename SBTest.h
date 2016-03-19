#import <Foundation/Foundation.h>
#import <libactivator/libactivator.h>
#import "CKBlurView.h"
#import "headers.h"
#import "RBPrefs.h"




@interface SBTest : NSObject

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) CKBlurView *blurView;
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic) float beforeWindowLevel;
@property (nonatomic) float currentWindowLevel;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL deviceIsUnlocked;

+ (id)sharedInstance;
- (id)init;
-(void)show;
-(void)dismissWithBundleIdentifier:(NSString *)bundleIdentifier;
-(BOOL)isInApplication;
//-(void)dismissWithCompletionHandler:(void(^)(void))arg3;
-(BOOL)asssignedToHomeButton;
-(void)dismiss;
-(BOOL)isActive;

@end
