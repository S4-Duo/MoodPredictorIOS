//
//  MoodPredictorIOSApp.swift
//  MoodPredictorIOS
//
//  Created by Brett Mulder on 13/02/2023.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct MoodPredictorIOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("signIn") var isSignIn = false
    var body: some Scene {
        WindowGroup {
            if !isSignIn{
                ContentView()
            } else{
                Home()
            }
        }
    }
}
