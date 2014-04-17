#import "ChartboostPlugin.h"

@implementation ChartboostPlugin

// The plugin must call super dealloc.
- (void) dealloc {
	[super dealloc];
}

// The plugin must call super init.
- (id) init {
	self = [super init];
	if (!self) {
		return nil;
	}
	self.cb = nil;

	return self;
}

- (void) initializeWithManifest:(NSDictionary *)manifest appDelegate:(TeaLeafAppDelegate *)appDelegate {
	@try {
		NSDictionary *ios = [manifest valueForKey:@"ios"];
		NSString *appID = [ios valueForKey:@"chartboostAppID"];
		NSString *appSignature = [ios valueForKey:@"chartboostAppSignature"];

		self.cb = [Chartboost sharedChartboost];
		self.cb.appId = appID;
		self.cb.appSignature = appSignature;
		self.cb.delegate = self;

		[self.cb startSession];

		NSLog(@"{chartboost} Initialized with manifest AppID: '%@'", appID);
	}
	@catch (NSException *exception) {
		NSLog(@"{chartboost} Failure to get ios:Chartboost keys from manifest file: %@", exception);
	}
}

- (void) cacheInterstitial:(NSDictionary *)jsonObject {
	[self.cb cacheInterstitial];
}

- (void) showInterstitial:(NSDictionary *)jsonObject {
	if([self.cb hasCachedInterstitial]) {
		[self.cb showInterstitial];
	}
}

- (void)didDismissInterstitial:(NSString *)location {
	NSLog(@"{chartboost} dismissed interstitial at location %@", location);
    [[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"ChartboostAdDismissed",@"name",
                                          nil]];
}

- (void)didFailToLoadInterstitial:(NSString *)location {
	NSLog(@"{chartboost} failure to load interstitial at location %@", location);
    [[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"ChartboostAdNotAvailable",@"name",
                                          nil]];
}

- (void)didCacheInterstitial:(NSString *)location {
	NSLog(@"{chartboost} interstitial cached at location %@", location);
    [[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"ChartboostAdAvailable",@"name",
                                          nil]];
}
@end
