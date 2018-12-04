import Foundation
import UIKit

extension Array where Element: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool  {
        return reduce(true) { acc, delegate in
            return acc && (delegate.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? true)
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        forEach { delegate in
            delegate.applicationDidBecomeActive?(application)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        forEach { delegate in
            delegate.applicationWillResignActive?(application)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return reduce(true) { acc, delegate in
            return acc && (delegate.application?(app, open: url, options: options) ?? true)
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        forEach { delegate in
            delegate.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        forEach { delegate in
            delegate.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        forEach {
            $0.applicationDidEnterBackground?(application)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        forEach {
            $0.applicationWillEnterForeground?(application)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        forEach {
            $0.applicationWillTerminate?(application)
        }
    }

}
