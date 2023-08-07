//
//  UserInfoRepositoryImpl.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation
import Domain

final class UserInfoRepositoryImpl: UserInfoRepository {
    private let service: UserInfoService
    
    init(service: UserInfoService) {
        self.service = service
    }
    
    func fetchUserInfo(userName: String) async throws -> UserInfo {
        try await service.fetchUserInfo(userName: userName)
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        try await service.createUser(userName: userName)
    }
}
