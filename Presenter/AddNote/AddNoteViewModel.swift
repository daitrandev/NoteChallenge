//
//  AddNoteViewModel.swift
//  Presenter
//
//  Created by Dai Tran on 08/08/2023.
//

import Domain
import Foundation

public protocol AddNoteViewModelType: ObservableObject {
    var note: String { get set }
    func createNote(userName: String) async
}

public final class AddNoteViewModel: AddNoteViewModelType {
    private let userNoteUseCase: UserNoteUseCase
    
    @Published public var note: String = ""
    
    public init(userNoteUseCase: UserNoteUseCase) {
        self.userNoteUseCase = userNoteUseCase
    }
    
    public func createNote(userName: String) async {
        do {
            _ = try await userNoteUseCase.createNote(userName: userName, noteContent: note)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
