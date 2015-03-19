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
  'ChartboostMoreAppsClosed': 'MoreAppsClosed',

  'ChartboostRewardedVideoAvailable': 'RewardedVideoAvailable',
  'ChartboostRewardedVideoFailedToLoad': 'RewardedVideoFailedToLoad',
  'ChartboostRewardedVideoDisplayed': 'RewardedVideoDisplayed',
  'ChartboostRewardedVideoDismissed': 'RewardedVideoDismissed',
  'ChartboostRewardedVideoClicked': 'RewardedVideoClicked',
  'ChartboostRewardedVideoClosed': 'RewardedVideoClosed'
  //'ChartboostRewardedVideoCompleted': 'RewardedVideoCompleted'
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


    // rewarded video
    this.showRewardedVideo = function () {
      this._sendEmptyEvent('showRewardedVideo');
    };

    this.showRewardedVideoIfAvailable = function () {
      this._sendEmptyEvent('showRewardedVideoIfAvailable');
    };

    this.cacheRewardedVideo = function () {
      this._sendEmptyEvent('cacheRewardedVideo');
    };

    this.isRewardedVideoAvailable = function () {
      this._sendEmptyEvent('isRewardedVideoAvailable');
    };
  };

  this._createEventListeners = function () {
    var eventNames = Object.keys(events);
    for (var i = 0; i < eventNames.length; i++) {
      var eventName = eventNames[i];
      var eventNameJS = events[eventName];
      NATIVE.events.registerHandler(eventName, bind(this, function (eventName, eventNameJS) {
        logger.log('{chartboost} ' + eventName);
        this.emit(eventNameJS);
      }, eventName, eventNameJS));
    }

    NATIVE.events.registerHandler('ChartboostRewardedVideoCompleted', bind(this, function (evt) {
      this.emit('RewardedVideoCompleted', evt.reward);
    }));
  };

});

exports = new Chartboost();
