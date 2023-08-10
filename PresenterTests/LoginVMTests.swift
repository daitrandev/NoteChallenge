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
        
        runAsyncTest {
            // When
            try await vm.didTapLogin()
            
            // Then
            XCTAssertEqual(vm.loggedInUser.userName, vm.userName)
        }
    }
}
