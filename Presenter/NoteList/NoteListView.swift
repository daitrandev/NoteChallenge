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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var loggedInUser: UserInfoEnv
    @ObservedObject var viewModel: T
    
    public init(viewModel: T, addNoteView: @escaping (() -> V)) {
        self.viewModel = viewModel
        self.addNoteView = addNoteView
    }
    
    public var body: some View {
        NavigationLink(
            destination: addNoteView()
                .environmentObject(loggedInUser),
            isActive: $isShowingAddNote) {
                EmptyView()
            }
        
        List($viewModel.notes, id: \.id) {
            NoteListRow(note: $0.wrappedValue)
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingAddNote = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("All Notes")
        .onAppear {
            Task {
                if !loggedInUser.userName.isEmpty {
                    await viewModel.fetchNotes(userName: loggedInUser.userName)
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
                )
            ),
            addNoteView: {
                EmptyView()
            }
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
