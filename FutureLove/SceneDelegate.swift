//
//  SceneDelegate.swift
//  FutureLove
//
//  Created by TTH on 24/07/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//<<<<<<< HEAD

    var window: UIWindow?
    
    
//=======

 //   var window: UIWindow?


//>>>>>>> a57c582 (ViewHome)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//<<<<<<< HEAD
//        if AppConstant.userId == nil {
            let viewController = StartViewController()
            window?.rootViewController = UINavigationController(rootViewController: viewController)
            window?.makeKeyAndVisible()
//        } else {
//            let viewController = TabbarViewController()
//            window?.rootViewController = UINavigationController(rootViewController: viewController)
//            window?.makeKeyAndVisible()
//        }
//=======
        //        if AppConstant.userId == nil {
        let startViewController = Swap2ImageVC()
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
        //        } else {
        //            let viewController = TabbarViewController()
        //            window?.rootViewController = UINavigationController(rootViewController: viewController)
        //            window?.makeKeyAndVisible()
        //        }

//>>>>>>> a57c582 (ViewHome)
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
//<<<<<<< HEAD

//=======

//>>>>>>> a57c582 (ViewHome)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
//<<<<<<< HEAD

//=======

//>>>>>>> a57c582 (ViewHome)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
//<<<<<<< HEAD

//=======

//>>>>>>> a57c582 (ViewHome)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
//<<<<<<< HEAD

//=======

//>>>>>>> a57c582 (ViewHome)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
//<<<<<<< HEAD

    
//=======


//>>>>>>> a57c582 (ViewHome)
}
