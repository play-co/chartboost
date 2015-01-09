package com.tealeaf.plugin.plugins;

import com.tealeaf.logger;
import com.tealeaf.EventQueue;
import com.tealeaf.plugin.IPlugin;
import java.io.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.chartboost.sdk.CBLocation;
import com.chartboost.sdk.Chartboost;
import com.chartboost.sdk.ChartboostDelegate;
import com.chartboost.sdk.Model.CBError.CBClickError;
import com.chartboost.sdk.Model.CBError.CBImpressionError;

import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import android.util.Log;
import android.os.Bundle;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;

public class ChartboostPlugin implements IPlugin {

	private Activity mActivity;

	public class ChartboostAdFailedToLoad extends com.tealeaf.event.Event {
		public ChartboostAdFailedToLoad() {
			super("ChartboostAdFailedToLoad");
		}
	}

	public class ChartboostAdAvailable extends com.tealeaf.event.Event {
		public ChartboostAdAvailable() {
			super("ChartboostAdAvailable");
		}
	}

	public class ChartboostAdDisplayed extends com.tealeaf.event.Event {
		public ChartboostAdDisplayed() {
			super("ChartboostAdDisplayed");
		}
	}

	public class ChartboostAdDismissed extends com.tealeaf.event.Event {
		public ChartboostAdDismissed() {
			super("ChartboostAdDismissed");
		}
	}

	public class ChartboostAdClicked extends com.tealeaf.event.Event {
		public ChartboostAdClicked() {
			super("ChartboostAdClicked");
		}
	}

	public class ChartboostAdClosed extends com.tealeaf.event.Event {
		public ChartboostAdClosed() {
			super("ChartboostAdClosed");
		}
	}

	public class ChartboostMoreAppsFailedToLoad extends com.tealeaf.event.Event {
		public ChartboostMoreAppsFailedToLoad() {
			super("ChartboostMoreAppsFailedToLoad");
		}
	}

	public class ChartboostMoreAppsAvailable extends com.tealeaf.event.Event {
		public ChartboostMoreAppsAvailable() {
			super("ChartboostMoreAppsAvailable");
		}
	}

	public class ChartboostMoreAppsDisplayed extends com.tealeaf.event.Event {
		public ChartboostMoreAppsDisplayed() {
			super("ChartboostMoreAppsDisplayed");
		}
	}

	public class ChartboostMoreAppsDismissed extends com.tealeaf.event.Event {
		public ChartboostMoreAppsDismissed() {
			super("ChartboostMoreAppsDismissed");
		}
	}

	public class ChartboostMoreAppsClicked extends com.tealeaf.event.Event {
		public ChartboostMoreAppsClicked() {
			super("ChartboostMoreAppsClicked");
		}
	}

	public class ChartboostMoreAppsClosed extends com.tealeaf.event.Event {
		public ChartboostMoreAppsClosed() {
			super("ChartboostMoreAppsClosed");
		}
	}

	private ChartboostDelegate delegate = new ChartboostDelegate() {

		@Override
		public void didCacheInterstitial(String arg0) {
			EventQueue.pushEvent(new ChartboostAdAvailable());
		}

		@Override
		public void didFailToLoadInterstitial(String arg0, CBImpressionError error) {
			EventQueue.pushEvent(new ChartboostAdFailedToLoad());
		}

		@Override
		public void didDisplayInterstitial(String arg0) {
			EventQueue.pushEvent(new ChartboostAdDisplayed());
		}

		@Override
		public void didDismissInterstitial(String arg0) {
			EventQueue.pushEvent(new ChartboostAdDismissed());
		}

		@Override
		public void didClickInterstitial(String arg0) {
			EventQueue.pushEvent(new ChartboostAdClicked());
		}

		@Override
		public void didCloseInterstitial(String arg0) {
			EventQueue.pushEvent(new ChartboostAdClosed());
		}

		@Override
		public boolean shouldDisplayInterstitial(String location) {
			return true;
		}

		public boolean shouldRequestInterstitial(String location) {
			return true;
		}


		@Override
		public void didCacheMoreApps(String location) {
			EventQueue.pushEvent(new ChartboostMoreAppsAvailable());
		}

		@Override
		public void didFailToLoadMoreApps(String location, CBImpressionError error) {
			EventQueue.pushEvent(new ChartboostMoreAppsFailedToLoad());
		}

		@Override
		public void didDisplayMoreApps(String location) {
			EventQueue.pushEvent(new ChartboostMoreAppsDisplayed());
		}

		@Override
		public void didDismissMoreApps(String location) {
			EventQueue.pushEvent(new ChartboostMoreAppsDismissed());
		}

		@Override
		public void didClickMoreApps(String location) {
			EventQueue.pushEvent(new ChartboostMoreAppsClicked());
		}

		@Override
		public void didCloseMoreApps(String location) {
			EventQueue.pushEvent(new ChartboostMoreAppsClosed());
		}

		@Override
		public boolean shouldDisplayMoreApps(String location) {
			return true;
		}

		@Override
		public boolean shouldRequestMoreApps(String location) {
			return true;
		}

	};

	public void showInterstitial(String jsonData) {
		Chartboost.showInterstitial(CBLocation.LOCATION_DEFAULT);
	}

	public void showInterstitialIfAvailable(String jsonData) {
		if (Chartboost.hasInterstitial(CBLocation.LOCATION_DEFAULT)) {
			Chartboost.showInterstitial(CBLocation.LOCATION_DEFAULT);
		}
	}

	public void cacheInterstitial(String jsonData) {
		Chartboost.cacheInterstitial(CBLocation.LOCATION_DEFAULT);
	}


	public void showMoreApps(String jsonData) {
		Chartboost.showMoreApps(CBLocation.LOCATION_DEFAULT);
	}

	public void showMoreAppsIfAvailable(String jsonData) {
		if (Chartboost.hasMoreApps(CBLocation.LOCATION_DEFAULT)) {
			Chartboost.showMoreApps(CBLocation.LOCATION_DEFAULT);
		}
	}

	public void cacheMoreApps(String jsonData) {
		Chartboost.cacheMoreApps(CBLocation.LOCATION_DEFAULT);
	}

	public ChartboostPlugin() { }

	public void onCreateApplication(Context applicationContext) { }

	public void onCreate(Activity activity, Bundle savedInstanceState) {
		this.mActivity = activity;

		PackageManager manager = activity.getPackageManager();
		String appID = "", appSignature = "";
		try {
			Bundle meta = manager.getApplicationInfo(activity.getPackageName(), PackageManager.GET_META_DATA).metaData;
			if (meta != null) {
				appID = meta.get("CHARTBOOST_APP_ID").toString();
				appSignature = meta.get("CHARTBOOST_APP_SIGNATURE").toString();
			}
		} catch (Exception e) {
			android.util.Log.d("EXCEPTION", "" + e.getMessage());
		}

		logger.log("{chartboost} Initializing from manifest with AppID=", appID, "and signature=", appSignature);
		Chartboost.startWithAppId(mActivity, appID, appSignature);
		Chartboost.setDelegate(delegate);
	}

	public void onResume() {
		Chartboost.onResume(mActivity);
	}

	public void onStart() {
		Chartboost.onStart(mActivity);
	}

	public void onPause() {
		Chartboost.onPause(mActivity);
	}

	public void onStop() {
		Chartboost.onStop(mActivity);
	}

	public void onDestroy() {
		Chartboost.onDestroy(mActivity);
	}

	public void onNewIntent(Intent intent) {

	}

	public void setInstallReferrer(String referrer) {

	}

	public void onActivityResult(Integer request, Integer result, Intent data) {

	}

	public boolean consumeOnBackPressed() {
		if (Chartboost.onBackPressed()) {
			return true;
		}
		return false;
	}

	public void onBackPressed() {
	}
}
