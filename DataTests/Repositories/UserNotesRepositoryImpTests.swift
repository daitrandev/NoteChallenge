//
//  UserNotesRepositoryImpTests.swift
//  DataTests
//
//  Created by Dai Tran on 8/9/23.
//

import XCTest
import Domain
@testable import Data

final class UserNotesRepositoryImpTests: XCTestCase {
    func test_fetchNotes() {
        // Given
        let (sut, mockUsers) = makeSUT()
        let username = "Mei"
        
        runAsyncTest {
            // When
            let result = try await sut.fetchNotes(userName: username)
            let mockNotes = mockUsers.first(where: { $0.userName == username })?.notes
            
            // Then
            XCTAssertEqual(mockNotes, result)
        }
    }
    
    func test_createNote() {
        // Given
        let (sut, _) = makeSUT()
        let username = "Mei"
        let contentNote = "I'm coding"
        let expectedNotes: [UserNote] = [
            .init(id: "1", content: "Hello, I'm from US"),
            .init(id: "2", content: "Hello World"),
            .init(id: "3", content: contentNote)
        ]
        runAsyncTest {
            // When
            let result = try await sut.createNote(userName: username, content: contentNote)
            let fetchNotes = try await sut.fetchNotes(userName: username)
            
            // Then
            XCTAssertEqual(result, fetchNotes)
            XCTAssertEqual(result, expectedNotes)
        }
    }
    
    func test_updateNote() {
        // Given
        let (sut, _) = makeSUT()
        let username = "Mei"
        let updatingNote = UserNote(id: "1", content: "Nice to meet you")
        let expectedNotes = [
            updatingNote,
            UserNote(id: "2", content: "Hello World")
        ]
        runAsyncTest {
            // When
            let result = try await sut.updateNote(userName: username, note: updatingNote)
            let fetchedNotes = try await sut.fetchNotes(userName: username)
            
            // Then
            XCTAssertEqual(result, expectedNotes)
            XCTAssertEqual(fetchedNotes, expectedNotes)
        }
    }
    
    func test_deleteNote() {
        // Given
        let (sut, mockUsers) = makeSUT()
        let username = "Mei"
        let deletingNote = UserNote(id: "1", content: "Hello, I'm from US")
        let expectedNotes = mockUsers.first(where: { $0.userName == username })?.notes.filter { $0 != deletingNote }
        runAsyncTest {
            // When
            let result = try await sut.deleteNote(userName: username, note: deletingNote)
            let fetchedNotes = try await sut.fetchNotes(userName: username)
            
            // Then
            XCTAssertEqual(result, expectedNotes)
            XCTAssertEqual(fetchedNotes, expectedNotes)
        }
    }
    
    private func makeSUT() -> (UserNotesRepositoryImpl, [UserInfo]) {
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
        let repository =  UserNotesRepositoryImpl(userNoteService: UserNoteServiceMock(users: mockUsers))
        return (repository, mockUsers)
    }
}

final class UserNoteServiceMock: UserNoteService {
    private var users: [UserInfo]
    
    init(users: [UserInfo]) {
        self.users = users
    }
    
    func createNote(userName: String, noteContent: String) async throws -> [UserNote] {
        guard let userIndex = users.firstIndex(where: { $0.userName == userName }) else {
            throw NSError(domain: "Cannot find the user", code: 0)
        }
        var newNotes = users[userIndex].notes
        let newNote = UserNote(id: "\(newNotes.count + 1)", content: noteContent)
        newNotes.append(newNote)
        
        let updatedUser = UserInfo(userName: users[userIndex].userName, notes: newNotes)
        users[userIndex] = updatedUser
        return newNotes
    }
    
    func updateNote(userName: String, note: UserNote) async throws -> [UserNote] {
        guard
            let userIndex = users.firstIndex(where: { $0.userName == userName }),
            let noteIndex = users[userIndex].notes.firstIndex(where: { $0.id == note.id }) else {
                throw NSError(domain: "Cannot find the user", code: 0)
        }
        var newNotes = users[userIndex].notes
        newNotes[noteIndex] = note
        let updatedUser = UserInfo(userName: users[userIndex].userName, notes: newNotes)
        users[userIndex] = updatedUser
        return newNotes
    }
    
    func deleteNote(userName: String, note: UserNote) async throws -> [UserNote] {
        guard
            let userIndex = users.firstIndex(where: { $0.userName == userName }) else {
                throw NSError(domain: "Cannot find the user", code: 0)
        }
        let newNotes = users[userIndex].notes.filter { $0.id != note.id }
        let updatedUser = UserInfo(userName: users[userIndex].userName, notes: newNotes)
        users[userIndex] = updatedUser
        return newNotes
    }
    
    func fetchNotes(userName: String) async throws -> [UserNote] {
        guard let notes = users.first(where: { $0.userName == userName })?.notes else {
            throw NSError(domain: "Cannot find the user", code: 0)
        }
        return notes
    }
}
