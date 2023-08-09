//
//  NoteListVMTests.swift
//  PresenterTests
//
//  Created by Dai Tran on 8/9/23.
//

import XCTest
import Domain
@testable import Presenter

final class NoteListVMTests: XCTestCase {
    func test_fetchNotes() {
        let expectedNotes: [UserNote] = [
            .init(id: "1", content: "Hello"),
            .init(id: "2", content: "World")
        ]
        let vm = NoteListViewModel(userNoteUseCase: UserNoteUseCaseMock(notes: expectedNotes))
        let expectation = expectation(description: "Test fetch note")
        Task {
            await vm.fetchNotes(userName: "abc")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertEqual(vm.notes, expectedNotes)
    }
}

private class UserNoteUseCaseMock: UserNoteUseCase {
    private var notes: [UserNote]
    
    init(notes: [UserNote]) {
        self.notes = notes
    }
    
    func createNote(userName: String, noteContent: String) async throws -> [UserNote] {
        []
    }
    
    func fetchNotes(userName: String) async throws -> [UserNote] {
        notes
    }
}
