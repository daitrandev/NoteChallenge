//
//  UserInfoUseCaseMock.swift
//  PresenterTests
//
//  Created by Dai Tran on 8/9/23.
//

import Domain

final class UserInfoUseCaseMock: UserInfoUseCase {
    private var users: [UserInfo]
    
    init(users: [UserInfo]) {
        self.users = users
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
