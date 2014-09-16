#import "ChartboostPlugin.h"
#import "platform/log.h"

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

	return self;
}

- (void) initializeWithManifest:(NSDictionary *)manifest appDelegate:(TeaLeafAppDelegate *)appDelegate {
	@try {
		NSDictionary *ios = [manifest valueForKey:@"ios"];
		NSString *appID = [ios valueForKey:@"chartboostAppID"];
		NSString *appSignature = [ios valueForKey:@"chartboostAppSignature"];

		// Initialize the Chartboost library
		[Chartboost startWithAppId:appID
			appSignature:appSignature
			delegate:self];

		NSLOG(@"{chartboost} Initialized with manifest AppID: '%@'", appID);
	}
	@catch (NSException *exception) {
		NSLOG(@"{chartboost} Failure to get ios:Chartboost keys from manifest file: %@", exception);
	}
}

- (void) cacheInterstitial:(NSDictionary *)jsonObject {
	[Chartboost cacheInterstitial:CBLocationLevelComplete];
}

- (void) showInterstitial:(NSDictionary *)jsonObject {
	if([Chartboost hasInterstitial:CBLocationLevelComplete]) {
		[Chartboost showInterstitial:CBLocationLevelComplete];
	}
}

- (void)didDismissInterstitial:(CBLocation)location {
	NSLog(@"{chartboost} dismissed interstitial at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdDismissed",@"name",
		nil]];
}

- (void)didFailToLoadInterstitial:(CBLocation)location withError:(CBClickError)error {
	NSLog(@"{chartboost} failure to load interstitial at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdNotAvailable",@"name",
		nil]];
}

- (void)didCacheInterstitial:(CBLocation)location {
	NSLog(@"{chartboost} interstitial cached at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdAvailable",@"name",
		nil]];
}
@end
