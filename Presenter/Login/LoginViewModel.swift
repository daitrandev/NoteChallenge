//
//  LoginViewModel.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import Foundation

public protocol LoginViewModelType: ObservableObject {
    func didTapLogin(userName: String)
}

public final class LoginViewModel: LoginViewModelType {
    private let userInfoUseCase: UserInfoUseCase
    
    public init(userInfoUseCase: UserInfoUseCase) {
        self.userInfoUseCase = userInfoUseCase
    }
    
    public func didTapLogin(userName: String) {
        Task {
            let userInfo = try await userInfoUseCase.createUser(userName: userName)
            await MainActor.run {
                print("Login Successful")
            }
        }
    }
}

