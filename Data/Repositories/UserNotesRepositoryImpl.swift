//
//  UserNotesRepositoryImpl.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation
import Domain

final class UserNotesRepositoryImpl: UserNotesRepository {
    private let userNoteService: UserNoteService
    
    init(userNoteService: UserNoteService) {
        self.userNoteService = userNoteService
    }
    
    func createNote(userName: String, content: String) async throws -> [UserNote] {
        try await userNoteService.createNote(userName: userName, noteContent: content)
    }
    
    func updateNote(userName: String, note: UserNote) async throws -> [UserNote] {
        try await userNoteService.updateNote(userName: userName, note: note)
    }
    
    func deleteNote(userName: String, note: UserNote) async throws -> [UserNote] {
        try await userNoteService.deleteNote(userName: userName, note: note)
    }
    
    func fetchNotes(userName: String) async throws -> [UserNote] {
        try await userNoteService.fetchNotes(userName: userName)
    }
}
