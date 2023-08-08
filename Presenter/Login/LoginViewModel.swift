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
    var loggedInUser: UserInfoEnv { get set }
    func didTapLogin() async throws
}

public final class LoginViewModel: LoginViewModelType {
    private let userInfoUseCase: UserInfoUseCase
    @Published public var userName: String = ""
    @Published public var showNoteList: Bool = false
    public var loggedInUser: UserInfoEnv = .init()
    
    public init(userInfoUseCase: UserInfoUseCase) {
        self.userInfoUseCase = userInfoUseCase
    }
    
    public func didTapLogin() async throws {
        do {
            let userInfo = try await userInfoUseCase.createUser(userName: userName)
            loggedInUser = UserInfoEnv(userInfo: userInfo)
            await MainActor.run {
                showNoteList = true
            }
        } catch {
            await MainActor.run {
                showNoteList = false
            }
            throw error
        }
    }
}

