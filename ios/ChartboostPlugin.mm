#import "ChartboostPlugin.h"
#import "Chartboost.h"

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
		NSString *appID = [ios valueForKey:@"ChartboostAppID"];
		NSString *appSignature = [ios valueForKey:@"ChartboostAppSignature"];

		Chartboost *cb = [Chartboost sharedChartboost];
		cb.appId = appID;
		cb.appSignature = appSignature;

		[cb startSession];

		NSLog(@"{chartboost} Initialized with manifest AppID: '%@'", appID);
	}
	@catch (NSException *exception) {
		NSLog(@"{chartboost} Failure to get ios:Chartboost keys from manifest file: %@", exception);
	}
}

@end

