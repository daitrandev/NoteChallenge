//
//  FirebaseUserInfoService.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation
import Domain
import FirebaseDatabase
import FirebaseDatabaseSwift

final class FirebaseUserInfoService: UserInfoService {
    private var databaseRef: DatabaseReference
    
    init(databaseRef: DatabaseReference) {
        self.databaseRef = databaseRef
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        let userInfo = UserInfo(id: "1", userName: userName, notes: [])
        databaseRef.setValue(userInfo, forKey: "1")
        return UserInfo(id: "1", userName: userName, notes: [])
    }
}
