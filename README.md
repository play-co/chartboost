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

To show interstitials using Chartboost in your game, import the chartboost
object:

~~~
import chartboost;
~~~

Then show interstitials by calling:

~~~
chartboost.showInterstitial();
~~~

## Demo
Check out the [chartboost demo
app](https://github.com/gameclosure/demoChartboost) for a working example.

![chartboost demo](http://storage.googleapis.com/devkit-modules/chartboost/chartboost_screenshot.png)
