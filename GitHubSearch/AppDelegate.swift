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
class AppDelegate: UIResponder, UIApplicationDelegate {

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
    
    private func listenNetworkErrorNotifications() {
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
    
    private func viewControllerForShowingAlert() -> UIViewController? {
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

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
}









