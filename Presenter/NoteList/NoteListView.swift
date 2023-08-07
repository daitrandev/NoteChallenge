//
//  NoteListView.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import SwiftUI

struct NoteListView<T: NoteListViewModelType>: View {
    @ObservedObject var viewModel: T
    
    public init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.notes, id: \.id) {
                NoteListRow(note: $0)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(
            viewModel: NoteListViewModel(
                userNoteUseCase: UserNoteUseCaseImpl(
                    userNoteRepository: UserNoteRepositoryMock()
                ),
                userInfo: UserInfo(userName: "Hello", notes: [])
            )
        )
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
