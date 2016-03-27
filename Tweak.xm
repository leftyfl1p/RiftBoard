#import "SBTest.h"
#import "headers.h"
#import "CKBlurView.h"
#import "SBTestActivatorEventShow.h"
#import "SBTestActivatorEventDismiss.h"
#import <libactivator/libactivator.h>

#import <notify.h>


//static int beforeWindowLevel = -1;
#define kBundlePath @"/Library/MobileSubstrate/DynamicLibraries/sbtestBundle.bundle"
#define isiOS9Up (kCFCoreFoundationVersionNumber >= 1217.11)
#define expireDateString @"4.6.2016"

static BOOL debug = YES;
static NSString *previousBundleIdentifier;

%hook SBUIController


- (void)finishLaunching {
	%orig;
	//notify when the frontmost application changes
	[[NSNotificationCenter defaultCenter] addObserver:self
        								  selector:@selector(frontmostApplicationChanged:)
        								  name:@"SBFrontmostDisplayChangedNotification"
        								  object:nil];
//	

[[NSNotificationCenter defaultCenter] addObserver:self
        								  selector:@selector(AXSBServerOrientationChange:)
        								  name:@"AXSBServerOrientationChange"
        								  object:nil];

	//beta date shit
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
	[formatter setLocale:posix];
	[formatter setDateFormat:@"M.d.y"];

	NSDate *ExpireDate = [formatter dateFromString:expireDateString];

	//if current date is before expire date
	if ([[NSDate date] compare:ExpireDate] == NSOrderedAscending) {
		[LASharedActivator registerListener:[SBTestActivatorEventShow new] forName:@"com.leftyfl1p.sbtest/show"];
		[LASharedActivator registerListener:[SBTestActivatorEventDismiss new] forName:@"com.leftyfl1p.sbtest/dismiss"];
	} else {
		//notice
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"RiftBoard" message:@"This beta build has expired. Please update in Cydia. If there is no update please yell at @leftyfl1p on twitter or on reddit." delegate:nil cancelButtonTitle:@"you got it (☞ﾟヮﾟ)☞" otherButtonTitles:nil];
		[alert show];
	}
	//END BETA DATE SHIT


}

//rotation
- (void)tearDownIconListAndBar {
	//%log;
	if([[SBTest sharedInstance] isActive]) {
		HBLogDebug(@"tearDownIconListAndBar: is active, returning.");
		return;
	}

	%orig;
}


%new
//notify us when the frontmost application changes in visibility
- (void)frontmostApplicationChanged:(NSNotification *) notification {
	//if(debug)HBLogDebug(@"frontmostApplicationChanged: %@", notification);




	//if([[SBTest sharedInstance] isActive]) {
		//if lockscreen is present this will be SBLockScreenViewController
		id frontmostDisplay = [notification.userInfo objectForKey:@"SBFrontmostDisplayKey"];
	if([frontmostDisplay isKindOfClass:[%c(SBApplication) class]]) {
		NSString *bundleIdentifier = ((SBApplication *)frontmostDisplay).bundleIdentifier;
		if(previousBundleIdentifier.length == 0) previousBundleIdentifier = bundleIdentifier;

		if(![bundleIdentifier isEqualToString:previousBundleIdentifier]) {
			
			previousBundleIdentifier = bundleIdentifier;
			if([[SBTest sharedInstance] isActive]) {
				[[SBTest sharedInstance] dismiss];
				HBLogDebug(@"different bundleIdentifier received, dismissing.");
			}

		} else {
			HBLogDebug(@"same bundleIdentifier, doing nothing.");
		}
	} else {
		
		if([[SBTest sharedInstance] isActive]) {
			[[SBTest sharedInstance] dismiss];
			HBLogDebug(@"did not receive SBApplication, dismissing.");
		}
	}
	//}

	//[[SBTest sharedInstance] dismiss];


	//test to make things nicer when trying to invoke board while switching apps.
	//sb window resets level when frontmost app changes anyways so this doesnt work :(
	//id test = [notification.userInfo objectForKey:@"SBFrontmostDisplayKey"];
	//if lockscreen is present this will be SBLockScreenViewController
	/*if(![test isKindOfClass:[%c(SBApplication) class]]) {
		HBLogDebug(@"did not receive app. dismissing");
		//[[SBTest sharedInstance] dismiss];
	}*/
}

%new
- (void)AXSBServerOrientationChange:(NSNotification *) notification {
	HBLogDebug(@"AXSBServerOrientationChange: %@", notification);
	if([[SBTest sharedInstance] isActive]) {
		[[SBTest sharedInstance] handleRotation];
	}
}



//this entire thing could probably use some refactoring
-(BOOL)clickedMenuButton {
	//if activator single home button press event is assigned & board isnt already active & app switcher isnt showing & device is currently in an app
	if([[SBTest sharedInstance] asssignedToHomeButton] && ![[SBTest sharedInstance] isActive] && ![[%c(SBUIController) sharedInstance] isAppSwitcherShowing] && [[SBTest sharedInstance] isInApplication]) {
		if(debug)HBLogDebug(@"asssignedToHomeButton and appropriate to show. showing.");
		[[SBTest sharedInstance] show];

	} else if([[SBTest sharedInstance] isActive]) {

		if([[RBPrefs sharedInstance] useQuickHomeButtonDismiss]) {

			if(debug)HBLogDebug(@"useQuickHomeButtonDismiss is on, dismissing");

			if([[%c(SBIconController) sharedInstance] isEditing]) {
				if(debug)HBLogDebug(@"but was editing.");
				[[%c(SBIconController) sharedInstance] setIsEditing:NO];
			} else {
				[[SBTest sharedInstance] dismiss];
			}
			
		} else {
			if(debug)HBLogDebug(@"useQuickHomeButtonDismiss is off");
			//handle siri being invoked while open
			if([%c(SBAssistantController) isAssistantVisible]) {
				return %orig;
			}

			/*
			conditions to close:
			-not showing search
			-not editing icons
			-no open folders
			-must be on first page
			*/
			if(debug) {
				int currentPageIndex = [(SBRootFolderController *)[[%c(SBIconController) sharedInstance] _rootFolderController] contentView].currentPageIndex;
				BOOL hasOpenFolder = [[%c(SBIconController) sharedInstance] hasOpenFolder];
				BOOL iconsAreEditing = [[%c(SBIconController) sharedInstance] isEditing];
				BOOL searchIsVisible = [[%c(SBSearchViewController) sharedInstance] isVisible];
				HBLogDebug(@"\n conditions:\n currentPageIndex = %i\n hasOpenFolder = %d\n iconsAreEditing = %d\n searchIsVisible = %d\n", currentPageIndex, hasOpenFolder,iconsAreEditing,searchIsVisible);
			}

			if([(SBRootFolderController *)[[%c(SBIconController) sharedInstance] _rootFolderController] contentView].currentPageIndex == 0 
				&& ![[%c(SBIconController) sharedInstance] hasOpenFolder] 
				&& ![[%c(SBIconController) sharedInstance] isEditing] 
				&& ![[%c(SBSearchViewController) sharedInstance] isVisible]) {

				if(debug)HBLogDebug(@"should close here");
				[[SBTest sharedInstance] dismiss];
			} else

			//handle spotlight
			if([[%c(SBSearchViewController) sharedInstance] isVisible]) {
				[[%c(SBSearchViewController) sharedInstance] dismiss];
			} else

			//handle disable icon editing
			if([[%c(SBIconController) sharedInstance] isEditing]) {
				[[%c(SBIconController) sharedInstance] setIsEditing:NO];
			} else {

				//tell icons to handle the press
				if(debug)HBLogDebug(@"icons handleHomeButtonTap");
				[[%c(SBIconController) sharedInstance] handleHomeButtonTap];
			}

			
			
			
		}

		

	} else {
		
		return %orig;
	}


	return YES;
}


%end

%hook SpringBoard

- (void)setStatusBarHidden:(BOOL)hidden withAnimation:(UIStatusBarAnimation)animation {
	if([[SBTest sharedInstance] isActive]) {
		hidden = NO;
	}
	//hax >:/
	//see: SBTest.xm:157 something
	if(animation == 1337) {
		hidden = YES;
		animation = UIStatusBarAnimationFade;
	}
	%orig(hidden, animation);
}

%end


%hook SBIconController

- (void)_launchIcon:(id)arg1 {

	if([[SBTest sharedInstance] isActive]) {
		//icon is a folder
		if ([arg1 isKindOfClass:[%c(SBFolderIcon) class]]) {
			[self openFolder:[arg1 folder] animated:YES];
		}
		//icon is a web bookmark
		else if ([arg1 isKindOfClass:[%c(SBBookmarkIcon) class]]) {
			/*
			webapps that arent "fullscreen" still have a
			launch url that launches them in fullscreen.
			*/
			SBBookmarkIcon * icon = (SBBookmarkIcon *)arg1;
			if(icon.webClip.fullScreen) {
				[[UIApplication sharedApplication] openURL:icon.launchURL];
			} else {
				[[UIApplication sharedApplication] openURL:icon.webClip.pageURL];
			}

			[[SBTest sharedInstance] dismissWithBundleIdentifier:nil];
		} 

		else {
			//icon should be an app
			SBApplicationIcon *icon = (SBApplicationIcon *)arg1;
			NSString * bundleIdentifier = icon.applicationBundleID;
			[[SBTest sharedInstance] dismissWithBundleIdentifier:bundleIdentifier];
		}
	}

	%orig;
}

//make sure reachability works while board is active
- (_Bool)_shouldRespondToReachability {
	if([[SBTest sharedInstance] isActive]) {
		return YES;
	}
	return %orig;
}

%end


%hook SBIconListView
/*
handles:
<Error>: *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'call to -[SBIconListView prepareToRotateToInterfaceOrientation:] when already rotating'
*/
- (void)prepareToRotateToInterfaceOrientation:(long long)arg1 {
	 unsigned int _rotating = MSHookIvar<unsigned int>(self,"_rotating");
	 if(_rotating) return;
	 %orig;
}

%end

/*
%hook SBSearchViewController


-(void)searchGesture:(id)arg1 completedShowing:(BOOL)arg2  {
	%orig;
	if(!arg2) {
		HBLogInfo(@"dismissed spotlight?");
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	%log;
	//HBLogInfo(@"indexPath: %ld", (long)indexPath.row);
	%orig;

}

%end
*/

%hook SBHomeScreenWindow

-(void)setWindowLevel:(double)arg1 {
	//%log;
	%orig;
}

%end


%group iOS9


%hook SBDeckSwitcherViewController
//for when user tries to invoke switcher while board is active
-(void)viewDidLoad {//FIXME: use view did appear
	if([[SBTest sharedInstance] isActive]) {
		HBLogDebug(@"SBDeckSwitcherViewController viewDidLoad???");
		[[SBTest sharedInstance] dismiss];
	}

	%orig;
}


%end

%hook SPUISearchResultsActionManager

//ios9 only. for when spotlight needs to open an app.
-(id)_performAction:(id)arg1 completionBlock:(/*^block*/id)arg2 {
	//%log;
	if([[SBTest sharedInstance] isActive]) {
		[[SBTest sharedInstance] dismiss];
	}
	return %orig;
}


%end

%hook SBMainDisplaySceneManager

- (_Bool)_shouldBreadcrumbApplication:(id)arg1 withTransitionContext:(id)arg2 {
	if([[SBTest sharedInstance] isActive]) {
		return NO;
	}
	return %orig;
}


%end


//ios9 group
%end


%group iOS8


%hook SBUIController
//for when user tries to invoke switcher while board is active
-(BOOL)_activateAppSwitcher {
	if([[SBTest sharedInstance] isActive]) {
		HBLogDebug(@"SBUIController _activateAppSwitcher???");
		[[SBTest sharedInstance] dismiss];
	}

	return %orig;
}



%end

//for detecting when app is selected from spotlight
%hook SBSearchResultsAction

-(void)cancelAnimated:(BOOL)arg1 withCompletionBlock:(id)arg2 {
	NSString *applicationIdentifier = [[self result] url];//get headers for this
	if([[SBTest sharedInstance] isActive]) {
		[[SBTest sharedInstance] dismissWithBundleIdentifier:applicationIdentifier];
	}
	%orig;
}


%end

//ios8 group
%end



%ctor {
	//initialize version specific hooks
	isiOS9Up ? (%init(iOS9)) : (%init(iOS8));
	//init ungrouped hooks
	%init;

	//[[RBPrefs sharedInstance] reloadPrefs];


}