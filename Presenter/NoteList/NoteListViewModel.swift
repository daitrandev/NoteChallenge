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
    var viewState: NoteListViewModel.ViewState { get set }
    func fetchNotes(userName: String) async
}

public final class NoteListViewModel: NoteListViewModelType {
    private let userNoteUseCase: UserNoteUseCase
    @Published public var notes: [UserNote] = []
    @Published public var viewState: ViewState = .noteList
    
    public enum ViewState {
        case noteList
        case addNote
    }
    
    public init(userNoteUseCase: UserNoteUseCase) {
        self.userNoteUseCase = userNoteUseCase
    }
    
    public func fetchNotes(userName: String) async {
        do {
            let notes = try await userNoteUseCase.fetchNotes(userName: userName)
            await MainActor.run {
                self.notes = notes
            }
        } catch {
            
        }
    }
}
