import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var delegates: [UIApplicationDelegate] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return delegates.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        delegates.applicationWillResignActive(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        delegates.applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        delegates.applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        delegates.applicationDidBecomeActive(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        delegates.applicationWillTerminate(application)
    }


}

