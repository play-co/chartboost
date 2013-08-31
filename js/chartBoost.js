var Chartboost = Class(function () {
	this.showInterstitial = function() {
		NATIVE.plugins.sendEvent("ChartboostPlugin", "showInterstitial", JSON.stringify({}));
	};

	this.cacheInterstitial = function() {
		NATIVE.plugins.sendEvent("ChartboostPlugin", "cacheInterstitial", JSON.stringify({}));
	}
});

exports = new Chartboost();
