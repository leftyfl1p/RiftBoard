
// ********************************************
// Created by Code Logging Creator
// ********************************************


%hook SBUIAnimationZoomUpApp

-(void)prepareZoom {
	%log;
	%orig;
}

-(double)animationDelay {
	%log;
	return %orig;
}

-(void)animateZoomWithCompletion:(/*^block*/id)arg1 {
	%log;
	%orig(arg1);
}

-(void)_prepareAnimation {
	%log;
	%orig;
}

-(void)_cleanupAnimation {
	%log;
	%orig;
}

-(id)_animationProgressDependency {
	%log;
	return %orig;
}

-(void)_applicationDependencyStateChanged {
	%log;
	%orig;
}

-(id)initWithActivatingApp:(id)arg1 {
	%log;
	return %orig(arg1);
}

-(void)animateFakeStatusBarWithParameters:(id)arg1 {
	%log;
	%orig(arg1);
}

-(void)cleanupZoom {
	%log;
	%orig;
}

-(void)_maybeStartCrossfade {
	%log;
	%orig;
}

-(void)_noteContextHostCrossfadeDidFinish {
	%log;
	%orig;
}

-(void)_maybeReportAnimationFinished {
	%log;
	%orig;
}

-(BOOL)_waitsForApplicationActivationIfNecessary {
	%log;
	return %orig;
}

-(BOOL)isReasonableMomentToInterrupt {
	%log;
	return %orig;
}

-(void)_noteZoomDidFinish {
	%log;
	%orig;
}

-(id)appStatusBarTransitionInfoWithStartStyleRequest:(id)arg1 startOrientation:(long long)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(void)noteDependencyDidInvalidate {
	%log;
	%orig;
}

-(BOOL)_shouldWaitForSiriDismissBeforeZooming {
	%log;
	return %orig;
}

-(long long)animationTransition {
	%log;
	return %orig;
}

-(void)setAnimationTransition:(long long)arg1 {
	%log;
	%orig(arg1);
}

-(void)_startAnimation {
	%log;
	%orig;
}



-(double)animationDuration {
	%log;
	return %orig;
}

%end

