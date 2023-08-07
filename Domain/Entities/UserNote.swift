//
//  UserNote.swift
//  Domain
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

public struct UserNote {
    public let id: String
    public let content: String
    
    public init(id: String, content: String) {
        self.id = id
        self.content = content
    }
    
    public init?(dictionary: NSDictionary) {
        guard
            let id = dictionary["id"] as? String,
            let content = dictionary["content"] as? String else {
            return nil
        }
        self.init(id: id, content: content)
    }
}
