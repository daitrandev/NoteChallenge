//
//  UserNoteUseCaseTests.swift
//  DomainTests
//
//  Created by Dai Tran on 8/9/23.
//

import XCTest
@testable import Domain

final class UserNoteUseCaseTests: XCTestCase {
    func test_createNote_success() {
        let (sut, mockUsers) = makeSUT()
        let username = "Xun"
        let noteContent = "I'm coding."
        
        runAsyncTest {
            let result = try await sut.createNote(userName: username, noteContent: noteContent)
            guard let updatingUser = mockUsers.first(where: { $0.userName == username }) else {
                throw NSError(domain: "Cannot found the user", code: 0)
            }
            var updatingNotes = updatingUser.notes
            updatingNotes.append(.init(id: "\(updatingNotes.count + 1)", content: noteContent))
            XCTAssertEqual(result, updatingNotes)
        }
    }
    
    func test_fetchNotes() {
        let (sut, mockUsers) = makeSUT()
        let username = "Mei"
        
        runAsyncTest {
            let result = try await sut.fetchNotes(userName: username)
            guard let updatingUser = mockUsers.first(where: { $0.userName == username }) else {
                throw NSError(domain: "Cannot found the user", code: 0)
            }
            XCTAssertEqual(result, updatingUser.notes)
        }
    }
    
    private func makeSUT() -> (UserNoteUseCase, [UserInfo]) {
        let mockUsers: [UserInfo] = [
            .init(userName: "Xun", notes: [
                .init(id: "1", content: "Hello, I'm from Viet Nam"),
                .init(id: "2", content: "Hello World")
            ]),
            .init(userName: "Mei", notes: [
                .init(id: "1", content: "Hello, I'm from US"),
                .init(id: "2", content: "Hello World")
            ])
        ]
        let usecase = UserNoteUseCaseImpl(userNoteRepository: UserNotesRepositoryMock(users: mockUsers))
        return (usecase, mockUsers)
    }
}

final class UserNotesRepositoryMock: UserNotesRepository {
    private var users: [UserInfo]
    
    init(users: [UserInfo]) {
        self.users = users
    }
    
    func createNote(userName: String, content: String) async throws -> [UserNote] {
        guard let userIndex = users.firstIndex(where: { $0.userName == userName }) else {
            throw NSError(domain: "User not found", code: 0)
        }
        let updatingUser = users[userIndex]
        
        var newNotes: [UserNote] = updatingUser.notes
        newNotes.append(.init(id: "\(newNotes.count + 1)", content: content))
        users[userIndex] = UserInfo(userName: userName, notes: newNotes)
        return newNotes
    }
    
    func updateNote(userName: String, note: UserNote) async throws -> [UserNote] {
        guard let userIndex = users.firstIndex(where: { $0.userName == userName }),
              let noteIndex = users[userIndex].notes.firstIndex(where: { $0.id == note.id }) else {
            throw NSError(domain: "User not found", code: 0)
        }
        let updatingUser = users[userIndex]
        let updatingNote = updatingUser.notes[noteIndex]
        
        var newNotes: [UserNote] = updatingUser.notes
        newNotes[noteIndex] = UserNote(id: updatingNote.id, content: note.content)
        users[userIndex] = UserInfo(userName: updatingUser.userName, notes: newNotes)
        return newNotes
    }
    
    func fetchNotes(userName: String) async throws -> [UserNote] {
        guard let user = users.first(where: { $0.userName == userName }) else {
            throw NSError(domain: "User not found", code: 0)
        }
        return user.notes
    }
    
    func deleteNote(userName: String, note: UserNote) async throws -> [UserNote] {
        guard let userIndex = users.firstIndex(where: { $0.userName == userName }),
              let noteIndex = users[userIndex].notes.firstIndex(where: { $0.id == note.id }) else {
            throw NSError(domain: "User not found", code: 0)
        }
        
        let updatingUser = users[userIndex]
        let deletingNote = updatingUser.notes[noteIndex]
        
        let newNotes: [UserNote] = updatingUser.notes.filter { $0 != deletingNote }
        users[userIndex] = UserInfo(userName: updatingUser.userName, notes: newNotes)
        return newNotes
    }
}
