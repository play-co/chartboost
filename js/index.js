var Chartboost = Class(function () {
  this.showInterstitial = function() {
    NATIVE.plugins.sendEvent("ChartboostPlugin", "showInterstitial", JSON.stringify({}));
  };
});

exports = new Chartboost();
