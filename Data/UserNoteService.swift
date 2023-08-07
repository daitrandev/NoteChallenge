//
//  UserNoteService.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation
import Domain

protocol UserNoteService {
    func createNote(userId: String) async throws -> UserInfo
    func updateNote(userId: String, noteId: String) async throws -> UserInfo
    func deleteNote(userId: String, noteId: String) async throws -> UserInfo
}
