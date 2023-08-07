//
//  UserNotesRepository.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

protocol UserNotesRepository {
    func createUserNote(userId: String, content: String) async throws -> UserNote
    func updateUserNote(userId: String, userNote: String) async throws -> UserNote
    func fetchUserNote(userId: String) async throws -> [UserNote]
}
