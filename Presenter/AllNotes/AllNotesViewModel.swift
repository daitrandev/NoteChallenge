//
//  AllNotesViewModel.swift
//  Presenter
//
//  Created by Dai Tran on 8/8/23.
//

import Domain
import Combine
import Foundation

public protocol FriendNotesViewModelType: ObservableObject {
    var users: [UserInfo] { get set }
    func fetchUsers() async
}

public final class AllNotesViewModel: FriendNotesViewModelType {
    private let userInfoUseCase: UserInfoUseCase
    @Published public var users: [UserInfo] = []
        
    public init(userInfoUseCase: UserInfoUseCase) {
        self.userInfoUseCase = userInfoUseCase
    }
    
    public func fetchUsers() async {
        do {
            let fetchedUsers = try await userInfoUseCase.fetchAllUsers()
            await MainActor.run {
                users = fetchedUsers
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
