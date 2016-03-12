/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end


1 = YES
0 = NO

*/
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
#define expireDateString @"3.22.2016"

static BOOL debug = NO;
//asd

BOOL isLocked; //static?

%hook SBUIController
 //icon animation test. nope.
- (void)activateApplication:(id)arg1 fromIcon:(id)arg2 location:(int)arg3 {
	%log;
	%orig;
}
- (void)activateApplication:(id)arg1 {
%log; //not this
	%orig;
}
- (void)launchIcon:(id)arg1 fromLocation:(int)arg2 context:(id)arg3 {
%log;
	%orig;
}



- (void)finishLaunching {

	%orig;

	HBLogInfo(@"finished launching");

/* deprecated in favor of something else
	int notifyToken;
	//notify us when the screen state changes
	notify_register_dispatch("com.apple.springboard.hasBlankedScreen", &notifyToken, dispatch_get_main_queue(), ^(int t) {
		uint64_t state;
		int result = notify_get_state(notifyToken, &state);
		result = nil;
		HBLogInfo(@"lock state change1111 = %llu", state); //1 = locked. 0 = unlocked.
		if (state == 1) {
			//[[SBTest sharedInstance] dismissWithApp:nil];
   		}
	});*/


	//notify when the frontmost application changes
	[[NSNotificationCenter defaultCenter] addObserver:self
        								  selector:@selector(frontmostApplicationChanged:)
        								  name:@"SBFrontmostDisplayChangedNotification"
        								  object:nil];
//	





	//beta date shit
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
	[formatter setLocale:posix];
	[formatter setDateFormat:@"M.d.y"];

	NSDate *ExpireDate = [formatter dateFromString:expireDateString];

	//if current date is before expire date
	if ([[NSDate date] compare:ExpireDate] == NSOrderedAscending) {
		//HBLogDebug(@"this means continue?...");
		[LASharedActivator registerListener:[SBTestActivatorEventShow sharedInstance] forName:@"com.leftyfl1p.sbtest/show"];
		[LASharedActivator registerListener:[SBTestActivatorEventDismiss sharedInstance] forName:@"com.leftyfl1p.sbtest/dismiss"];
	} else {
		//notice
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SBTest" message:@"This beta build has expired. Please update in Cydia. If there is no update please yell at @leftyfl1p on twitter or on reddit." delegate:nil cancelButtonTitle:@"you got it (☞ﾟヮﾟ)☞" otherButtonTitles:nil];
		[alert show];
	}


	

	//[[NSClassFromString(@"LAActivator") sharedInstance] registerListener:[CDTLamoActivatorEventCloseAll new] forName:@"com.cortexdevteam.lamo.closeall"];


}




/*%new
- (void)findSuperview:(UIView *)view {

    // Get the subviews of the view
    //NSArray *subviews = [view subviews];

    // Return if there are no subviews
    //if ([subviews count] == 0) return; // COUNT CHECK LINE
    if(view == nil) return;

    NSLog(@"superview: %@", view);

    [self findSuperview:view.superview];

}*/



/*-(BOOL)_suspendGestureShouldFinish {
	return NO;
}*/



/*
%new
-(void)dismissSBTestAnimated {

	UIView *contentView = [(SBUIController *)[%c(SBUIController) sharedInstance] contentView];

	//animate views out
	[UIView animateWithDuration:0.2f animations:^{
	
	[contentView setAlpha:0.0f];

	[blurView setAlpha:0.0f];

    } completion:^(BOOL finished) {
	    [[%c(SBUIController) sharedInstance] dismissSBTest];

	}];

}
*/

//move this
%new
- (void)frontmostApplicationChanged:(NSNotification *) notification {
	//dismiss shit here
	//NSLog(@"ICONS SHOWNNNNNNNNMMNNMNMNMNMNMNMMMNMNMN %@", notification.userInfo);

	//HBLogInfo(@"frontmostApplicationChanged");
	HBLogDebug(@"frontmostApplicationChanged?????");
	[[SBTest sharedInstance] dismiss];


	
}

//does this replace notification from above? yes
-(void)_deviceLockStateChanged:(id)arg1 {
	if(debug) HBLogInfo(@"LOCK state changed2222: %d", [[[(NSNotification *)arg1 userInfo] objectForKey:@"kSBNotificationKeyState"] boolValue]);

	/*	0 - unlocked
		1 - locked */
	isLocked = [[[(NSNotification *)arg1 userInfo] objectForKey:@"kSBNotificationKeyState"] boolValue];

	if(isLocked){
		//NSLog(@"(device locked) springboard keywindow level from _deviceLockStateChanged: %f", [%c(SpringBoard) sharedApplication].keyWindow.windowLevel);
		//[[SBTest sharedInstance] fixWindowShit];
		//[[SBTest sharedInstance] dismissWithApp:nil];
	}

	
	%orig;
}


/*single home button click event. 

just calling the orig performs action

return doesnt seem to matter

*/
-(BOOL)clickedMenuButton {

	if([[SBTest sharedInstance] isActive]) {

		//to get the current springboard page
		//debug? NSLog(@"CURRENT PAGE: %lld", [(SBRootFolderController *)[[%c(SBIconController) sharedInstance] _rootFolderController] contentView].currentPageIndex) :;

		//handle siri being invoked while open
		if([%c(SBAssistantController) isAssistantVisible]) {
			return %orig;
		}

		
		if(debug) HBLogInfo(@"hasOpenFolder?: %d", [[%c(SBIconController) sharedInstance] hasOpenFolder]);

		if(debug) HBLogInfo(@"isEditing?: %d", [[%c(SBIconController) sharedInstance] isEditing]);

		if(debug) HBLogInfo(@"showingSearch: %d", [[%c(SBSearchViewController) sharedInstance] isVisible]);

		//conditions to close
		/*
		not showing search
		not editing
		no open folders
		must be on first page
		*/


		if(debug) {
			//int currentPageIndex = 1;
			BOOL currentPageIndex = [(SBRootFolderController *)[[%c(SBIconController) sharedInstance] _rootFolderController] contentView].currentPageIndex == 0;
			BOOL hasOpenFolder = [[%c(SBIconController) sharedInstance] hasOpenFolder];
			BOOL iconsAreEditing = [[%c(SBIconController) sharedInstance] isEditing];
			BOOL searchIsVisible = [[%c(SBSearchViewController) sharedInstance] isVisible];
			HBLogInfo(@"conditions: \n 	currentPageIndex = %d\n hasOpenFolder = %d\n iconsAreEditing = %d\n searchIsVisible = %d\n", currentPageIndex, hasOpenFolder,iconsAreEditing,searchIsVisible);
		}

		if([(SBRootFolderController *)[[%c(SBIconController) sharedInstance] _rootFolderController] contentView].currentPageIndex == 0 
			&& ![[%c(SBIconController) sharedInstance] hasOpenFolder] 
			&& ![[%c(SBIconController) sharedInstance] isEditing] 
			&& ![[%c(SBSearchViewController) sharedInstance] isVisible]) {
			//HBLogInfo(@"asdadsdasdff");
			//[[SBTest sharedInstance] dismiss];
		}

		//handle spotlight
		if([[%c(SBSearchViewController) sharedInstance] isVisible]) {
			[[%c(SBSearchViewController) sharedInstance] dismiss];
		} else

		//handle disable icon editing
		if([[%c(SBIconController) sharedInstance] isEditing]) {
			[[%c(SBIconController) sharedInstance] setIsEditing:NO];
		} else

		//tell icons to handle the press
		[[%c(SBIconController) sharedInstance] handleHomeButtonTap];



	} else {
		return %orig;
	}



	return NO;
}


%end




%hook SBIconController
-(void)iconTapped:(id)arg1 {
	//%log;
	//f%orig;
	//return;

	if([[SBTest sharedInstance] isActive]) {
		//if icon is a folder
		if ([arg1 isKindOfClass:[%c(SBFolderIconView) class]]) {
			[self openFolder:[arg1 folder] animated:YES];
		} else {

			//clean this up. %group?
			//if(!isiOS9Up) {
			//icon isnt a folder
			SBIconView *iconView = (SBIconView *)arg1;

			NSString * bundleIdentifier = iconView.icon.applicationBundleID;
			//SBApplication* app = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:iconView.icon.applicationBundleID];

			[[SBTest sharedInstance] dismissWithBundleIdentifier:bundleIdentifier];
			//} else {
				//[[SBTest sharedInstance] dismissWithApp:nil];
			//}
			

			
		}

	}


	%orig;

}

//handling the icons on the homescreen
-(void)handleHomeButtonTap {
	//HBLogInfo(@"ICONS HANDLED HOME BUTTON");

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


//use this for detecting when app is selected from spotlight
//only ios 8 needs this
%hook SBSearchResultsAction

-(void)cancelAnimated:(BOOL)arg1 withCompletionBlock:(/*^block*/id)arg2 {
	%log;
	NSString *applicationIdentifier = [[self result] url];

	if([[SBTest sharedInstance] isActive]) {
		[[SBTest sharedInstance] dismissWithBundleIdentifier:applicationIdentifier];
	}
	
	%orig;

}


%end

%ctor {
	//isiOS9Up ? (%init(iOS9)) : (%init(iOS8));
}

/*
for adding cirdock icons to the icon controller

%hook SBIconModel

- (void)addIcon:(id)arg1 {
	%log;
	%orig;
}
%end
*/

%hook SPUISearchResultsActionManager
/*
-(void)openURL:(id)arg1 {
	%log;
	%orig;
}

-(id)_performActionForResult:(id)arg1 inSection:(id)arg2 urls:(id)arg3 fromCardType:(id)arg4 sendFeedback:(BOOL)arg5 forceDefaultAction:(BOOL)arg6 completionBlock:(id)arg7 {
	%log;
	return %orig;
}

-(id)_performActionForResult:(id)arg1 inSection:(id)arg2 urls:(id)arg3 forceDefaultAction:(BOOL)arg4 completionBlock:(id)arg5 {
	%log;
	return %orig;
}*/

//ios9 only. for when spotlight needs to open an app.
-(id)_performAction:(id)arg1 completionBlock:(/*^block*/id)arg2 {
	%log;
	if([[SBTest sharedInstance] isActive]) {
		[[SBTest sharedInstance] dismiss];
	}
	return %orig;
}
/*
-(id)_actionForResult:(id)arg1 inSection:(id)arg2 {
	%log;
	return %orig;
}
-(id)performActionForResult:(id)arg1 inSection:(id)arg2 {
	%log;
	return %orig;
}
-(id)performSecondaryActionForResult:(id)arg1 inSection:(id)arg2 {
	%log;
	return %orig;
}
-(void)performCustomActionWithViewController:(id)arg1 {
	%log;
	%orig;
}*/

%end
