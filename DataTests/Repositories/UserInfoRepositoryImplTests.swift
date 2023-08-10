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
    func test_createUser() {
        // Given
        let (sut, _) = makeSUT()
        let newUser = UserInfo(userName: "Xin Chao", notes: [])
        
        runAsyncTest {
            // When
            let createdUser = try await sut.createUser(userName: newUser.userName)
            let allUsers = try await sut.fetchAllUsers()
            
            // Then
            XCTAssertEqual(createdUser, newUser)
            XCTAssertNotNil(allUsers.first(where: { $0 == createdUser }))
        }
    }
    
    func test_fetchUserInfo_success() {
        // Given
        let (sut, _) = makeSUT()
        runAsyncTest {
            // When
            let fetchUser = try await sut.fetchUserInfo(userName: "Hello")
            
            // Then
            XCTAssertNotNil(fetchUser)
        }
    }
    
    func test_fetchAllUsers() {
        // Given
        let (sut, mockUsers) = makeSUT()
        
        runAsyncTest {
            // When
            let users = try await sut.fetchAllUsers()
            
            // Then
            XCTAssertEqual(users, mockUsers)
        }
    }
    
    private func makeSUT() -> (UserInfoRepositoryImpl, [UserInfo]) {
        let mockUsers: [UserInfo] = [
            .init(userName: "Hello", notes: []),
            .init(userName: "World", notes: [])
        ]
        return (UserInfoRepositoryImpl(service: UserInfoUseCaseMock(users: mockUsers)), mockUsers)
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
