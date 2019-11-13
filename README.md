# Create a project that support both iOS 12 and 13 with Xcode 11 or above

As we all know that SwiftUI cannot be implemented on iOS 12 or below.
This repo is to record the proper steps to build a project that both supports iOS 12 & 13.

Environment: Xcode 11.1


If we create a project with Xcode 11, we will find that this project can only on iOS 13 or above:
![](https://i.imgur.com/ODmYizx.png)

This repo is created with SwiftUI as user interface.


## If you create your project with SwiftUI as user interface...

![](https://i.imgur.com/nj2Uicp.png)


### Step 1: Delete all the Swift UI related files and code

Delete SwiftUI related files including ContentView.swift and SceneDelegate.swift.

### Step 2: Init window in AppDelegate file as we are used to
```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        
        return true
    }

}
![](https://i.imgur.com/TtUWtQc.png)

```

We will find there is a error in Info.plist if we run the project now.
![](https://i.imgur.com/bruJlf8.png)

### Step 3: Change the configuration in Info.plist


Change `<string>$(PRODUCT_MODULE_NAME).SceneDelegate</string` to `<string>$(PRODUCT_MODULE_NAME).AppDelegate</string`.


![](https://i.imgur.com/0PuGmon.png)


If we run the project, it still crash and we get a error msg as follow:

> [SceneConfiguration] Info.plist configuration "(no name)" for UIWindowSceneSessionRoleApplication contained UISceneDelegateClassName, "ProjectSupportingIOS12n13.AppDelegate", but it does not conform to the UISceneDelegate protocol.


### Step 4: Let AppDelegate to conform UISceneDelegate protocol

No alert appears to let us to implement any functions in UISceneDelegate protocol:

![](https://i.imgur.com/fBBMbjF.png)

If we run the project on iOS 12.2, it works well.
But if we run the project on iOS 13.1, we will get a all black windows without any errors.


![](https://i.imgur.com/3hMHAzp.png)


### Step 5: Init window with UIWindowScene
When we open the debug view hierarchy, we will find that the window is not a pure UIWindow but a UIWindowScene

![](https://i.imgur.com/4cmuy2H.png)


This wouldn't work:
```swift
@available(iOS 13.0, *)
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
          
}
```

We MUST init the window with UIWindowScene:

```swift
@available(iOS 13.0, *)
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use a UIHostingController as window root view controller.
    if let windowScene = scene as? UIWindowScene {
        self.window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
    }
}
```


Now this project works fine on both iOS 12 and 13.

## If you create your project with Storyboard as user interface...

![](https://i.imgur.com/qq692MG.png)


It is almost same as above, except we have to conform UIWindowSceneDelegate protocol rather than UISceneDelegate protocol and need not to do the step 5.

### Attention: AppDelegate have to conform UIWindowSceneDelegate protocol

There is no difference for project created with SwiftUI as user interface between conforming UISceneDelegate and conforming UIWindowSceneDelegate.

However, if we create project with Storyboard as user interface, **we HAVE TO conform UIWindowSceneDelegate**. Otherwise, the window will not init properly and we will receive error message as below:

> [WindowScene] There is no scene delegate set. A scene delegate class must be specified to use a main storyboard file.
> 

![](https://i.imgur.com/TDGxXhs.png)


The default configuration with storyboard is slightly different from SwiftUI:
![](https://i.imgur.com/nILHXQL.png)

### No Step 5
This will work after changing the configuration in Info.plist:

![](https://i.imgur.com/Co1eMyw.png)





