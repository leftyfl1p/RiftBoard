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
		@"suomalainen" : @"/u/mikkoko",		//Finnish
		@"Română" : @"/u/blackdeath19",		//Romanian
		@"català" : @"Quan van der Knokke",	//Catalan
		@"Melayu" : @"/u/redzrex",			//Malay
		@"العربية" : @"/u/aofathy",			//Arabian
		@"עברית" : @"ארן שביט",				//Hebrew
		@"Deutsch" : @"Louis",				//German
		@"Русский" : @"/u/25element",		//Russian
		@"Español" : @"/u/eduardopy",       //Spanish
	};
	return dict[specifier.name];
}

@end