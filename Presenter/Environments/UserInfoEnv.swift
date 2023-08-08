//
//  UserInfoEnv.swift
//  Presenter
//
//  Created by Dai Tran on 08/08/2023.
//

import Domain
import Foundation

public final class UserInfoEnv: ObservableObject {
    @Published public var userName: String
    @Published public var notes: [UserNote]
    
    public init(userName: String, notes: [UserNote]) {
        self.userName = userName
        self.notes = notes
    }
    
    public init(userInfo: UserInfo) {
        self.userName = userInfo.userName
        self.notes = userInfo.notes
    }
    
    public init() {
        userName = ""
        notes = []
    }
}
