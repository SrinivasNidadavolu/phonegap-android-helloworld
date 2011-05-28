phonegap-android-helloworld
===========================

A skeletal Android app using PhoneGap, that:

* uses a [Plugin](http://wiki.phonegap.com/w/page/36753494/How-to-Create-a-PhoneGap-Plugin-for-Android)
* uses [modjewel](https://github.com/pmuellr/modjewel/tree/#readme) modules
* uses [scoop](https://github.com/pmuellr/scooj/tree/#readme) formatted modules

The project structure is such that you should edit the Java bits in Eclipse,
the rest of the bits in Eclipse or somewhere else, and the rest of the
bits should be built with the Makefile.  Basically, Eclipse will build
the Java and Android bits, and the Makefile will build the rest of the
bits.

To do a build of the non-Eclipse bits, from the command-line, run

    make build
    
You can do a *continuous build* by running

    make watch
    
The first time you do a build, a number of resources will be downloaded
into the vendor directory.

The Android app doesn't do much, or anything, really, but I wanted to
have a skeletal project out there I could clone off of.

Interesting directories:

* assets - output directory for the build; the build actually marks the 
contents r/o so you can't accidently edit the files

* bin - output directory for Eclipse Java compilation

* debug - source directory for debug-specific additions

* gen - output directory for Android goop, I guess

* modules - source directory for scoop modules

* res - source directory for Android resources

* src - source directory for Java classes

* vendor - directory where 3rd party stuff is downloaded to

* web - source directory for HTML / CSS / JavaScript