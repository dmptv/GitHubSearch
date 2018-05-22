//
//  AppDelegate.swift
//  GitHubSearch
//
//  Created by 123 on 21.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate  {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setAppearance()
        listenNetworkErrorNotifications() 
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (authorized, error) in
        }
        UNUserNotificationCenter.current().delegate = self
        UIApplication.shared.applicationIconBadgeNumber = 0

        return true
    }
    
    private func setAppearance() {
        UIApplication.shared.statusBarStyle = .lightContent
        let cancelButtonAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    
    func listenNetworkErrorNotifications() {
        NotificationCenter.default.addObserver(forName: NetworkErrorNotification,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using:
            {  notification in
                
                let alert = UIAlertController(title: NSLocalizedString("Whoops...", comment: "Error alert: title"),
                                              message: NSLocalizedString("There was an error reading from the GitHub. Please try again.", comment: "Error alert: message"),
                                              preferredStyle: .alert)
                let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Error alert"), style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.viewControllerForShowingAlert()?.present(alert, animated: true, completion: nil)
        })
    }
    
    func viewControllerForShowingAlert() -> UIViewController? {
        guard let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate?,
            let window: UIWindow = applicationDelegate.window
            else { return nil }
        
        let rootViewController = window.rootViewController!
        if let presentedViewController = rootViewController.presentedViewController {
            return presentedViewController
        } else {
            return rootViewController
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}










