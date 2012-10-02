AdLantis iOS SDK - README for Unity
===================================

README for Unity support.

How to use the AdLantis SDK iOS sample project 
----------------------------------------------

Note: These instructions are for Unity 3.4 and later, Unity 3.3 and earlier are not supported.

* Open project `unity/adlantis_unity_sample` in Unity
    * set publisher ID in this project
        in the `Start()` method of the AdView class (in the `AdView.cs` script), set your publisher Id as follows:
        
            AdViewNative.SetPublisherId("MjExMA%3D%3D%0A");
        
        (Note: For testing, the `AdViewTest.cs` can be used instead of `AdView.cs`. The `AdView.cs` file will still be needed for the project however.)
* Export project to iOS
    * target platform should be set to Universal armv6+armv7
    * set SDK version to iOS latest
    * with Unity 3.4, simulator is not supported.
* Open project in Xcode
    * On Xcode 3.x set target to device.
    * On Xcode 4.x set scheme to Unity-iPhone device (not simulator).
* Add AdLantis files to project
    * framework additions:
    
            MobileCoreServices.framework
            libz.dylib
        
    * adlantis files (the `adlantis_sdk` directory):
     
            adlantis header files
            adlantis library
            asihttprequest
            jsonkit
     
    * add `native_code` (from "unity/plug_in" directory)
        
            AdLantisSDKBinding.h
            AdLantisSDKBinding.mm
            AdLantisGeometryUtils.h
            AdLantisGeometryUtils.m
        
    * make source changes
        * in AppController.mm
        in the file AppController.mm 
            * in import section of the of file:
            
                    #import "AdlantisAdManager.h"
                    #import "AdlantisView.h"
                    #import "AdLantisSDKBinding.h"
             
            * in the function `OpenEAGL_UnityCallback` need to add code like the following after the view has been created (after the line with `[_window addSubview:view];` )
            
                    //
                    // AdLantis additions begin
                    //
                    AdlantisView *adView = AdView_Init();
                    [view addSubview:adView];
                    _AdView_SetPosition(AdViewTop); // This function only works after AdView_Set is called
                    //
                    // AdLantis additions end
                    //
            
* If you see an error concerning Objective-C exceptions "cannot use '@try' with Objective-C exceptions disabled", make sure to set "Enable Objective-C Exceptions" to "Yes"
    ![Enable Objective-C Exceptions](./images/enable_objective-c_exceptions.png "Enable Objective-C Exceptions")
* Run application on device

**Note: If making any changes to the Unity project, be sure to append, not replace existing project.**


How to add AdLantis SDK support to an iOS Unity 3.4 application:
---------------------------------------------------------------

* Open project in Unity
    * double click on the "title" scene object to open it
    * add adView MonoBehavior class to project
        
        drag the `AdView.cs` script to one of objects in the scene hierarchy. The main camera of the scene is often used.
        
        ![attach script to main camera](./images/main_camera.png "attach script to main camera")
        
        To confirm that the script is attached, click on the main camera object and examine the inspector panel:
        
        ![main camera inspector panel](./images/main_camera_inspector.png "main camera inspector panel")
    * set publisher ID in this project
        in the `Start()` method of the AdView class, set your publisher ID as follows:
        `AdViewNative.SetPublisherId("MjExMA%3D%3D%0A");`
        (Note: For testing, the `AdViewTest.cs` can be used instead of `AdView.cs`. The `AdView.cs` file will still be needed for the project however.)
    * include `AdViewNative.cs` in the project
* Export project to iOS
    * target platform should be set to Universal armv6+armv7
    * set SDK version to iOS latest
    * with Unity 3.4, simulator is not supported.
* Open project in Xcode
    * On Xcode 3.x set target to device.
    * On Xcode 4.x set scheme to Unity-iPhone device (not simulator).
* Add AdLantis files to project
    * framework additions:
    
            MobileCoreServices.framework
            libz.dylib
            CoreGraphics.framework (included by Unity 3.4)
            
    * adlantis files (the "adlantis_sdk" directory):
    
            adlantis header files
            adlantis library
            asihttprequest
            jsonkit
            
    * add "native_code" (from `unity/plug_in` directory)
    
            AdLantisSDKBinding.h
            AdLantisSDKBinding.mm
            AdLantisGeometryUtils.h
            AdLantisGeometryUtils.m
        
    * make source changes
        * in AppController.mm
            in the file AppController.mm 
            * at import section of the of file:
            
                    #import "AdlantisAdManager.h"
                    #import "AdlantisView.h"
                    #import "AdLantisSDKBinding.h"
                    
            * in the function `OpenEAGL_UnityCallback` need to add code like the following after the view has been created (after the line with `[_window addSubview:view];` )
            
                    //
                    // AdLantis additions begin
                    //
                    AdlantisView *adView = AdView_Init();
                    [view addSubview:adView];
                    _AdView_SetPosition(AdViewTop); // This function only works after AdView_Set is called
                    //
                    // AdLantis additions end
                    //
                    
* If you see an error concerning Objective-C exceptions "cannot use '@try' with Objective-C exceptions disabled", make sure to set "Enable Objective-C Exceptions" to "Yes"
    ![Enable Objective-C Exceptions](./images/enable_objective-c_exceptions.png "Enable Objective-C Exceptions")
* Run application on device

**Note: If making any changes to the Unity project, be sure to append, not replace existing project.**

