# Game Closure DevKit Plugin: Chartboost

This plugin allows you to collect analytics using the [Chartboost](https://chartboost.com/) toolkit.  Both iOS and Android targets are supported.

## Usage

Install the addon with `basil install chartboost`.

Include it in the `manifest.json` file under the "addons" section for your game:

~~~
"addons": [
	"chartboost"
],
~~~

To specify your game's AppID and AppSignature, edit the `manifest.json "android" and "ios" sections as shown below:

~~~
	"android": {
		"versionCode": 1,
		"icons": {
			"36": "resources/icons/android36.png",
			"48": "resources/icons/android48.png",
			"72": "resources/icons/android72.png",
			"96": "resources/icons/android96.png"
		},
		"chartboostAppID": "51de21ed17ba477663000050",
		"chartboostAppSignature": "079827b6a0e831ef37ead6a2334bc712f28f9a1f"
	},
~~~

~~~
	"ios": {
		"bundleID": "mmp",
		"appleID": "568975017",
		"version": "1.0.3",
		"icons": {
			"57": "resources/images/promo/icon57.png",
			"72": "resources/images/promo/icon72.png",
			"114": "resources/images/promo/icon114.png",
			"144": "resources/images/promo/icon144.png"
		},
		"chartboostAppID": "51de1c4f17ba47cd62000000",
		"chartboostAppSignature": "4a86b060d0f5c17a34f48bedf49c8a63280607ce"
	},
~~~

Note that the manifest keys are case-sensitive.

You can test for successful integration via the Chartboost website after successfully building and running your game on a network-connected device.

To show interstitials using Chartboost in your game, import the chartboost object:

~~~
import plugins.chartboost.chartBoost as chartBoost;
~~~

Then show interstitials by calling:

~~~
chartBoost.showInterstitial();
~~~
