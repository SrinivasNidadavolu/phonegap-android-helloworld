# 
# PhoneGap is available under *either* the terms of the modified BSD license *or* the
# MIT License (2008). See http://opensource.org/licenses/alphabetical for full text.
# 
# Copyright (c) 2011, IBM Corporation
# 

#-------------------------------------------------------------------------------
help:
	@echo make targets available:
	@echo "  help     print this help"
	@echo "  build    build the junk"
	@echo "  deploy   copy to the server"
	@echo "  clean    clean up transient goop"
	@echo "  watch    run 'make build' when a file changes"
	@echo "  vendor   get the vendor files"
	@echo
	@echo You will need to run \'make vendor\' before doing a build.
	
#-------------------------------------------------------------------------------
build: vendor
	@echo 
	@echo ===========================================================
	@echo running build
	@echo ===========================================================
	
	-@mkdir assets 2> /dev/null
	@-chmod -R +w assets/www
	@rm -rf assets/www
	@mkdir assets/www
	@mkdir assets/www/vendor
	@mkdir assets/www/modules
	
	cp -r web/* assets/www
	cat debug/index.html >  assets/www/index-debug.html
	cat web/index.html   >> assets/www/index-debug.html
	
	cp vendor/modjewel/modjewel-require.js assets/www/vendor
	cp vendor/phonegap/phonegap.js         assets/www/vendor
	cp vendor/zepto/zepto.js               assets/www/vendor
	
	@rm -rf tmp
	@mkdir tmp
	cp vendor/scooj/scooj.js            tmp
	python vendor/scooj/scoopc.py --out tmp modules
	python vendor/modjewel/module2transportd.py --out assets/www/modules tmp 
	@rm -rf tmp
	
	@chmod -R -w assets/www
	
#-------------------------------------------------------------------------------
deploy:

#-------------------------------------------------------------------------------
clean:

#-------------------------------------------------------------------------------
watch:
	python vendor/run-when-changed/run-when-changed.py "make build" web modules debug Makefile

#-------------------------------------------------------------------------------
vendor: \
	vendor/modjewel \
	vendor/scooj \
	vendor/run-when-changed \
	vendor/zepto \
	vendor/phonegap
	
#-------------------------------------------------------------------------------
vendor/built.txt:
	@echo 
	@echo ===========================================================
	@echo getting vendor files
	@echo ===========================================================
	@rm -rf vendor
	@mkdir vendor
	@date > vendor/built.txt

#-------------------------------------------------------------------------------
vendor/zepto: vendor/built.txt
	@echo 
	@echo ===========================================================
	@echo downloading zepto
	@echo ===========================================================
	@rm -rf tmp
	@mkdir tmp
	@mkdir vendor/zepto
	curl --silent --show-error --output tmp/zepto.zip $(ZEPTO_URL)/zepto-$(ZEPTO_VERSION).zip
	unzip -q tmp/zepto.zip -d tmp
	mv tmp/zepto-$(ZEPTO_VERSION)/dist/zepto.js vendor/zepto/zepto.js
	@rm -rf tmp

#-------------------------------------------------------------------------------
vendor/modjewel: vendor/built.txt
	@echo 
	@echo ===========================================================
	@echo downloading modjewel
	@echo ===========================================================
	@mkdir  vendor/modjewel
	curl --silent --show-error --output vendor/modjewel/modjewel-require.js  $(MODJEWEL_URL)/$(MODJEWEL_VERSION)/modjewel-require.js 
	curl --silent --show-error --output vendor/modjewel/module2transportd.py $(MODJEWEL_URL)/$(MODJEWEL_VERSION)/module2transportd.py

#-------------------------------------------------------------------------------
vendor/scooj: vendor/built.txt
	@echo 
	@echo ===========================================================
	@echo downloading scoop
	@echo ===========================================================
	@mkdir  vendor/scooj
	curl --silent --show-error --output vendor/scooj/scooj.js  $(SCOOJ_URL)/$(SCOOJ_VERSION)/scooj.js
	curl --silent --show-error --output vendor/scooj/scoopc.py $(SCOOJ_URL)/$(SCOOJ_VERSION)/scoopc.py

#-------------------------------------------------------------------------------
vendor/phonegap: vendor/built.txt
	@echo 
	@echo ===========================================================
	@echo downloading phonegap
	@echo ===========================================================
	
	@rm -rf tmp
	@mkdir tmp
	@mkdir vendor/phonegap
	curl --silent --show-error --output tmp/phonegap.zip     $(PHONEGAP_URL)/phonegap-$(PHONEGAP_VERSION).zip
	unzip -q tmp/phonegap.zip -d tmp
	mv tmp/phonegap-$(PHONEGAP_VERSION)/Android/phonegap.$(PHONEGAP_VERSION).jar vendor/phonegap/phonegap.jar
	mv tmp/phonegap-$(PHONEGAP_VERSION)/Android/phonegap.$(PHONEGAP_VERSION).js  vendor/phonegap/phonegap.js
	@rm -rf tmp

	@mkdir tmp
	git clone $(PHONEGAP_SRC_REPO) tmp
	cd tmp; git co $(PHONEGAP_VERSION)
	cd tmp/framework/src; zip -r ../../../vendor/phonegap/phonegap-src.zip *
	@rm -rf tmp

#-------------------------------------------------------------------------------
vendor/run-when-changed: vendor/built.txt
	@echo 
	@echo ===========================================================
	@echo downloading run-when-changed
	@echo ===========================================================
	mkdir   vendor/run-when-changed
	curl --silent --show-error --output vendor/run-when-changed/run-when-changed.py $(RUN_WHEN_CHANGED_URL)

#-------------------------------------------------------------------------------

LOCAL_DEPLOY           = ~/tmp

MODJEWEL_URL           = https://github.com/pmuellr/modjewel/raw
MODJEWEL_VERSION       = master

SCOOJ_URL              = https://github.com/pmuellr/scooj/raw
SCOOJ_VERSION          = develop

ZEPTO_URL              = http://zeptojs.com/downloads/
ZEPTO_VERSION          = 0.6

PHONEGAP_URL           = http://phonegap.googlecode.com/files
PHONEGAP_VERSION       = 0.9.5.1

PHONEGAP_SRC_REPO      = https://github.com/phonegap/phonegap-android.git

RUN_WHEN_CHANGED_URL   = https://gist.github.com/raw/240922/0f5bedfc42b3422d0dee81fb794afde9f58ed1a6/run-when-changed.py

