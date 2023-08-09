//
//  LoginVMTests.swift
//  PresenterTests
//
//  Created by Dai Tran on 8/9/23.
//

import XCTest
import Domain
@testable import Presenter

final class LoginVMTests: XCTestCase {
    func test_loggin() {
        // Given
        let addingUser = UserInfo(userName: "Xin Chao", notes: [])
        let vm = LoginViewModel(userInfoUseCase: UserInfoUseCaseMock(users: []))
        vm.userName = addingUser.userName
        let expectation = expectation(description: "Test User Login")
        
        //When
        Task {
            do {
                try await vm.didTapLogin()
                expectation.fulfill()
            } catch {
                XCTFail("Cannot log in")
            }
        }
        waitForExpectations(timeout: 5)
        
        // Then
        XCTAssertEqual(vm.loggedInUser.userName, vm.userName)
    }
}
