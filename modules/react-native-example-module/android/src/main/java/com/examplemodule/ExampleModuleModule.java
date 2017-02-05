package com.examplemodule;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.annotation.Nullable;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;

import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.BaseActivityEventListener;

import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.HashMap;
import java.util.Map;

import java.io.StringWriter;
import java.io.PrintWriter;


public class ExampleModuleModule extends ReactContextBaseJavaModule {
	private Context context;

    /**
    * Activity with Promise initialization
    **/
    private static final int REQUEST_ACTIVITY_CODE = 467081;
    private Promise activityPromise;
    private WritableMap activityResult;
	private final ActivityEventListener activityListener = new BaseActivityEventListener () {
	    @Override
		public void onActivityResult (
            Activity activity,
            int requestCode,
            int resultCode,
            Intent intent
        ) {
            if (requestCode == REQUEST_ACTIVITY_CODE) {

                if (resultCode == Activity.RESULT_CANCELED) {
                    activityPromise.reject ("CANCELLED");
                } else if (resultCode == Activity.RESULT_OK) {

                    // do stuff ...
                    // populate activityResult etc
                    activityResult.putString ("data", intent.getData ().getPath ());

                    activityPromise.resolve (activityResult);
                }
            }
        }
	};

	public ExampleModuleModule (ReactApplicationContext reactContext) {
		super (reactContext);

		this.context = reactContext;
		reactContext.addActivityEventListener (activityListener);
	}

	/**
	 * @return the name of this module. This will be the name used to {@code require()} this module
	 * from javascript.
	 */
	@Override
	public String getName () {
		return "ExampleModule";
	}

    /**
    * Constants exposed to javascript
    **/
    @Override
    public @Nullable Map<String, Object> getConstants() {
        HashMap<String, Object> constants = new HashMap<String, Object>();

        // example: application files dir absolute path
        constants.put ("FILES_DIR_PATH", context.getFilesDir().getPath ());

        return constants;
    }

    /**
    * Callback example
    **/
    @ReactMethod
    public void callbackMethod (
        ReadableMap options,
        Callback callback,
        Callback errback
    ) {
        WritableMap result = Arguments.createMap ();

        try {
            result.putString ("data", "hello from callback");
            callback.invoke (result);
        } catch (Exception e) {
            result.putString ("error", printExeption (e));
            errback.invoke (result);
        }
    }

    /**
    * Promise example
    **/
    @ReactMethod
    public void promiseMethod (
        ReadableMap options,
        Promise promise
    ) {
        WritableMap result = Arguments.createMap ();

        try {
            result.putString ("data", "hello from promise");
            promise.resolve (result);
        } catch (Exception e) {
            promise.reject (printExeption (e));
        }
    }

    /**
    * Activity with Promise example
    **/
	@ReactMethod
	public void activityMethod (
		ReadableMap options,
		Promise promise
	) {
		activityResult = Arguments.createMap ();
		Activity currentActivity = getCurrentActivity ();

        // quick example: open gallery to get videofile

		Intent intent = new Intent (Intent.ACTION_GET_CONTENT);
		intent.addCategory (Intent.CATEGORY_OPENABLE);
		intent.setType ("video/*");

		currentActivity.startActivityForResult (
			Intent.createChooser (intent, "Select Video"),
			REQUEST_ACTIVITY_CODE
		);

		activityPromise = promise;
	}

    /**
    * Send event example
    **/
    private void sendEvent (String eventName, WritableMap data) {
        getReactApplicationContext ()
            .getJSModule (DeviceEventManagerModule.RCTDeviceEventEmitter.class)
            .emit (eventName, data);
    }

    @ReactMethod
    public void eventMethod (
        ReadableMap options
    ) {
        WritableMap data = Arguments.createMap ();

        data.putString ("data", "hello from event");

        sendEvent ("example-module:event", data);
    }


    /**
    * Exception StackTrace helper
    **/
    private String printExeption (
        Exception e
    ) {
        StringWriter sw = new StringWriter ();
        e.printStackTrace (new PrintWriter (sw));

        return sw.toString ();
    }

}