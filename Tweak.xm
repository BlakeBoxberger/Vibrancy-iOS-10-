@interface SBDashBoardView
- (void)setDateViewIsVibrant:(BOOL)arg1;
@end

@interface SBAnimationSettings
@property(nonatomic) long long animationType;
@end

@interface SBFadeAnimationSettings
@property(retain, nonatomic) SBAnimationSettings *dateInSettings;
- (void)setDefaultValues;
@end

%group vibrancy
%hook SBDashBoardView

- (void)setDateViewIsVibrant:(BOOL)arg1
{
	%orig(YES);
}

%end

%hook SBFadeAnimationSettings

- (void)setDefaultValues
{
    %orig;
		self.dateInSettings = nil;
}

%end
%end

%ctor {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/TimeMover.dylib"]){
    	// Do nothing.
	} else {
		%init(vibrancy);
	}
}