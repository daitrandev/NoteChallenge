//
//  UserInfoService.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation
import Domain

public protocol UserInfoService {
    func createUser(userName: String) async throws -> UserInfo
    func fetchUserInfo(userName: String) async throws -> UserInfo
}
