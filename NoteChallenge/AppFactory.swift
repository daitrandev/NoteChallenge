//
//  AppFactory.swift
//  NoteChallenge
//
//  Created by Dai Tran on 8/9/23.
//

import SwiftUI
import Data
import Domain
import Presenter
import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct AppFactory {
    static func makeFirebaseUserInfoService() -> UserInfoService {
        FirebaseUserInfoService(
            databaseRef: Database.database(
                url: FirebaseKey.database
            ).reference()
        )
    }
    
    static func makeFirebaseUserNoteService() -> UserNoteService {
        FirebaseUserNoteService(
            databaseRef: Database.database(
                url: FirebaseKey.database
            ).reference()
        )
    }
    
    static func makeFriendNotesView() -> some View {
        let allNotesVM = AllNotesViewModel(
            userInfoUseCase: UserInfoUseCaseImpl(
                userInfoRepository: UserInfoRepositoryImpl(
                    service: makeFirebaseUserInfoService()
                )
            )
        )
        return AllNotesView(viewModel: allNotesVM)
    }
    
    static func makeAddNote(didAddNote: @escaping (UserNote?) -> Void) -> some View {
        let addNoteVM = AddNoteViewModel(
            userNoteUseCase: UserNoteUseCaseImpl(
                userNoteRepository: UserNotesRepositoryImpl(
                    userNoteService: makeFirebaseUserNoteService()
                )
            )
        )
        return AddNoteView(viewModel: addNoteVM, didAddNote: didAddNote)
    }
    
    static func makeLoggedView() -> some View {
        let noteListVM = NoteListViewModel(
            userNoteUseCase: UserNoteUseCaseImpl(
                userNoteRepository: UserNotesRepositoryImpl(
                    userNoteService: makeFirebaseUserNoteService()
                )
            )
        )
        return NoteListView(
            viewModel: noteListVM,
            addNoteView: { makeAddNote(didAddNote: { _ in noteListVM.viewState = .noteList }) }
        )
    }
    
    static func makeLogginView() -> some View {
        let loginVM = LoginViewModel(
            userInfoUseCase: UserInfoUseCaseImpl(
                userInfoRepository: UserInfoRepositoryImpl(
                    service: makeFirebaseUserInfoService()
                )
            )
        )
        return LoginView(
            viewModel: loginVM,
            loggedInView: makeLoggedView
        )
    }
}
