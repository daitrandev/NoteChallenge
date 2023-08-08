//
//  UserInfoKey.swift
//  Presenter
//
//  Created by Dai Tran on 08/08/2023.
//

import Domain
import SwiftUI

private struct UserInfoKey: EnvironmentKey {
    static let defaultValue: UserInfo? = nil
}

extension EnvironmentValues {
    public var userInfo: UserInfo? {
        get { self[UserInfoKey.self] }
        set { self[UserInfoKey.self] = newValue }
    }
}
