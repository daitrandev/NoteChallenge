//
//  LoginView.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import Data
import SwiftUI

public struct LoginView<T: LoginViewModelType>: View {
    @State var username: String = ""
    @ObservedObject var viewModel: T
    
    public init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            Text("Input user name")
            TextField("Username", text: $username)
                .padding()
                .frame(width: 300, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            Button("Login") {
                viewModel.didTapLogin(userName: username)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(userInfoUseCase: UserInfoUseCaseImpl(userInfoRepository: UserInfoRepositoryImpl(service: UserInfoServiceMock()))))
    }
}

private class UserInfoServiceMock: UserInfoService {
    func createUser(userName: String) async throws -> UserInfo {
        .init(userName: "", notes: [])
    }
    
    func fetchUserInfo(userName: String) async throws -> UserInfo {
        .init(userName: "", notes: [])
    }
}
