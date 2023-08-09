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
                makeLogginView()
                    .tabItem {
                        Label("Personal", systemImage: "person")
                    }
                makeFriendNotesView()
                    .tabItem {
                        Label("All Notes", systemImage: "line.horizontal.3")
                    }
            }
        }
    }
    
    private func makeFriendNotesView() -> some View {
        let friendNoteVM = FriendNotesViewModel(
            userInfoUseCase: UserInfoUseCaseImpl(
                userInfoRepository: UserInfoRepositoryImpl(
                    service: FirebaseUserInfoService(databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference())
                    )
                )
            )
        return FriendNotesView(viewModel: friendNoteVM)
    }
    
    private func makeLogginView() -> some View {
        let loginVM = LoginViewModel(
            userInfoUseCase: UserInfoUseCaseImpl(
                userInfoRepository: UserInfoRepositoryImpl(
                    service: FirebaseUserInfoService(databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference())
                )
            )
        )
        return LoginView(
            viewModel: loginVM,
            loggedInView: makeLoggedView
        )
    }
    
    private func makeAddNote(didAddNote: @escaping (UserNote?) -> Void) -> some View {
        let addNoteVM = AddNoteViewModel(
            userNoteUseCase: UserNoteUseCaseImpl(
                userNoteRepository: UserNotesRepositoryImpl(
                    userNoteService: FirebaseUserNoteService(databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference())
                )
            )
        )
        return AddNoteView(viewModel: addNoteVM, didAddNote: didAddNote)
    }
    
    private func makeLoggedView() -> some View {
        let noteListVM = NoteListViewModel(
            userNoteUseCase: UserNoteUseCaseImpl(
                userNoteRepository: UserNotesRepositoryImpl(
                    userNoteService: FirebaseUserNoteService(
                        databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
                    )
                )
            )
        )
        
        
        return NoteListView(
            viewModel: noteListVM,
            addNoteView: { makeAddNote(didAddNote: { _ in noteListVM.viewState = .noteList }) }
        )
    }
}
