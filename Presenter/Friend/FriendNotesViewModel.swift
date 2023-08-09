//
//  FriendNotesViewModel.swift
//  Presenter
//
//  Created by Dai Tran on 8/8/23.
//

import Domain
import Combine
import Foundation

public protocol FriendNotesViewModelType: ObservableObject {
    var notes: [UserNote] { get set }
    var username: String { get set }
    func fetchUserNotes() async
}

public final class FriendNotesViewModel: FriendNotesViewModelType {
    private let userNoteUseCase: UserNoteUseCase
    @Published public var notes: [UserNote] = []
    @Published public var username: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    public init(userNoteUseCase: UserNoteUseCase) {
        self.userNoteUseCase = userNoteUseCase
        
        setupObservation()
    }
    
    public func fetchUserNotes() async {
        do {
            let fetchNotes = try await userNoteUseCase.fetchNotes(userName: username)
            await MainActor.run {
                notes = fetchNotes
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func setupObservation() {
        $username
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .drop(while: { $0.isEmpty })
            .sink(receiveValue: { [weak self] value in
                let fetchUserNote = self?.fetchUserNotes
                Task {
                    await fetchUserNote?()
                }
            })
            .store(in: &subscriptions)
    }
}
