//
//  FriendNotesView.swift
//  Presenter
//
//  Created by Dai Tran on 8/8/23.
//

import Domain
import SwiftUI

public struct FriendNotesView<T: FriendNotesViewModelType>: View {
    @ObservedObject var viewModel: T
    
    public init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            TextField("Searching Username", text: $viewModel.username)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            if viewModel.notes.isEmpty {
                Spacer()
                Text("Empty notes")
                Spacer()
            } else {
                List(viewModel.notes, id: \.id) { note in
                    NoteListRow(note: note)
                }
            }
        }
        .navigationTitle("Watch friend notes")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct FriendNote_Previews: PreviewProvider {
    static var previews: some View {
        FriendNotesView(viewModel: FriendNotesViewModel(userNoteUseCase: UserNoteUseCaseImpl(userNoteRepository: UserNoteRepositoryMock())))
    }
}

private class UserNoteRepositoryMock: UserNotesRepository {
    func createNote(userName: String, content: String) async throws -> [UserNote] {
        []
    }
    
    func updateNote(userName: String, note: UserNote) async throws -> [UserNote] {
        []
    }
    
    func fetchNotes(userName: String) async throws -> [UserNote] {
        [
            .init(id: "1", content: "Hello"),
            .init(id: "2", content: "World"),
        ]
    }
    
    func deleteNote(userName: String, note: UserNote) async throws -> [UserNote] {
        []
    }
}
