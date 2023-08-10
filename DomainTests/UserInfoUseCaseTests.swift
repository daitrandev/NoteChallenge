//
//  UserInfoUseCaseTests.swift
//  DomainTests
//
//  Created by Dai Tran on 8/10/23.
//

import XCTest
@testable import Domain

final class UserInfoUseCaseTests: XCTestCase {
    func test_fetchAllUsers() {
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
        let usecase = UserInfoUseCaseImpl(userInfoRepository: UserInfoRepositoryMock(users: mockUsers))
        runAsyncTest {
            let result = try await usecase.fetchAllUsers()
            XCTAssertEqual(result, mockUsers)
        }
    }
    
    func test_createUser() {
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
        let mockRepository = UserInfoRepositoryMock(users: mockUsers)
        let usecase = UserInfoUseCaseImpl(userInfoRepository: mockRepository)
        runAsyncTest {
            let createdUser = try await usecase.createUser(userName: "May")
            let fetchUsers = try await usecase.fetchAllUsers()
            let foundUser = fetchUsers.first(where: { $0 == createdUser })
            XCTAssertNotNil(foundUser)
        }
    }
}

final class UserInfoRepositoryMock: UserInfoRepository {
    private var users: [UserInfo]
    
    init(users: [UserInfo]) {
        self.users = users
    }
    
    func fetchAllUsers() async throws -> [UserInfo] {
        users
    }
    
    func fetchUserInfo(userName: String) async throws -> UserInfo {
        guard let foundUser = users.first(where: { $0.userName == userName }) else {
            throw NSError(domain: "Cannot find the user", code: 0)
        }
        return foundUser
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        let newUser = UserInfo(userName: userName, notes: [])
        users.append(newUser)
        return newUser
    }
}
