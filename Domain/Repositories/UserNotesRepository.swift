//
//  UserNotesRepository.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public protocol UserNotesRepository {
    func createNote(userName: String, content: String) async throws -> [UserNote]
    func updateNote(userName: String, note: UserNote) async throws -> [UserNote]
    func fetchNotes(userName: String) async throws -> [UserNote]
    func deleteNote(userName: String, note: UserNote) async throws -> [UserNote]
}
