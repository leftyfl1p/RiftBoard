#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>

@interface RBPrefs : NSObject
@property (nonatomic, assign) BOOL someBool;

+ (id)sharedInstance;
- (id)init;

//-(void)reloadPrefs;

-(BOOL)useBlur;
-(void)setUseBlur:(BOOL)blur;

-(BOOL)allowAppInteraction;
-(void)setAllowAppInteraction:(BOOL)interaction;

-(BOOL)useHomeButton;
-(void)setUseHomeButton:(BOOL)homeButton;

-(BOOL)useQuickHomeButtonDismiss;
-(void)setUseQuickHomeButtonDismiss:(BOOL)homeButtonDismiss;

@end