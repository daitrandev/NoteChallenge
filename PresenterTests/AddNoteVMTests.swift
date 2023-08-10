//
//  AddNoteVMTests.swift
//  PresenterTests
//
//  Created by Dai Tran on 8/9/23.
//

import XCTest
import Domain
@testable import Presenter

final class AddNoteVMTests: XCTestCase {
    func test_addNote() {
        // Given
        let initialNotes: [UserNote] = [
            .init(id: "1", content: "Hello"),
            .init(id: "2", content: "World"),
        ]
        let vm = AddNoteViewModel(userNoteUseCase: UserNoteUseCaseMock(notes: initialNotes))
        let newNote: UserNote = .init(id: "\(initialNotes.count + 1)", content: "Hello World")
        vm.note = newNote.content
        let expectedResult = initialNotes + [newNote]
        
        runAsyncTest {
            // When
            let result = try await vm.createNote(userName: "abc")
            
            // Then
            XCTAssertEqual(expectedResult, result)
        }
    }
}
