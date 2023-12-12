//
//  WhisperProjectApp.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI
import Firebase

@main
struct WhisperProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RootView().preferredColorScheme(.light)
        }
    }
     
    
    
    class AppDelegate: NSObject , UIApplicationDelegate {
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            
        }

    }
}
