#import <Preferences/Preferences.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>

@interface RBRootListController : HBRootListController

//reorganize inherited/override first then new
-(PSSpecifier *)interactionSpecifier;
- (void)appWillEnterForeground:(NSNotification *)notification;
-(void)flash;
-(UISwitch *)interactionSwitch;
-(void)updateInteractionSwitch;

@end
