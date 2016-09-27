#include "RBTranslationsListController.h"

@implementation RBTranslationsListController

- (NSArray *)specifiers {
	return [super specifiers];
}

+(NSString *)hb_specifierPlist {
	return @"RiftBoardTranslations";
}

- (NSString *)valueForSpecifier:(PSSpecifier *)specifier {
	NSDictionary *dict = @{
		@"한국어" : @"/u/zenyr",				//Korean
		@"Malti" : @"gertab",				//Maltese
		@"Türkçe" : @"oguzhanvarsak",		//Turkish
		@"suomalainen" : @"/u/mikkoko",		//Finnish idk
		@"Română" : @"/u/blackdeath19",		//Romanian idk
		@"català" : @"Quan van der Knokke",	//catalan
		@"Melayu" : @"/u/redzrex",			//Malay
		@"العربية" : @"/u/aofathy",			//Arabian? idk
		@"עברית" : @"ארן שביט",				//Hebrew
	};
	return dict[specifier.name];
}

@end