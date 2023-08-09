//
//  UserNoteUseCaseMock.swift
//  PresenterTests
//
//  Created by Dai Tran on 8/9/23.
//

import Domain

final class UserNoteUseCaseMock: UserNoteUseCase {
    private var notes: [UserNote]
    
    init(notes: [UserNote]) {
        self.notes = notes
    }
    
    func createNote(userName: String, noteContent: String) async throws -> [UserNote] {
        let newNote = UserNote(id: "\(notes.count + 1)", content: noteContent)
        notes.append(newNote)
        return notes
    }
    
    func fetchNotes(userName: String) async throws -> [UserNote] {
        notes
    }
}
