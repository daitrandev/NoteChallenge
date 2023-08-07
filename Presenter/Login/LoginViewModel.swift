//
//  LoginViewModel.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import Foundation

public protocol LoginViewModelType: ObservableObject {
    var userName: String { get set }
    var showNoteList: Bool { get set }
    func didTapLogin() async
}

public final class LoginViewModel: LoginViewModelType {
    private let userInfoUseCase: UserInfoUseCase
    @Published public var userName: String = ""
    @Published public var showNoteList: Bool = false
    
    
    public init(userInfoUseCase: UserInfoUseCase) {
        self.userInfoUseCase = userInfoUseCase
    }
    
    public func didTapLogin() async {
        do {
            _ = try await userInfoUseCase.createUser(userName: userName)
            showNoteList = true
        } catch {
            showNoteList = false
        }
    }
}

