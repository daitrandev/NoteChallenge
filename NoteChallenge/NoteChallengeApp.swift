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
            makeLogginView()
        }
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
        let addNoteVM = AddNoteViewModel(
            userNoteUseCase: UserNoteUseCaseImpl(
                userNoteRepository: UserNotesRepositoryImpl(
                    userNoteService: FirebaseUserNoteService(databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference())
                )
            )
        )
        let friendNoteVM = FriendNotesViewModel(
            userNoteUseCase: UserNoteUseCaseImpl(
                userNoteRepository: UserNotesRepositoryImpl(
                    userNoteService: FirebaseUserNoteService(databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference())
                    )
                )
            )
        return NoteListView(
            viewModel: noteListVM,
            addNoteView: {
                AddNoteView(viewModel: addNoteVM) { _ in
                    
                }
            }, friendNotesView: {
                FriendNotesView(viewModel: friendNoteVM)
            }
        )
    }
}
