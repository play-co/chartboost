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


/* More Apps */


/*
 Cache an "more applications" at the given CBLocation.
 This method will first check if there is a locally cached "more applications"
 for the given CBLocation and, if found, will do nothing. If no locally cached
 data exists the method will attempt to fetch data from the Chartboost API
 server.
 */
- (void) cacheMoreApps:(NSDictionary *)jsonObject {
	[Chartboost cacheMoreApps:CBLocationLevelComplete];
}

/*
 Present an "more applications" for the given CBLocation.
 @discussion This method will first check if there is a locally cached "more
 applications" for the given CBLocation and, if found, will present using the
 locally cached data.  If no locally cached data exists the method will attempt
 to fetch data from the Chartboost API server and present it.  If the
 Chartboost API server is unavailable or there is no eligible "more
 applications" to present in the given CBLocation this method is a no-op.
 */
- (void) showMoreApps:(NSDictionary *)jsonObject {
	[Chartboost showMoreApps:CBLocationLevelComplete];
}

- (void) showMoreAppsIfAvailable:(NSDictionary *)jsonObject {
	if([Chartboost hasMoreApps:CBLocationLevelComplete]) {
		NSLOG(@"{chartboost} Showing Cached 'More Apps'");
		[Chartboost showMoreApps:CBLocationLevelComplete];
	}
}

/*
 Called after an "more applications" has been loaded from the Chartboost API
 servers and cached locally.
 @discussion Implement to be notified of when an "more applications" has been
 loaded from the Chartboost API servers and cached locally for a given
 CBLocation.
 */
- (void)didCacheMoreApps:(CBLocation)location {
	NSLog(@"{chartboost} 'more apps' cached at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostMoreAppsAvailable",@"name",
		nil]];
}

/*!
 Called after an "more applications" has attempted to load from the Chartboost
 API servers but failed.
 @discussion Implement to be notified of when an "more applications" has
 attempted to load from the Chartboost API servers but failed for a given
 CBLocation.
 */
- (void)didFailToLoadMoreApps:(CBLocation)location withError:(CBLoadError)error {
	NSLog(@"{chartboost} 'more apps' failed to load at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostMoreAppsFailedToLoad",@"name",
		nil]];
}

/*!
 Called after an "more applications" has been displayed on the screen.
 @discussion Implement to be notified of when an "more applications" has
 been displayed on the screen for a given CBLocation.
 */
- (void)didDisplayMoreApps:(CBLocation)location {
	NSLog(@"{chartboost} displayed 'more apps' at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostMoreAppsDisplayed",@"name",
		nil]];
}

/*!
 Called after an "more applications" has been dismissed.
 @discussion Implement to be notified of when an "more applications" has been
 dismissed for a given CBLocation.  "Dismissal" is defined as any action that
 removed the "more applications" UI such as a click or close.
 */
- (void)didDismissMoreApps:(CBLocation)location {
	NSLog(@"{chartboost} dismissed 'more apps' at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostMoreAppsDismissed",@"name",
		nil]];
}

/*!
 Called after an "more applications" has been closed.
 @discussion Implement to be notified of when an "more applications" has been
 closed for a given CBLocation.  "Closed" is defined as clicking the close
 interface for the "more applications".
 */
- (void)didCloseMoreApps:(CBLocation)location {
	NSLog(@"{chartboost} closed 'more apps' at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostMoreAppsClosed",@"name",
		nil]];
}

/*!
 @abstract
 Called after an "more applications" has been clicked.
 @discussion Implement to be notified of when an "more applications" has been
 clicked for a given CBLocation.  "Clicked" is defined as clicking the creative
 interface for the "more applications".
 */
- (void)didClickMoreApps:(CBLocation)location {
	NSLog(@"{chartboost} clicked 'more apps' at location %@", location);
	[[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
		@"ChartboostMoreAppsClicked",@"name",
		nil]];
}
@end
