//
//  UserInfoRepositoryImpl.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation
import Domain

public final class UserInfoRepositoryImpl: UserInfoRepository {
    private let service: UserInfoService
    
    public init(service: UserInfoService) {
        self.service = service
    }
    
    public func fetchUserInfo(userName: String) async throws -> UserInfo {
        try await service.fetchUserInfo(userName: userName)
    }
    
    public func createUser(userName: String) async throws -> UserInfo {
        try await service.createUser(userName: userName)
    }
}
