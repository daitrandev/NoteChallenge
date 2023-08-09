//
//  AllNotesVMTests.swift
//  PresenterTests
//
//  Created by Dai Tran on 8/9/23.
//

import XCTest
import Domain
@testable import Presenter

final class AllNotesVMTests: XCTestCase {
    func test_success() async {
        // Given
        let mockUsers: [UserInfo] = [
            .init(userName: "Xin", notes: []),
            .init(userName: "Chao", notes: [])
        ]
        let vm = AllNotesViewModel(userInfoUseCase: UserInfoUseCaseMock(users: mockUsers))
        
        // When
        await vm.fetchUsers()
        
        // Then
        XCTAssertEqual(vm.users, mockUsers)
    }
}
