//
//  AddNoteView.swift
//  Presenter
//
//  Created by Dai Tran on 08/08/2023.
//

import Domain
import SwiftUI

public struct AddNoteView<T: AddNoteViewModelType>: View {
    private let didAddNote: (UserNote?) -> Void
    @ObservedObject var viewModel: T
    @EnvironmentObject var loggedInUser: UserInfoEnv
    
    public init(viewModel: T, didAddNote: @escaping (UserNote?) -> Void) {
        self.viewModel = viewModel
        self.didAddNote = didAddNote
    }
    
    public var body: some View {
        VStack {
            TextField("Note", text: $viewModel.note)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
            Spacer()
        }
        .padding(.horizontal, 8)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Add Notes")
        .toolbar {
            Button("Done") {
                Task {
                    do {
                        let notes = try await viewModel.createNote(userName: loggedInUser.userName)
                        loggedInUser.notes = notes
                        didAddNote(notes.last)
                    } catch {
                        debugPrint(error.localizedDescription)
                        didAddNote(nil)
                    }
                }
            }
        }
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(viewModel: AddNoteViewModel(userNoteUseCase: UserNoteUseCaseImpl(userNoteRepository: UserNoteRepositoryMock())), didAddNote: { _ in })
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
