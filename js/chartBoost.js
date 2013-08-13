var Chartboost = Class(function () {
	this.showInterstitial = function() {
		logger.log("{chartboost}, showing interstitial");
		NATIVE && NATIVE.plugins && NATIVE.plugins.sendEvent &&
			NATIVE.plugins.sendEvent("ChartboostPlugin", "showInterstitial",
				JSON.stringify({}));
	};
});

exports = new Chartboost();
