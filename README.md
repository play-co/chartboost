# Game Closure DevKit Plugin: Chartboost

This plugin allows you to show interstitials using the
[Chartboost](https://chartboost.com/) toolkit. Both iOS and Android targets are
supported.


## Installation

Install the chartboost module into your application using the standard devkit
install process:

~~~
devkit install https://github.com/gameclosure/chartboost#v2.0.0
~~~


## Setup

Before you can use chartboost you must specify your game's AppID and
AppSignature from the chartboost dashboard. Edit the `manifest.json
"android" and "ios" sections to include `chartboostAppID` and
`chartboostAppSignature` as shown below.

~~~
	"android": {
		"chartboostAppID": "51de21ed17ba477663000050",
		"chartboostAppSignature": "079827b6a0e831ef37ead6a2334bc712f28f9a1f"
	},
~~~

~~~
	"ios": {
		"chartboostAppID": "51de1c4f17ba47cd62000000",
		"chartboostAppSignature": "4a86b060d0f5c17a34f48bedf49c8a63280607ce"
	},
~~~

Note that the manifest keys are case-sensitive.

You can test for successful integration via the Chartboost website after
successfully building and running your game on a network-connected device.


## Usage

To start using Chartboost in your game, first import the chartboost object:

~~~
import chartboost;
~~~


#### Methods
The chartboost plugin provides methods that you can call to cause actions like
preloading or displaying an ad (or video, or 'more apps' popup). These generally
follow the same pattern of showThing, cacheThing, and showThingIfAvailable.

#### Events
The chartboost plugin emits several events that your application can listen for
to react to various states of the plugin. You do not need to do anything with
these events unless you want to do some custom action (analytics, wait for
cached ads, etc) when one of these events occurs. Some events overlap, like
clicked/closed and dismissed - only listen for what you are interested in.


### Interstitial Ads

You can show interstitials by calling:

~~~
chartboost.showInterstitial();
~~~

To improve user experience, you can pre-load and cache interstitial ads by first
calling:

~~~
chartboost.cacheInterstitial();
~~~

The chartboost plugin also provides a helper function that will show an
interstitial, but only if one is cached:

~~~
chartboost.showInterstitialIfAvailable();
~~~

#### Events
`AdAvailable` - emitted when an ad has been cached and is ready to be
shown
`AdFailedToLoad` - emitted when an ad fails to load from the
chartboost servers
`AdDisplayed` - emitted when an ad is shown to a user
`AdDismissed` - emitted when an ad goes away, either from the user
clicking it or closing it
`AdClosed` - emitted when an ad is closed by the user
`AdClicked` - emitted when an ad is clicked by the user

Example:
~~~
chartboost.on('AdClicked', function () { logger.log('user clicked an ad!'); });
~~~


### More Apps

Control the 'more apps' feature in the same way as interstitial ads:

~~~
// show 'more apps' now, regardless of cache
chartboost.showMoreApps();

// load and cache 'more apps' for displaying later
chartboost.cacheMoreApps();

// display 'more apps' if one has been cached
chartboost.showMoreAppsIfAvailable();
~~~

#### Events
`MoreAppsAvailable` - emitted when a 'more apps' dialog is ready
`MoreAppsFailedToLoad` - emitted when a 'more apps' fails to load from
the chartboost servers
`MoreAppsDisplayed` - emitted when a 'more apps' is shown to a user
`MoreAppsDismissed` - emitted when a 'more apps' goes away, either
from the user clicking it or closing it
`MoreAppsClosed` - emitted when a 'more apps' is closed by the user
`MoreAppsClicked` - emitted when a 'more apps' is clicked by the user

Example:
~~~
chartboost.on('MoreAppsClicked', function () {
  logger.log('user clicked on more apps!');
});
~~~


## Chartboost SDK
The chartboost plugin is currently using version 5.1.0 of the chartboost SDK on
both android and ios.

NOTE: On ios, their SDK directory structure has been slightly changed to remove
the symlinks they ship with and delete the extra Versions folder (leaving it
like a standard framework folder with Chartboost and Headers at the top level).
If you change the SDK, you will likely need to repeat the above change.


## Demo
Check out the [chartboost demo
app](https://github.com/gameclosure/demoChartboost) for a working example.

![chartboost demo](http://storage.googleapis.com/devkit-modules/chartboost/chartboost_screenshot.png)
