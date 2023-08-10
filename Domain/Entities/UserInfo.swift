//
//  UserInfo.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public struct UserInfo: Codable, Equatable {
    public let userName: String
    public let notes: [UserNote]
    
    public init(userName: String, notes: [UserNote]) {
        self.userName = userName
        self.notes = notes
    }
    
    public init() {
        self.userName = ""
        self.notes = []
    }
}
