//
//  UserInfoRepository.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public protocol UserInfoRepository {
    func fetchAllUsers() async throws -> [UserInfo]
    func fetchUserInfo(userName: String) async throws -> UserInfo
    func createUser(userName: String) async throws -> UserInfo
}
