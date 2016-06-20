%hook SBWallpaperLegibilitySettingsProvider
- (void)wallpaperLegibilitySettingsDidChange:(id)arg1 forVariant:(long long)arg2 {
	%log;
	%orig;
}
- (void)wallpaperDidChangeForVariant:(long long)arg1 {
	%log;
	%orig;
}
%end

%hook _SBAccessibilityTintView
- (void)_updateBackgroundColor {
	%log;
	%orig;
}
- (void)wallpaperLegibilitySettingsDidChange:(id)arg1 forVariant:(long long)arg2 {
	%log;
	%orig;
}
- (void)wallpaperDidChangeForVariant:(long long)arg1 {
	%log;
	%orig;
}

%end

%hook _SBIconWallpaperColorProvider
- (void)_updateColors {
	%log;
	%orig;
}
- (void)_updateBlurForClient:(id)arg1 {
	%log;
	%orig;
}
- (void)_updateClient:(id)arg1 {
	%log;
	%orig;
}
- (void)_updateAllClients {
	%log;
	%orig;
}
- (void)wallpaperGeometryDidChangeForVariant:(long long)arg1 {
	%log;
	%orig;
}
- (void)wallpaperLegibilitySettingsDidChange:(id)arg1 forVariant:(long long)arg2 {
	%log;
	%orig;
}
- (void)wallpaperDidChangeForVariant:(long long)arg1 {
	%log;
	%orig;
}
%end

%hook SBWallpaperEffectView

- (void)_updateWallpaperAverageColor:(id)arg1 {
	%log;
	%orig;
}
- (void)wallpaperDidChangeForVariant:(long long)arg1 {
	%log;
	%orig;
}
- (void)wallpaperLegibilitySettingsDidChange:(id)arg1 forVariant:(long long)arg2 {
	%log;
	%orig;
}

%end

%hook _UILegibilityImageView

- (BOOL)_shouldAnimatePropertyWithKey:(id)arg1 {
	%log;
	return %orig;
}
%end

%hook SBWallpaperController

- (void)providerLegibilitySettingsChanged:(id)arg1 {
	%log;
	%orig;
}

- (void)_handleWallpaperGeometryChangedForVariant:(long long)arg1 {
	%log;
	%orig;
}
- (void)_handleWallpaperLegibilitySettingsChanged:(id)arg1 forVariant:(long long)arg2 {
	%log;
	%orig;
}
- (void)_handleWallpaperChangedForVariant:(long long)arg1 {
	%log;
	%orig;
}

- (id)legibilitySettingsForVariant:(long long)arg1 {
	%log;
	return %orig;
}

- (void)_clearHomescreenLightForegroundBlurColor {
	%log;
	%orig;
}
- (void)_createHomescreenLightForegroundBlurColorIfNecessary {
	%log;
	%orig;
}
- (void)_updateBlurGeneration {
	%log;
	%orig;
}
%end

%hook _UILegibilitySettings

- (id)shadowColor {
	if(testing) {
		return [UIColor blueColor];
	}

	return [UIColor greenColor];
}

%end


%hook SBIconViewMap

%new
-(void)test {
	NSMapTable *_labelsForIcons = MSHookIvar<NSMapTable *>(self,"_labelsForIcons");
	HBLogDebug(@"_labelsForIcons: %@", _labelsForIcons);


}

%end

%hook SBUIController

%new
- (UIImage *)captureView:(UIView *)view {

    //hide controls if needed
    CGRect rect = [view bounds];

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];   
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;

}


- (void)wallpaperDidChangeForVariant:(long long)arg1 {
	%log;
	%orig;
}
- (void)wallpaperLegibilitySettingsDidChange:(id)arg1 forVariant:(long long)arg2 {
	%log;
	%orig;
}


%new;
-(void)testing {
	testing = testing? NO:YES;
}

//xpc blur preview
%new
-(NSDictionary*)ContentViewImage:(NSDictionary*)info {
	NSData *imageData = UIImagePNGRepresentation([self captureView:[[%c(SBIconController) sharedInstance] view]]);

	NSDictionary *dictionary = @{
    @"image" : imageData,
	};


	return dictionary;
}

%end


