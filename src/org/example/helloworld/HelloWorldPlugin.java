/* 
 * PhoneGap is available under *either* the terms of the modified BSD license *or* the
 * MIT License (2008). See http://opensource.org/licenses/alphabetical for full text.
 * 
 * Copyright (c) 2011, IBM Corporation
 */

package org.example.helloworld;

import org.json.JSONArray;

import com.phonegap.api.Plugin;
import com.phonegap.api.PluginResult;
import com.phonegap.api.PluginResult.Status;

//-------------------------------------------------------------------
public class HelloWorldPlugin extends Plugin {

    //---------------------------------------------------------------
    @Override
    public PluginResult execute(String action, JSONArray args, String callbackId) {
        return new PluginResult(Status.OK, args.toString());
    }

}
