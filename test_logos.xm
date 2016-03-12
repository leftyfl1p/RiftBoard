
// ********************************************
// Created by Code Logging Creator
// ********************************************


%hook SBUIController


-(id)_appSwitcherController {
	%log;
	return %orig;
}

-(void)animateAppleDown:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(BOOL)isAppSwitcherShowing {
	%log;
	return %orig;
}

-(void)updateBatteryState:(id)arg1 {
	%log;
	%orig(arg1);
}

-(BOOL)handleMenuDoubleTap {
	%log;
	return %orig;
}

-(void)cancelVolumeEvent {
	%log;
	%orig;
}

-(BOOL)clickedMenuButton {
	%log;
	return %orig;
}

-(void)handleVolumeEvent:(id)arg1 {
	%log;
	%orig(arg1);
}

-(BOOL)allowAlertWindowRotation {
	%log;
	return %orig;
}

-(void)setAmbiguousControlCenterActivationMargin:(double)arg1 forApp:(id)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)updateShouldShowCenterTabControlsOnFirstSwipe {
	%log;
	%orig;
}

-(BOOL)isOnAC {
	%log;
	return %orig;
}

-(void)setAllowIconRotation:(BOOL)arg1 forReason:(id)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(id)_legibilityPrototypeSettings {
	%log;
	return %orig;
}

-(void)clearPendingAppActivatedByGesture {
	%log;
	%orig;
}

-(void)_hideNotificationCenterTabControl {
	%log;
	%orig;
}

-(void)_hideControlCenterGrabber {
	%log;
	%orig;
}

-(void)noteStatusBarHeightChanged:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_applicationActivationStateDidChange:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)cleanUpOnFrontLocked {
	%log;
	%orig;
}

-(void)_awayControllerActivated:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_backgroundContrastDidChange:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_deviceLockStateChanged:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_reloadSwitcherController {
	%log;
	%orig;
}

-(void)_updateLegibility {
	%log;
	%orig;
}

-(void)finishLaunching {
	%log;
	%orig;
}

-(void)systemControllerRouteChanged:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)getRidOfAppSwitcher {
	%log;
	%orig;
}

-(void)configureFakeSpringBoardStatusBarWithStyleRequest:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)removeFakeSpringBoardStatusBar {
	%log;
	%orig;
}

-(BOOL)isFakeStatusBarStyleEffectivelyDoubleHeight:(long long)arg1 {
	%log;
	return %orig(arg1);
}

-(void)_clearSwitchAppList {
	%log;
	%orig;
}

-(void)cleanupSwitchAppGestureViews {
	%log;
	%orig;
}

-(void)stopRestoringIconList {
	%log;
	%orig;
}

-(void)activateApplicationAnimated:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)restoreContentUpdatingStatusBar:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(void)_closeOpenFolderIfNecessary {
	%log;
	%orig;
}

-(void)updateStatusBarLegibility {
	%log;
	%orig;
}

-(void)_switchToHomeScreenWallpaperAnimated:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(void)restoreContentAndUnscatterIconsAnimated:(BOOL)arg1 withCompletion:(/*^block*/id)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)restoreContent {
	%log;
	%orig;
}

-(void)launchPendingAppActivatedByGestureIfExists {
	%log;
	%orig;
}

-(int)_dismissSheetsAndDetermineAlertStateForMenuClickOrSystemGesture {
	%log;
	return %orig;
}

-(void)_dismissSwitcherAnimated:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(BOOL)_handleButtonEventToSuspendDisplays:(BOOL)arg1 displayWasSuspendedOut:(BOOL*)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(void)_setToggleSwitcherAfterLaunchApp:(id)arg1 {
	%log;
	%orig(arg1);
}

-(BOOL)_ignoringEvents {
	%log;
	return %orig;
}

-(void)_toggleSwitcher {
	%log;
	%orig;
}

-(void)_clearAllInstalledSystemGestureViews {
	%log;
	%orig;
}

-(void)_releaseSystemGestureOrientationLock {
	%log;
	%orig;
}

-(void)_noteAppDidActivate:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_noteAppDidFailToActivate:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)tearDownIconListAndBar {
	%log;
	%orig;
}

-(void)_toggleSwitcherForReals {
	%log;
	%orig;
}

-(BOOL)_activateAppSwitcher {
	%log;
	return %orig;
}

-(id)_currentFolderLegibilitySettings {
	%log;
	return %orig;
}

-(void)setAllowSwitcherRotation:(BOOL)arg1 forReason:(id)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)_lockOrientationForSwitcher {
	%log;
	%orig;
}

-(BOOL)workspaceShouldAbortLaunchingAppDueToSwitcher:(id)arg1 url:(id)arg2 actions:(id)arg3 {
	%log;
	return %orig(arg1, arg2, arg3);
}

-(void)releaseSwitcherOrientationLock {
	%log;
	%orig;
}

-(void)_resumeEventsIfNecessary {
	%log;
	%orig;
}

-(int)batteryCapacityAsPercentage {
	%log;
	return %orig;
}

-(void)setIsConnectedToUnsupportedChargingAccessory:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(void)_indicateConnectedToPower {
	%log;
	%orig;
}

-(void)ACPowerChanged {
	%log;
	%orig;
}

-(id)_installedSystemGestureViewForKey:(id)arg1 {
	%log;
	return %orig(arg1);
}

-(BOOL)_allowSwitcherGesture {
	%log;
	return %orig;
}

-(void)_suspendGestureBegan {
	%log;
	%orig;
}

-(void)_suspendGestureChanged:(float)arg1 {
	%log;
	%orig(arg1);
}

-(void)_suspendGestureEndedWithCompletionType:(long long)arg1 {
	%log;
	%orig(arg1);
}

-(void)_suspendGestureCancelled {
	%log;
	%orig;
}

-(void)_switchAppGestureBegan:(double)arg1 {
	%log;
	%orig(arg1);
}

-(void)_switchAppGestureChanged:(double)arg1 {
	%log;
	%orig(arg1);
}

-(void)_switchAppGestureEndedWithCompletionType:(long long)arg1 cumulativePercentage:(double)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)_switchAppGestureCancelled {
	%log;
	%orig;
}

-(void)_switcherGestureBegan {
	%log;
	%orig;
}

-(void)_switcherGestureChanged:(float)arg1 {
	%log;
	%orig(arg1);
}

-(void)_switcherGestureEndedWithCompletionType:(long long)arg1 cumulativePercentage:(double)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)_switcherGestureCancelled {
	%log;
	%orig;
}

-(void)_showNotificationsGestureChangedWithLocation:(CGPoint)arg1 velocity:(CGPoint)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)_showNotificationsGestureCancelled {
	%log;
	%orig;
}

-(void)_showNotificationsGestureFailed {
	%log;
	%orig;
}

-(void)_hideNotificationsGestureBegan:(double)arg1 {
	%log;
	%orig(arg1);
}

-(void)_hideNotificationsGestureChanged:(double)arg1 {
	%log;
	%orig(arg1);
}

-(void)_hideNotificationsGestureEndedWithCompletionType:(long long)arg1 velocity:(CGPoint)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)_hideNotificationsGestureCancelled {
	%log;
	%orig;
}

-(void)_showControlCenterGestureBeganWithLocation:(CGPoint)arg1 {
	%log;
	%orig(arg1);
}

-(void)_showControlCenterGestureChangedWithLocation:(CGPoint)arg1 velocity:(CGPoint)arg2 duration:(double)arg3 {
	%log;
	%orig(arg1, arg2, arg3);
}

-(void)_showControlCenterGestureEndedWithLocation:(CGPoint)arg1 velocity:(CGPoint)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)_showControlCenterGestureCancelled {
	%log;
	%orig;
}

-(void)_showControlCenterGestureFailed {
	%log;
	%orig;
}

-(void)_switchAppGestureViewAnimationComplete {
	%log;
	%orig;
}

-(BOOL)_switcherGestureIsBlockedByAppLaunchOrIgnoringEvents {
	%log;
	return %orig;
}

-(void)_lockOrientationForSystemGesture {
	%log;
	%orig;
}

-(void)_suspendGestureCleanUpState {
	%log;
	%orig;
}

-(void)endRequiringWallpaperForSuspendGestureIfNecessary {
	%log;
	%orig;
}

-(id)_systemGestureViewKeyForApp:(id)arg1 {
	%log;
	return %orig(arg1);
}

-(void)_installSystemGestureView:(id)arg1 forKey:(id)arg2 forGesture:(unsigned long long)arg3 {
	%log;
	%orig(arg1, arg2, arg3);
}

-(void)_animateStatusBarForSuspendGesture {
	%log;
	%orig;
}

-(void)_ignoreEvents {
	%log;
	%orig;
}

-(BOOL)_suspendGestureShouldFinish {
	%log;
	return %orig;
}

-(void)configureFakeSpringBoardStatusBarWithDefaultStyleRequestForStyle:(long long)arg1 {
	%log;
	%orig(arg1);
}

-(void)setFakeSpringBoardStatusBarVisible:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(id)_calculateSwitchAppList {
	%log;
	return %orig;
}

-(id)_makeSwitchAppValidList:(id)arg1 {
	%log;
	return %orig(arg1);
}

-(void)_getSwitchAppPrefetchApps:(id)arg1 initialApp:(id)arg2 outLeftwardAppIdentifier:(id*)arg3 outRightwardAppIdentifier:(id*)arg4 {
	%log;
	%orig(arg1, arg2, arg3, arg4);
}

-(void)_clearGestureViewVendorCacheForAppWithDisplayIdenitifier:(id)arg1 {
	%log;
	%orig(arg1);
}

-(id)_makeSwitchAppFilteredList:(id)arg1 initialApp:(id)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(void)_clearPendingAppActivatedByGesture:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(void)showSystemGestureBackdrop {
	%log;
	%orig;
}

-(void)programmaticSwitchAppGestureApplyWithPercentage:(double)arg1 {
	%log;
	%orig(arg1);
}

-(void)hideSystemGestureBackdrop {
	%log;
	%orig;
}

-(void)launchApplicationByGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_clearInstalledSystemGestureViewForKey:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)scheduleApplicationForLaunchByGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_installSwitchAppGesturePlaceholderViewForEndingApp:(id)arg1 {
	%log;
	%orig(arg1);
}

-(BOOL)shouldShowNotificationCenterTabControlOnFirstSwipe {
	%log;
	return %orig;
}

-(double)showNotificationsTabControlSwipableWidth {
	%log;
	return %orig;
}

-(BOOL)shouldShowControlCenterTabControlOnFirstSwipe {
	%log;
	return %orig;
}

-(BOOL)shouldUseControlCenterRevealConfirmation {
	%log;
	return %orig;
}

-(BOOL)_preventShowingTabControls {
	%log;
	return %orig;
}

-(void)animateAppSwitcherDismissalToDisplayLayout:(id)arg1 withCompletion:(/*^block*/id)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)_switcherWantsToActivateDisplayLayout:(id)arg1 displayIDsToURLs:(id)arg2 displayIDsToActions:(id)arg3 {
	%log;
	%orig(arg1, arg2, arg3);
}

-(void)_switcherFixupIconsViewIfNecessary {
	%log;
	%orig;
}

-(void)_dismissAppSwitcherImmediately {
	%log;
	%orig;
}

-(void)appSwitcher:(id)arg1 wantsToActivateDisplayLayout:(id)arg2 displayIDsToURLs:(id)arg3 displayIDsToActions:(id)arg4 {
	%log;
	%orig(arg1, arg2, arg3, arg4);
}

-(void)appSwitcherWantsToDismissImmediately:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)appSwitcherNeedsToReload:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)wallpaperDidChangeForVariant:(long long)arg1 {
	%log;
	%orig(arg1);
}

-(void)wallpaperLegibilitySettingsDidChange:(id)arg1 forVariant:(long long)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(BOOL)promptUnlockForAppActivation:(id)arg1 withCompletion:(/*^block*/id)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(id)fakeStatusBarStyleRequestForStyle:(long long)arg1 {
	%log;
	return %orig(arg1);
}

-(id)_fakeSpringBoardStatusBar {
	%log;
	return %orig;
}

-(void)launchIcon:(id)arg1 fromLocation:(int)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)activateApplicationAnimatedFromIcon:(id)arg1 fromLocation:(int)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)_lockOrientationForTransition {
	%log;
	%orig;
}

-(void)_releaseTransitionOrientationLock {
	%log;
	%orig;
}

-(void)restoreContentAndUnscatterIconsAnimated:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(BOOL)isHandlingHomeButtonPress {
	%log;
	return %orig;
}

-(void)_noteMainSceneCreatedForApp:(id)arg1 {
	%log;
	%orig(arg1);
}

-(id)_toggleSwitcherAfterLaunchApp {
	%log;
	return %orig;
}

-(id)switcherWindow {
	%log;
	return %orig;
}

-(void)openNewsstand {
	%log;
	%orig;
}

-(void)dismissSwitcherForAlert:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)requestApplicationEventsEnabledIfNecessary {
	%log;
	%orig;
}

-(CGAffineTransform)_portraitViewTransformForSwitcherSize:(CGSize)arg1 orientation:(long long)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(double)_contentRotationForOrientation:(long long)arg1 {
	%log;
	return %orig(arg1);
}

-(float)batteryCapacity {
	%log;
	return %orig;
}

-(int)displayBatteryCapacityAsPercentage {
	%log;
	return %orig;
}

-(BOOL)isBatteryCharging {
	%log;
	return %orig;
}

-(BOOL)isConnectedToChargeIncapablePowerSource {
	%log;
	return %orig;
}

-(BOOL)isConnectedToUnsupportedChargingAccessory {
	%log;
	return %orig;
}

-(BOOL)supportsDetailedBatteryCapacity {
	%log;
	return %orig;
}

-(void)forceIconInterfaceOrientation:(long long)arg1 duration:(double)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)disableAnimationForNextIconRotation {
	%log;
	%orig;
}

-(BOOL)isHeadsetDocked {
	%log;
	return %orig;
}

-(BOOL)isHeadsetBatteryCharging {
	%log;
	return %orig;
}

-(unsigned char)headsetBatteryCapacity {
	%log;
	return %orig;
}

-(id)systemGestureSnapshotWithIOSurfaceSnapshotOfApp:(id)arg1 includeStatusBar:(BOOL)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(id)systemGestureSnapshotForApp:(id)arg1 includeStatusBar:(BOOL)arg2 decodeImage:(BOOL)arg3 {
	%log;
	return %orig(arg1, arg2, arg3);
}

-(void)handleFluidScaleSystemGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)handleFluidHorizontalSystemGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)handleFluidVerticalSystemGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)handleShowNotificationsSystemGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)handleHideNotificationsSystemGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)handleDismissBannerSystemGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)handleShowControlCenterSystemGesture:(id)arg1 {
	%log;
	%orig(arg1);
}

-(BOOL)shouldSendTouchesToSystemGestures {
	%log;
	return %orig;
}

-(void)animationStepperFinishBackwardToStartCompleted:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)cleanupRunningGestureIfNeeded {
	%log;
	%orig;
}

-(void)removeAppFromSwitchAppList:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)prefetchAdjacentAppsAndEvictRemotes:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)programmaticSwitchAppGestureMoveToLeft {
	%log;
	%orig;
}

-(void)programmaticSwitchAppGestureMoveToRight {
	%log;
	%orig;
}

-(BOOL)hasPendingAppActivatedByGesture {
	%log;
	return %orig;
}

-(BOOL)_canPresentCenterController:(id)arg1 {
	%log;
	return %orig(arg1);
}

-(void)_returnToRemoteAlertFromSwitcher:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_runAppSwitcherDismissTest {
	%log;
	%orig;
}

-(void)_runAppSwitcherBringupTest {
	%log;
	%orig;
}

-(id)switcherController {
	%log;
	return %orig;
}

-(double)_appSwitcherRevealAnimationDelay {
	%log;
	return %orig;
}

-(void)_accessibilityWillBeginAppSwitcherRevealAnimation {
	%log;
	%orig;
}

-(void)dismissSwitcherAnimated:(BOOL)arg1 {
	%log;
	%orig(arg1);
}


-(id)window {
	%log;
	return %orig;
}

-(id)init {
	%log;
	return %orig;
}

-(BOOL)shouldWindowUseOnePartInterfaceRotationAnimation:(id)arg1 {
	%log;
	return %orig(arg1);
}

-(BOOL)window:(id)arg1 shouldAutorotateToInterfaceOrientation:(long long)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(void)window:(id)arg1 willRotateToInterfaceOrientation:(long long)arg2 duration:(double)arg3 {
	%log;
	%orig(arg1, arg2, arg3);
}

-(id)rotatingContentViewForWindow:(id)arg1 {
	%log;
	return %orig(arg1);
}

-(void)window:(id)arg1 willAnimateRotationToInterfaceOrientation:(long long)arg2 duration:(double)arg3 {
	%log;
	%orig(arg1, arg2, arg3);
}

-(void)window:(id)arg1 didRotateFromInterfaceOrientation:(long long)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(id)contentView {
	%log;
	return %orig;
}

-(void)animationDidStop:(id)arg1 finished:(BOOL)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(id)rotatingFooterViewForWindow:(id)arg1 {
	%log;
	return %orig(arg1);
}

-(void)getRotationContentSettings:(id)arg1 forWindow:(id)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)settings:(id)arg1 changedValueForKey:(id)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(id)_legibilitySettings {
	%log;
	return %orig;
}

-(void)_setHidden:(BOOL)arg1 {
	%log;
	%orig(arg1);
}

-(double)ambiguousControlCenterActivationMargin {
	%log;
	return %orig;
}

-(void)_showNotificationsGestureBeganWithLocation:(CGPoint)arg1 {
	%log;
	%orig(arg1);
}

-(void)_showNotificationsGestureEndedWithLocation:(CGPoint)arg1 velocity:(CGPoint)arg2 {
	%log;
	%orig(arg1, arg2);
}

-(void)activeInterfaceOrientationWillChangeToOrientation:(long long)arg1 {
	%log;
	%orig(arg1);
}

-(void)activeInterfaceOrientationDidChangeToOrientation:(long long)arg1 willAnimateWithDuration:(double)arg2 fromOrientation:(long long)arg3 {
	%log;
	%orig(arg1, arg2, arg3);
}

-(BOOL)allowSystemGestureType:(unsigned long long)arg1 atLocation:(CGPoint)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(void)_hideKeyboard {
	%log;
	%orig;
}

%end

