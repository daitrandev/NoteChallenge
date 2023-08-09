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
        let creatingUserInfo = UserInfo(userName: "Hello", notes: [])
        let vm = LoginViewModel(userInfoUseCase: UserInfoUseCaseMock(userInfo: creatingUserInfo))
        let expectation = expectation(description: "Test User Login")
        Task {
            do {
                try await vm.didTapLogin()
                expectation.fulfill()
            } catch {
                XCTFail("Cannot log in")
            }
        }
        waitForExpectations(timeout: 5)
        XCTAssertEqual(vm.loggedInUser, UserInfoEnv(userInfo: creatingUserInfo))
    }
}

private class UserInfoUseCaseMock: UserInfoUseCase {
    private let userInfo: UserInfo
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    func fetchAllUsers() async throws -> [UserInfo] {
        []
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        userInfo
    }
}
