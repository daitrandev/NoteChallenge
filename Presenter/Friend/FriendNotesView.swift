//
//  FriendNotesView.swift
//  Presenter
//
//  Created by Dai Tran on 8/8/23.
//

import Domain
import SwiftUI

public struct FriendNotesView<T: FriendNotesViewModelType>: View {
    @ObservedObject var viewModel: T
    
    public init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                List(viewModel.users, id: \.userName) { user in
                    Section {
                        ForEach(user.notes, id: \.id) { note in
                            NoteListRow(note: note)
                        }
                    } header: {
                        Text(user.userName)
                    }
                }
            }
            .navigationTitle("All notes")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                Task {
                    await viewModel.fetchUsers()
                }
            }
        }
    }
}

struct FriendNote_Previews: PreviewProvider {
    static var previews: some View {
        FriendNotesView(viewModel: FriendNotesViewModel(userInfoUseCase: UserInfoUseCaseImpl(userInfoRepository: UserInfoRepositoryMock())))
    }
}

private class UserInfoRepositoryMock: UserInfoRepository {
    func fetchAllUsers() async throws -> [Domain.UserInfo] {
        []
    }
    
    func fetchUserInfo(userName: String) async throws -> UserInfo {
        .init()
    }
    
    func createUser(userName: String) async throws -> UserInfo {
        .init()
    }
}
