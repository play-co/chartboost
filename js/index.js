import event.Emitter as Emitter;
var events = {
  'ChartboostAdAvailable': 'AdAvailable',
  'ChartboostAdFailedToLoad': 'AdFailedToLoad',
  'ChartboostAdDisplayed': 'AdDisplayed',
  'ChartboostAdDismissed': 'AdDismissed',
  'ChartboostAdClicked': 'AdClicked',
  'ChartboostAdClosed': 'AdClosed',

  'ChartboostMoreAppsAvailable': 'MoreAppsAvailable',
  'ChartboostMoreAppsFailedToLoad': 'MoreAppsFailedToLoad',
  'ChartboostMoreAppsDisplayed': 'MoreAppsDisplayed',
  'ChartboostMoreAppsDismissed': 'MoreAppsDismissed',
  'ChartboostMoreAppsClicked': 'MoreAppsClicked',
  'ChartboostMoreAppsClosed': 'MoreAppsClosed'
};

var Chartboost = Class(Emitter, function (supr) {

  this.init = function (opts) {
    supr(this, 'init', [opts]);
    this._addChartboostMethods();
    this._createEventListeners();
  };

  this._sendEmptyEvent = function (eventName) {
    NATIVE.plugins.sendEvent('ChartboostPlugin', eventName, '{}');
  };

  this._addChartboostMethods = function () {
    // interstitial ads
    this.showInterstitial = function () {
      this._sendEmptyEvent('showInterstitial');
    };

    this.showInterstitialIfAvailable = function () {
      this._sendEmptyEvent('showInterstitialIfAvailable');
    };

    this.cacheInterstitial = function () {
      this._sendEmptyEvent('cacheInterstitial');
    };

    // 'more apps'
    this.showMoreApps = function () {
      this._sendEmptyEvent('showMoreApps');
    };

    this.showMoreAppsIfAvailable = function () {
      this._sendEmptyEvent('showMoreAppsIfAvailable');
    };

    this.cacheMoreApps = function () {
      this._sendEmptyEvent('cacheMoreApps');
    };
  };

  this._createEventListeners = function () {
    var eventNames = Object.keys(events);
    for (var i = 0; i < eventNames.length; i++) {
      var eventName = eventNames[i];
      var eventNameJS = events[eventName];
      NATIVE.events.registerHandler(eventName, bind(this, function (eventName, eventNameJS) {
        logger.log("{chartboost} " + eventName);
        this.emit(eventNameJS);
      }, eventName, eventNameJS));
    }
  };
});

exports = new Chartboost();
