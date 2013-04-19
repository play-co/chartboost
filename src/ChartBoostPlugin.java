package com.tealeaf.plugin.plugins;

import com.tealeaf.plugin.IPlugin;
import java.io.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.chartboost.sdk.*;

import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import android.util.Log;
import android.os.Bundle;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;

public class ChartBoostPlugin implements IPlugin {

	private Chartboost cb;
	private boolean mConsumeBackPressed;
	private Activity mActivity;

	private class PluginDelegate implements ChartboostDelegate {
		@Override
		public void didCacheMoreApps() {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didClickInterstitial(String arg0) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didClickMoreApps() {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didCloseInterstitial(String arg0) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didCloseMoreApps() {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didDismissInterstitial(String arg0) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didDismissMoreApps() {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didFailToLoadInterstitial(String arg0) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didFailToLoadMoreApps() {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didShowInterstitial(String arg0) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void didShowMoreApps() {
			// TODO Auto-generated method stub
			
		}

		@Override
		public boolean shouldDisplayInterstitial(String arg0) {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public boolean shouldDisplayLoadingViewForMoreApps() {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public boolean shouldDisplayMoreApps() {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public boolean shouldRequestInterstitial(String arg0) {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public boolean shouldRequestInterstitialsInFirstSession() {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public boolean shouldRequestMoreApps() {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public void didCacheInterstitial(String arg0) {
			// TODO Auto-generated method stub
			
		};
	}

	public ChartBoostPlugin() {

	}

	public void onCreateApplication(Context applicationContext) {
	
	}

	public void onCreate(Activity activity, Bundle savedInstanceState) {
		String appId = "";
		String appSignature = "";
		try {
			InputStream is = activity.getAssets().open("resources/manifest.json");
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			String readLine;
			String manifestString = "";
			while ((readLine = br.readLine()) != null) {
				manifestString += readLine;
			}
			br.close();

			JSONObject manifest = new JSONObject(manifestString);
			JSONObject android = manifest.getJSONObject("android");
			JSONObject chartboost = android.getJSONObject("chartboost");
			appId = chartboost.getString("appId");
			appSignature = chartboost.getString("appSignature");
			//Log.d("CHART", appId);
			//Log.d("CHART", appSignature);
		} catch (Exception e) {
			Log.d("chartboost", "Unable to read appId and appSignature keys from manifest");
		}
		this.mActivity = activity;
		this.cb = Chartboost.sharedChartboost();
		this.cb.onCreate(activity, appId, appSignature, null);
		
		// Notify the beginning of a user session
		this.cb.startSession();

		// Show an interstitial
		//this.cb.showInterstitial();
	}

	public void onResume() {
	
	}

	public void onStart() {
		this.cb.onStart(mActivity);
	}

	public void onPause() {
	
	}

	public void onStop() {
		this.cb.onStop(mActivity);
	}

	public void onDestroy() {
		this.cb.onDestroy(mActivity);
	}

	public void onNewIntent(Intent intent) {
	
	}

	public void setInstallReferrer(String referrer) {
	
	}

	public void onActivityResult(Integer request, Integer result, Intent data) {
	
	}

	public boolean consumeOnBackPressed() {
		return mConsumeBackPressed;
	}

	public void onBackPressed() {
		mConsumeBackPressed = this.cb.onBackPressed();
	}

}
