//
//  UserNoteUseCase.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public protocol UserNoteUseCase {
    func create(userId: String, noteContent: String) async throws -> UserNote
    func fetchUserNotes(userId: String) async throws -> [UserNote]
}

public final class UserNoteUseCaseImpl: UserNoteUseCase {
    private let userNoteRepository: UserNotesRepository
    
    init(userNoteRepository: UserNotesRepository) {
        self.userNoteRepository = userNoteRepository
    }
    
    public func create(userId: String, noteContent: String) async throws -> UserNote {
        let result = try await userNoteRepository.createUserNote(userId: userId, content: noteContent)
        return result
    }
    
    public func fetchUserNotes(userId: String) async throws -> [UserNote] {
        let result = try await userNoteRepository.fetchUserNote(userId: userId)
        return result
    }
}
