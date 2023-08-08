//
//  LoginView.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import SwiftUI

public struct LoginView<T: LoginViewModelType, N: View>: View {
    @ViewBuilder let loggedInView: (() -> N)
    @ObservedObject var viewModel: T
    
    public init(viewModel: T, loggedInView: @escaping (() -> N)) {
        self.viewModel = viewModel
        self.loggedInView = loggedInView
    }
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                NavigationLink(destination: loggedInView(),
                               isActive: $viewModel.showNoteList) {
                    EmptyView()
                }
                
                Text("Input user name")
                TextField("Username", text: $viewModel.userName)
                    .padding()
                    .frame(width: 300, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                
                Button("Login") {
                    Task {
                        await viewModel.didTapLogin()
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: LoginViewModel(
                userInfoUseCase: UserInfoUseCaseImpl(
                    userInfoRepository: UserInfoRepositoryMock()
                )
            ), loggedInView: {
                EmptyView()
            }
        )
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

private class UserInfoRepositoryMock: UserInfoRepository {
    func fetchUserInfo(userName: String) async throws -> UserInfo {
        .init(userName: "1", notes: [])
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        .init(userName: "1", notes: [])
    }
}
