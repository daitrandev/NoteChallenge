//
//  AppDelegate.swift
//  NoteChallenge
//
//  Created by Dai Tran on 07/08/2023.
//

import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
