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
        if userName.isEmpty {
            throw NSError(domain: "The username is empty", code: 0)
        }
        if let existingUser = try? await fetchUserInfo(userName: userName) {
            return existingUser
        }
        let newUser = UserInfo(userName: userName, notes: [])
        guard let dictionary = newUser.dict else {
            throw NSError(domain: "Cannot parse userInfo", code: 0)
        }
        try await databaseRef.child(userName).setValue(dictionary)
        return newUser
    }
    
    public func fetchAllUsers() async throws -> [UserInfo] {
        try await withCheckedThrowingContinuation { continuation in
            databaseRef.getData { error, snapshot in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                
                guard
                    let dictionary = snapshot?.value as? NSDictionary,
                    let allKeys = dictionary.allKeys as? [String] else {
                    continuation.resume(throwing: NSError(domain: "Data not found", code: 0))
                    return
                }
                let users = allKeys
                    .compactMap { dictionary[$0] as? NSDictionary }
                    .compactMap {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: $0)
                            let userInfo = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                            return userInfo
                        } catch {
                            return nil
                        }
                    }
                continuation.resume(returning: users)
            }
        }
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
