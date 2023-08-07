//
//  NoteListViewModel.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import Foundation

public protocol NoteListViewModelType: ObservableObject {
    var notes: [UserNote] { get set }
}

final class NoteListViewModel: NoteListViewModelType {
    private let userNoteUseCase: UserNoteUseCase
    private let userInfo: UserInfo
    @Published var notes: [Domain.UserNote] = []
    
    init(userNoteUseCase: UserNoteUseCase, userInfo: UserInfo) {
        self.userInfo = userInfo
        self.userNoteUseCase = userNoteUseCase
        
        Task {
            await fetchNotes()
        }
    }
    
    private func fetchNotes() async {
        do {
            let notes = try await userNoteUseCase.fetchNotes(userName: userInfo.userName)
            await MainActor.run {
                self.notes = notes
            }
        } catch {
            
        }
    }
}
