import Foundation
import UIKit
import AWSAppSync

class AWSAppSyncBootstrap: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let databaseURL = URL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent("Standup")
        
        do {
            //AppSync configuration & client initialization
            let appSyncConfig = try AWSAppSyncClientConfiguration(appSyncClientInfo: AWSAppSyncClientInfo(),databaseURL: databaseURL)
            let appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig)
            // Set id as the cache key for objects. See architecture section for details
            appSyncClient.apolloClient?.cacheKeyForObject = { $0["id"] }
            
            let taskService: TaskService = AWSTaskService(client: appSyncClient)
            ServiceLocator.shared.registerService(taskService)
            
        } catch {
            print("Error initializing appsync client. \(error)")
            return false
        }
        
        return true
    }
}

