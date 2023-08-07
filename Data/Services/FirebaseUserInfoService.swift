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
        let userInfo = UserInfo(userName: userName, notes: [])
        databaseRef.setValue(userInfo, forKey: "1")
        return UserInfo(userName: userName, notes: [])
    }
    
    func fetchUserInfo(userName: String) async throws -> UserInfo {
        try await withCheckedThrowingContinuation { continuation in
            databaseRef.child(userName).getData { error, snapshot in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                guard let dictionary = snapshot?.value as? NSDictionary else {
                    continuation.resume(throwing: NSError(domain: "Data not found", code: 0))
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
                    let userInfo = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                    continuation.resume(returning: userInfo)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
