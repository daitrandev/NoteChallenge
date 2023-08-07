//
//  UserNoteService.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation
import Domain

public protocol UserNoteService {
    func createNote(userName: String, noteContent: String) async throws -> [UserNote]
    func updateNote(userName: String, note: UserNote) async throws -> [UserNote]
    func deleteNote(userName: String, note: UserNote) async throws -> [UserNote]
    func fetchNotes(userName: String) async throws -> [UserNote]
}
