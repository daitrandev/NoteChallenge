//
//  NoteChallengeApp.swift
//  NoteChallenge
//
//  Created by Dai Tran on 07/08/2023.
//

import SwiftUI
import Domain
import Data
import Presenter
import FirebaseDatabase
import FirebaseDatabaseSwift

@main
struct NoteChallengeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            TabView {
                AppFactory.makeLogginView()
                    .tabItem {
                        Label("Personal", systemImage: "person")
                    }
                AppFactory.makeFriendNotesView()
                    .tabItem {
                        Label("All Notes", systemImage: "line.horizontal.3")
                    }
            }
        }
    }
}
