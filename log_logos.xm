
// ********************************************
// Created by Code Logging Creator
// ********************************************



@interface SBAppWindow : UIWindow

@end




%hook SBAppWindow

+(UIEdgeInsets)_jailInsetsForScreen:(id)arg1 {
	%log;
	return %orig(arg1);
}

+(CGRect)_actualBoundsForScreen:(id)arg1 withJailBehavior:(int)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(void)setAlphaAndObeyBecauseIAmTheWindowManager:(double)arg1 {
	%log;
	%orig(arg1);
}

-(id)initWithScreen:(id)arg1 debugName:(id)arg2 {
	%log;
	return %orig(arg1, arg2);
}

-(id)initWithScreen:(id)arg1 layoutStrategy:(id)arg2 debugName:(id)arg3 scene:(id)arg4 {
	%log;
	return %orig(arg1, arg2, arg3, arg4);
}

-(id)recycledViewsContainer {
	%log;
	return %orig;
}

-(id)initWithScreen:(id)arg1 debugName:(id)arg2 scene:(id)arg3 {
	%log;
	return %orig(arg1, arg2, arg3);
}

-(id)initWithScreen:(id)arg1 layoutStrategy:(id)arg2 debugName:(id)arg3 {
	%log;
	return %orig(arg1, arg2, arg3);
}

-(id)_initWithScreen:(id)arg1 layoutStrategy:(id)arg2 debugName:(id)arg3 scene:(id)arg4 {
	%log;
	return %orig(arg1, arg2, arg3, arg4);
}

-(UIEdgeInsets)jailInsets {
	%log;
	return %orig;
}

-(id)layoutStrategy {
	%log;
	return %orig;
}

-(id)initWithFrame:(CGRect)arg1 {
	%log;
	return %orig(arg1);
}



-(BOOL)_isConstrainedByScreenJail {
	%log;
	return %orig;
}

-(BOOL)_isClippedByScreenJail {
	%log;
	return %orig;
}

%end

