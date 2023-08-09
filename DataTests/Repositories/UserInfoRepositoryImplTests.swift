//
//  UserInfoRepositoryImplTests.swift
//  DataTests
//
//  Created by Dai Tran on 8/9/23.
//

import XCTest
import Domain
@testable import Data

final class UserInfoRepositoryImplTests: XCTestCase {
    func test_createUser() async {
        let sut = makeSUT()
        let newUser = UserInfo(userName: "Xin Chao", notes: [])
        do {
            let createdUser = try await sut.createUser(userName: newUser.userName)
            let allUsers = try await sut.fetchAllUsers()
            XCTAssertEqual(createdUser, newUser)
            XCTAssertNotNil(allUsers.first(where: { $0 == createdUser }))
        } catch {
            XCTFail("Cannot create user")
        }
    }
    
    func test_fetchUserInfo_success() async {
        let sut = makeSUT()
        do {
            let fetchUser = try await sut.fetchUserInfo(userName: "Hello")
            XCTAssertNotNil(fetchUser)
        } catch {
            XCTFail("Cannot fetch user info")
        }
    }
    
    func test_fetchUserInfo_error() {
        let sut = makeSUT()
        let expectation = expectation(description: "test fetch user info failed")
        Task {
            do {
                _ = try await sut.fetchUserInfo(userName: "There")
                XCTFail("Fetch user info isn't failed")
            } catch {
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3)
    }
    
    func test_fetchAllUsers() async {
        let mockUsers: [UserInfo] = [
            .init(userName: "Hello", notes: []),
            .init(userName: "World", notes: [])
        ]
        let sut = UserInfoRepositoryImpl(service: UserInfoUseCaseMock(users: mockUsers))
        do {
            let users = try await sut.fetchAllUsers()
            XCTAssertEqual(users, mockUsers)
        } catch {
            XCTFail("Fetch all users failed")
        }
    }
    
    private func makeSUT() -> UserInfoRepositoryImpl {
        let mockUsers: [UserInfo] = [
            .init(userName: "Hello", notes: []),
            .init(userName: "World", notes: [])
        ]
        return UserInfoRepositoryImpl(service: UserInfoUseCaseMock(users: mockUsers))
    }
}

final class UserInfoUseCaseMock: UserInfoService {
    private var users: [UserInfo]
    
    init(users: [UserInfo]) {
        self.users = users
    }
    
    func fetchUserInfo(userName: String) async throws -> UserInfo {
        guard let foundUser = users.first(where: { $0.userName == userName }) else {
            throw NSError(domain: "Cannot fetch user info", code: 0)
        }
        return foundUser
    }
    
    func fetchAllUsers() async throws -> [UserInfo] {
        users
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        let newUser = UserInfo(userName: userName, notes: [])
        users.append(newUser)
        return newUser
    }
}
