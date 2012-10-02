AdLantis iOS SDK - README
================================
version 1.3.3 / 2011-10-18

The AdLantis iOS SDK includes the following files and directories:

`adlantis_sample` - sample code that demonstrates the AdLantis iOS SDK. 
You will need to set `AdlantisAdManager.sharedManager.publisherID` in `RootViewController.m` 
to the zone id created from the AdLantis.jp website in order for the sample to display ads.

All the files in the `adlantis_sdk` directory should be added to your project. They include:

* `AdlantisAd.h`, `AdlantisAdManager.h`, `AdlantisView.h` are header files to use the SDK.

* `asihttprequest` - source files for the ASIHTTPRequest library code

* `JSONKit` - source files for the JSONKit library

* `libadlantis_ios_sdk.a` - static library for the AdLantis iOS SDK

* `en.lproj` and `ja.lproj` directories - These directories contain the English and Japanese localizations of the library, respectively. These files will need to be included in your project. 


The `unity` directory contains documents, sample code and a plug in to support using the AdLantis iOS SDK with the Unity game development environment.

Instructions on adding AdLantis support to your application are available at:
  http://tn.adlantis.jp/iPhoneAppOwner/adlantis-iphone-sdk

All network-based advertising campaigns are controlled by Atlantis Co., Ltd. Publishers cannot select which ads to allow or disallow.

[Atlantis Inc.](http://www.atlantiss.jp/)

Changelog
--------

#### 1.3.3 (2011/10/18) ####
* Support for Unity 3.4, see "unity" directory for more information (earlier versions of Unity aren't supported).
* Updated ad protocol so that it is more likely to have landscape ads to display
* All the files needed for including in your Xcode project are in the "adlantis_sdk" directory. You can just drag that directory into your project.
* Updated to version 1.8.1 of ASIHTTPRequest
* Moved from older style .lproj directories ("English.lproj", "Japanese.lproj") to new style ("en.lproj", "ja.lproj")

#### 1.3.1 (2011/07/25) ####
* Address memory leak in AdlantisAdManger

#### 1.3.0 (2011/02/10) ####
* Support for high resolution images for displays that support them such as iPhone 4
* Support for expanding preview
* Support for displaying portrait content in landscape mode. If the AdlantisView is sized to 320 x 50 in landscape orientation, it will display portrait ad content.
* Library name has changed from `libadlantis_iphone_sdk` to `libadlantis_ios_sdk`
* `-all_load` (or `-force_load`) is no longer required to use the library. Only `-ObjC` is still required. 
* Updated to ASIHTTPRequest v1.8
* Changed from using `libYAJLIOS` to JSONKit. Include the JSONKit sources in your project.
* AdlantisView no longer manipulates the value of its hidden or alpha properties. The view no longer uses those values to avoid rendering when ads are not available. Some ads are semi-transparent. To allow the views behind to be visible, the opaque property of the view needs to be set to NO and the backgroundColor should be set to a transparent value like `[UIColor clearColor]`.
* Addressed a problem where the view does not render properly when initialized with the `init` method instead of the `initWithFrame:` method.

#### 1.2.1 (2010/11/09) ####
* The iPhone SDK 1.2.1 is an update to support iOS SDK 4. iOS version 2.x is no longer supported. Only iOS 3.1.3 and later is supported.
* The SDK library now includes support for new ad banner sizes
* Icons in ad preview mode have been updated for high resolution displays
* Updated the version of ASIHTTPRequest
* `libYAJLiPhone.a` has been updated and renamed to `libYAJLIOS.a`
* MobileCoreServices.framework is now required

#### 1.2 (2010/04/28) ####
* The iPhone SDK 1.2 includes features to support conversion tags. 

#### 1.1 (2010/02/17) ####
* The iPhone SDK 1.1 introduces ad previews. When clicked, ads with previews will open a full screen web browser. This lets the user view information about the ad without quitting the application. Also, for ads that don't support previews, when those ads are clicked a confirmation alert will be shown letting the user confirm before quitting.

* The web preview supports forward and back buttons for navigation along with a reload button. Users can dismiss the preview by hitting the "Done" button or they can click a button for the ad content which sends them to Safari, iTunes store, App Store, Map application or make a telephone call.

* While the preview is visible, it may be appropriate to stop activity in the application. For this purpose two notifications, `AdlantisPreviewWillBeShownNotification` and `AdlantisPreviewWillBeHiddenNotification`, are sent to notify the application that the preview will be shown or hidden respectively. Applications that need these notifications should register and respond to them appropriately.

* Because the SDK now displays alert dialogs, localized resources are needed. These are included in the SDK as the file Adlantis.strings, for which English and Japanese localizations are available. The developer can provide any additional localizations as necessary. The locale files will need to be included in the application Xcode project.

* A final change to the SDK library stops the SDK from requesting new ads when ads aren't currently being displayed. This feature is supported automatically when using AdlantisView, but for image-based ads some changes are needed. The AdlantisAdManager `addUser:`/`removeUser:` APIs let image-based applications register when ads will be displayed and unregister when the ad displaying view is no longer visible. 

#### 1.0.1 (2009/12/22) ####
* bug fix to accurately reflect impressions under certain conditions  

#### 1.0 (2009/12/14) ####
* initial release 
