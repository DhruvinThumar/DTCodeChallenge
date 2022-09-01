//
//  DTCodeChallengeApp.swift
//  DTCodeChallenge
//
//  Created by Dhruvin  on 31/08/22.
//

import SwiftUI
import GoogleMaps
 
// GOOGLE MAP SDK API KEY //
let APIKey = "AIzaSyDrx6FMEnzUCZsbFh6C2iz8hvd7TUYqt88"

class AppDelegate: NSObject, UIApplicationDelegate    {
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         GMSServices.provideAPIKey(APIKey)
         return true
     }
}

@main
struct DTCodeChallengeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
