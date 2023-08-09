//
//  NoteListView.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import SwiftUI

public struct NoteListView<T: NoteListViewModelType, V: View>: View {
    private let addNoteView: (() -> V)
    
    @State private var isShowingAddNote: Bool = false
    @State private var isShowingFriendNotes: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var loggedInUser: UserInfoEnv
    @ObservedObject var viewModel: T
    
    public init(viewModel: T,
                addNoteView: @escaping (() -> V)) {
        self.viewModel = viewModel
        self.addNoteView = addNoteView
    }
    
    public var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .noteList:
                List(loggedInUser.notes, id: \.id) {
                    NoteListRow(note: $0)
                }
                .toolbar {
                    ToolbarItemGroup {
                        Button {
                            viewModel.viewState = .addNote
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            case .addNote:
                addNoteView()
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(loggedInUser.userName)
        
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(
            viewModel: NoteListViewModel(
                userNoteUseCase: UserNoteUseCaseImpl(
                    userNoteRepository: UserNoteRepositoryMock()
                )
            ),
            addNoteView: {
                EmptyView()
            }
        )
        .environmentObject(UserInfoEnv(userName: "Hello", notes: [
            .init(id: "1", content: "Hello"),
            .init(id: "2", content: "World"),
        ]))
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
