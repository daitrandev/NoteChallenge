//
//  NoteListView.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import SwiftUI

public struct NoteListView<T: NoteListViewModelType, V: View, N: View>: View {
    private let addNoteView: (() -> V)
    private let friendNotesView: (() -> N)
    
    @State private var isShowingAddNote: Bool = false
    @State private var isShowingFriendNotes: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var loggedInUser: UserInfoEnv
    @ObservedObject var viewModel: T
    
    public init(viewModel: T,
                addNoteView: @escaping (() -> V),
                friendNotesView: @escaping (() -> N)) {
        self.viewModel = viewModel
        self.addNoteView = addNoteView
        self.friendNotesView = friendNotesView
    }
    
    public var body: some View {
        NavigationLink(
            destination:
                ZStack {
                    if isShowingAddNote {
                        addNoteView().environmentObject(loggedInUser)
                    }
                }
            ,
            isActive: $isShowingAddNote) {
                EmptyView()
            }
            .toolbar {
                ToolbarItemGroup {
                    NavigationLink(
                        destination: ZStack {
                            if isShowingFriendNotes {
                                friendNotesView()
                            }
                        },
                        isActive: $isShowingFriendNotes) {
                            Button {
                                isShowingFriendNotes = true
                            } label: {
                                Image(systemName: "person.3.fill")
                            }
                        }
                    
                    Button {
                        isShowingAddNote = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("All Notes")
        
        if !loggedInUser.notes.isEmpty {
            List(loggedInUser.notes, id: \.id) {
                NoteListRow(note: $0)
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
            },
            friendNotesView: {
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
