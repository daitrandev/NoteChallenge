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

public final class FirebaseUserInfoService: UserInfoService {
    private var databaseRef: DatabaseReference
    
    public init(databaseRef: DatabaseReference) {
        self.databaseRef = databaseRef
    }
    
    public func createUser(userName: String) async throws -> UserInfo {
        guard let dictionary = UserInfo(userName: userName, notes: []).dict else {
            throw NSError(domain: "Cannot parse userInfo", code: 0)
        }
        try await databaseRef.child(userName).setValue(dictionary)
        return UserInfo(userName: userName, notes: [])
    }
    
    public func fetchUserInfo(userName: String) async throws -> UserInfo {
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
