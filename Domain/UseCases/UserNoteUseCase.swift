//
//  UserNoteUseCase.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public protocol UserNoteUseCase {
    func createNote(userName: String, noteContent: String) async throws -> [UserNote]
    func fetchNotes(userName: String) async throws -> [UserNote]
}

public final class UserNoteUseCaseImpl: UserNoteUseCase {
    private let userNoteRepository: UserNotesRepository
    
    public init(userNoteRepository: UserNotesRepository) {
        self.userNoteRepository = userNoteRepository
    }
    
    public func createNote(userName: String, noteContent: String) async throws -> [UserNote] {
        let result = try await userNoteRepository.createNote(userName: userName, content: noteContent)
        return result
    }
    
    public func fetchNotes(userName: String) async throws -> [UserNote] {
        let result = try await userNoteRepository.fetchNotes(userName: userName)
        return result
    }
}
