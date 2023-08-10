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
        // Given
        let expectedNotes: [UserNote] = [
            .init(id: "1", content: "Hello"),
            .init(id: "2", content: "World")
        ]
        let vm = NoteListViewModel(userNoteUseCase: UserNoteUseCaseMock(notes: expectedNotes))
        
        runAsyncTest {
            // When
            await vm.fetchNotes(userName: "abc")
            
            // Then
            XCTAssertEqual(vm.notes, expectedNotes)
        }
    }
}
