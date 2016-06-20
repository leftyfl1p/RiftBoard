#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>

@interface RBPrefs : NSObject

@property int blurStyle;
@property BOOL allowAppInteraction;
@property BOOL useHomeButton;
@property BOOL useQuickHomeButtonDismiss;
@property BOOL allowRotation;
@property BOOL debug;

+ (id)sharedInstance;
- (id)init;
-(void)reloadPrefs;

@end