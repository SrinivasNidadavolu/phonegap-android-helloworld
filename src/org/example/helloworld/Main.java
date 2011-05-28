/* 
 * PhoneGap is available under *either* the terms of the modified BSD license *or* the
 * MIT License (2008). See http://opensource.org/licenses/alphabetical for full text.
 * 
 * Copyright (c) 2011, IBM Corporation
 */

package org.example.helloworld;

import android.os.Bundle;
import com.phonegap.DroidGap;

//-------------------------------------------------------------------
public class Main extends DroidGap {
    public static final boolean DEBUG = true;

    //---------------------------------------------------------------
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (!DEBUG) {
            super.loadUrl("file:///android_asset/www/index.html");
        }
        else { 
            super.loadUrl("file:///android_asset/www/index-debug.html");
        }
    }
}