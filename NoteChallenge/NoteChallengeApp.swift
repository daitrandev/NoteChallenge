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
            LoginView(
                viewModel: LoginViewModel(
                    userInfoUseCase: UserInfoUseCaseImpl(
                        userInfoRepository: UserInfoRepositoryImpl(
                            service: FirebaseUserInfoService(databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference())
                        )
                    )
                ), loggedInView: {
                    NoteListView(
                        viewModel: NoteListViewModel(
                            userNoteUseCase: UserNoteUseCaseImpl(
                                userNoteRepository: UserNotesRepositoryImpl(
                                    userNoteService: FirebaseUserNoteService(
                                        databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
                                    )
                                )
                            )
                        ),
                        addNoteView: {
                            AddNoteView(
                                viewModel: AddNoteViewModel(
                                    userNoteUseCase: UserNoteUseCaseImpl(
                                        userNoteRepository: UserNotesRepositoryImpl(
                                            userNoteService: FirebaseUserNoteService(databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference())
                                        )
                                    )
                                )
                            )
                        }, friendNotesView: {
                            FriendNotesView(viewModel: FriendNotesViewModel(
                                userNoteUseCase: UserNoteUseCaseImpl(
                                    userNoteRepository: UserNotesRepositoryImpl(
                                        userNoteService: FirebaseUserNoteService(databaseRef: Database.database(url: "https://notechallenge-52479-default-rtdb.asia-southeast1.firebasedatabase.app/").reference())
                                        )
                                    )
                                )
                            )
                        }
                    )
                }
            )
        }
    }
}
