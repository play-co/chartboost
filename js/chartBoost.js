import util.setProperty as setProperty;

var onAdDismissed, onAdAvailable, onAdNotAvailable;

var Chartboost = Class(function () {
	this.init = function(opts) {

		setProperty(this, "onAdDismissed", {
			set: function(f) {
				if (typeof f === "function") {
					onAdDismissed = f;
				} else {
					onAdDismissed = null;
				}
			},
			get: function() {
				return onOfferClose;
			}
		});

		setProperty(this, "onAdAvailable", {
			set: function(f) {
				if (typeof f === "function") {
					onAdAvailable = f;
				} else {
					onAdAvailable = null;
				}
			},
			get: function() {
				return onAdAvailable;
			}
		});

		setProperty(this, "onAdNotAvailable", {
			set: function(f) {
				if (typeof f === "function") {
					onAdNotAvailable = f;
				} else {
					onAdNotAvailable = null;
				}
			},
			get: function() {
				return onAdNotAvailable;
			}
		});

		NATIVE.events.registerHandler("ChartboostAdDismissed", function() {
			logger.log("{chartboost} ad dismissed ");
			if (typeof onAdDismissed === "function") {
				onAdDismissed();
			}
		});

		NATIVE.events.registerHandler("ChartboostAdAvailable", function() {
			logger.log("{chartboost} ad available");
			if (typeof onAdAvailable === "function") {
				onAdAvailable("chartboost");
			}
		});

		NATIVE.events.registerHandler("ChartboostAdNotAvailable", function() {
			logger.log("{chartboost} ad not available");
			if (typeof onAdNotAvailable === "function") {
				onAdNotAvailable();
			}
		});

	}
	this.showInterstitial = function() {
		NATIVE.plugins.sendEvent("ChartboostPlugin", "showInterstitial", JSON.stringify({}));
	};

	this.cacheInterstitial = function() {
		NATIVE.plugins.sendEvent("ChartboostPlugin", "cacheInterstitial", JSON.stringify({}));
	}
});

exports = new Chartboost();
