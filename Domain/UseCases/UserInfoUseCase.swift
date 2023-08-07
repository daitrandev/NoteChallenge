//
//  UserInfoUseCase.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

protocol UserInfoUseCase {
    func createUser(userName: String) async throws -> UserInfo
}

final class UserInfoUseCaseImpl: UserInfoUseCase {
    private let userInfoRepository: UserInfoRepository
    
    init(userInfoRepository: UserInfoRepository) {
        self.userInfoRepository = userInfoRepository
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        let result = try await userInfoRepository.createUser(userName: userName)
        return result
    }
}
