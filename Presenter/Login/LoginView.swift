//
//  LoginView.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import SwiftUI

public struct LoginView<T: LoginViewModelType, V: View>: View {
    private let loggedInView: (() -> V)
    
    @ObservedObject var viewModel: T
    
    public init(viewModel: T, loggedInView: @escaping (() -> V)) {
        self.viewModel = viewModel
        self.loggedInView = loggedInView
    }
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                NavigationLink(
                    destination: ZStack {
                        if viewModel.showNoteList {
                            loggedInView().environmentObject(viewModel.loggedInUser)
                        }
                    },
                    isActive: $viewModel.showNoteList) {
                        EmptyView()
                    }

                TextField("Username", text: $viewModel.userName)
                    .padding()
                    .frame(width: 300, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                
                Button("Login") {
                    Task {
                        do {
                            try await viewModel.didTapLogin()
                        } catch {
                            debugPrint(error.localizedDescription)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Log In")
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
    
    func fetchAllUsers() async throws -> [UserInfo] {
        []
    }
}

private class UserInfoRepositoryMock: UserInfoRepository {
    func fetchAllUsers() async throws -> [UserInfo] {
        []
    }
    
    func fetchUserInfo(userName: String) async throws -> UserInfo {
        .init(userName: "1", notes: [])
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        .init(userName: "1", notes: [])
    }
}
