//
//  UserNotesRepository.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public protocol UserNotesRepository {
    func createNote(userId: String, content: String) async throws -> [UserNote]
    func updateNote(userId: String, note: UserNote) async throws -> [UserNote]
    func fetchNotes(userId: String) async throws -> [UserNote]
}
