//
//  Encodable+Ext.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation

extension Encodable {
    var dict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        return json
    }
}
