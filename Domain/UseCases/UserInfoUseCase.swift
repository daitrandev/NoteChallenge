//
//  UserInfoUseCase.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public protocol UserInfoUseCase {
    func createUser(userName: String) async throws -> UserInfo
}

public final class UserInfoUseCaseImpl: UserInfoUseCase {
    private let userInfoRepository: UserInfoRepository
    
    public init(userInfoRepository: UserInfoRepository) {
        self.userInfoRepository = userInfoRepository
    }
    
    public func createUser(userName: String) async throws -> UserInfo {
        let result = try await userInfoRepository.createUser(userName: userName)
        return result
    }
}
