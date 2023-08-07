//
//  UserInfo.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public struct UserInfo {
    let id: String
    let userName: String
    let notes: [UserNote]
    
    public init(id: String, userName: String, notes: [UserNote]) {
        self.id = id
        self.userName = userName
        self.notes = notes
    }
}
