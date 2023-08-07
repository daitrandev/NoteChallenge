//
//  UserInfoRepository.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

protocol UserInfoRepository {
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func createUser(userName: String) async throws -> UserInfo
}
