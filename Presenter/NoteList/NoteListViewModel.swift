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
    func fetchNotes() async
}

public final class NoteListViewModel: NoteListViewModelType {
    private let userNoteUseCase: UserNoteUseCase
    private let userInfo: UserInfo
    @Published public var notes: [UserNote] = []
    
    public init(userNoteUseCase: UserNoteUseCase, userInfo: UserInfo) {
        self.userNoteUseCase = userNoteUseCase
        self.userInfo = userInfo
    }
    
    public func fetchNotes() async {
        do {
            let notes = try await userNoteUseCase.fetchNotes(userName: userInfo.userName)
            await MainActor.run {
                self.notes = notes
            }
        } catch {
            
        }
    }
}
