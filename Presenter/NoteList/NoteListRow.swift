//
//  NoteListRow.swift
//  Presenter
//
//  Created by Dai Tran on 07/08/2023.
//

import Domain
import Data
import SwiftUI

struct NoteListRow: View {
    private let note: UserNote
    
    init(note: UserNote) {
        self.note = note
    }
    
    var body: some View {
        HStack {
            Text(note.id + ".").font(Font.headline)
            Text(note.content)
        }
    }
}

struct NoteListRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteListRow(note: .init(id: "1", content: "Hello world"))
    }
}
