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

/* Interstitial Ads */
- (void) cacheInterstitial:(NSDictionary *)jsonObject {
	[Chartboost cacheInterstitial:CBLocationLevelComplete];
}

- (void) showInterstitial:(NSDictionary *)jsonObject {
	[Chartboost showInterstitial:CBLocationLevelComplete];
}

- (void) showInterstitialIfAvailable:(NSDictionary *)jsonObject {
	if([Chartboost hasInterstitial:CBLocationLevelComplete]) {
		NSLOG(@"{chartboost} Showing Cached Interstitial");
		[Chartboost showInterstitial:CBLocationLevelComplete];
	}
}

/*
   Called after an interstitial has been loaded from the Chartboost API
   servers and cached locally.
*/
- (void)didCacheInterstitial:(CBLocation)location {
	NSLog(@"{chartboost} interstitial cached at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdAvailable",@"name",
		nil]];
}

/*
 Called after an interstitial has attempted to load from the Chartboost API
 servers but failed.
 */
- (void)didFailToLoadInterstitial:(CBLocation)location withError:(CBClickError)error {
	NSLog(@"{chartboost} failure to load interstitial at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdFailedToLoad",@"name",
		nil]];
}


/*
 Called after an interstitial has been displayed on the screen.
 */
- (void)didDisplayInterstitial:(CBLocation)location {
	NSLog(@"{chartboost} displayed interstitial at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdDisplayed",@"name",
		nil]];
}

/*
 Called after an interstitial has been dismissed.
 "Dismissal" is defined as any action that removed the interstitial UI such as a click or close.
 */
- (void)didDismissInterstitial:(CBLocation)location {
	NSLog(@"{chartboost} dismissed interstitial at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdDismissed",@"name",
		nil]];
}

/*
 Called after an interstitial has been closed.
 "Closed" is defined as clicking the close interface for the interstitial.
 */
- (void)didCloseInterstitial:(CBLocation)location {
	NSLog(@"{chartboost} closed interstitial at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdClosed",@"name",
		nil]];
}

/*
 Called after an interstitial has been clicked.
 "Clicked" is defined as clicking the creative interface for the interstitial.
 */
- (void)didClickInterstitial:(CBLocation)location {
	NSLog(@"{chartboost} clicked interstitial at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostAdClicked",@"name",
		nil]];
}
@end
