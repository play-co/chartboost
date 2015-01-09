import event.Emitter as Emitter;

var Chartboost = Class(Emitter, function (supr) {

  this.init = function (opts) {
    supr(this, 'init', [opts]);
    this._createEventListeners();
  };

  this._createEventListeners = function () {

    // EVENTS
    NATIVE.events.registerHandler("ChartboostAdAvailable", bind(this, function () {
      logger.log("{chartboost} ad available");
      this.emit("AdAvailable");
    }));

    NATIVE.events.registerHandler("ChartboostAdFailedToLoad", bind(this, function () {
      logger.log("{chartboost} ad failed to load");
      this.emit("AdFailedToLoad");
    }));

    NATIVE.events.registerHandler("ChartboostAdDisplayed", bind(this, function () {
      logger.log("{chartboost} ad displayed");
      this.emit("AdDisplayed");
    }));

    NATIVE.events.registerHandler("ChartboostAdDismissed", bind(this, function () {
      logger.log("{chartboost} ad dismissed");
      this.emit("AdDismissed");
    }));

    NATIVE.events.registerHandler("ChartboostAdClosed", bind(this, function () {
      logger.log("{chartboost} ad closed");
      this.emit("AdClosed");
    }));

    NATIVE.events.registerHandler("ChartboostAdClicked", bind(this, function () {
      logger.log("{chartboost} ad clicked");
      this.emit("AdClicked");
    }));

  };

  // METHODS
  this.showInterstitial = function() {
    NATIVE.plugins.sendEvent(
      "ChartboostPlugin", "showInterstitial", JSON.stringify({})
    );
  };

  this.showInterstitialIfAvailable = function() {
    NATIVE.plugins.sendEvent(
      "ChartboostPlugin", "showInterstitialIfAvailable", JSON.stringify({})
    );
  };

  this.cacheInterstitial = function() {
   NATIVE.plugins.sendEvent(
      "ChartboostPlugin", "cacheInterstitial", JSON.stringify({})
    );
  };
});

exports = new Chartboost();
