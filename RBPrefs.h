#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>

@interface RBPrefs : NSObject

@property int BlurStyle;
@property BOOL debug;

+ (id)sharedInstance;
- (id)init;

-(void)reloadPrefs;

//-(BOOL)useBlur;
-(void)setUseBlur:(BOOL)blur;

-(BOOL)allowAppInteraction;
-(void)setAllowAppInteraction:(BOOL)interaction;

-(BOOL)useHomeButton;
-(void)setUseHomeButton:(BOOL)homeButton;

-(BOOL)useQuickHomeButtonDismiss;
-(void)setUseQuickHomeButtonDismiss:(BOOL)homeButtonDismiss;

-(BOOL)debug;
-(void)setDebug:(BOOL)debug;

@end