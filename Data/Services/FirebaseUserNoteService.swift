//
//  FirebaseUserNoteService.swift
//  Data
//
//  Created by Dai Tran on 07/08/2023.
//

import Foundation
import Domain
import FirebaseDatabase
import FirebaseDatabaseSwift

public final class FirebaseUserNoteService: UserNoteService {
    private let databaseRef: DatabaseReference
    
    public init(databaseRef: DatabaseReference) {
        self.databaseRef = databaseRef
    }
    
    public func createNote(userName: String, noteContent: String) async throws -> [UserNote] {
        var notes = try await fetchNotes(userName: userName)
        let newNote = UserNote(id: String(notes.count + 1), content: noteContent)
        notes.append(newNote)
        return try await saveNotes(notes: notes, userName: userName)
    }
    
    public func updateNote(userName: String, note: UserNote) async throws -> [UserNote] {
        var notes = try await fetchNotes(userName: userName)
        guard let existingNoteIndex = notes.firstIndex(where: { $0.id == note.id }) else {
            throw NSError(domain: "Update note error", code: 0)
        }
        notes[existingNoteIndex] = note
        return notes
    }
    
    public func deleteNote(userName: String, note: UserNote) async throws -> [UserNote] {
        var notes = try await fetchNotes(userName: userName)
        guard let existingNoteIndex = notes.firstIndex(where: { $0.id == note.id }) else {
            throw NSError(domain: "Delete note error", code: 0)
        }
        notes.remove(at: existingNoteIndex)
        return notes
    }
    
    public func fetchNotes(userName: String) async throws -> [UserNote] {
        try await withCheckedThrowingContinuation { continuation in
            databaseRef.child(userName).child("notes").getData { error, snapshot in
                if let error {
                    continuation.resume(throwing: error)
                }
                
                guard let dictionaries = snapshot?.value as? [NSDictionary] else {
                    continuation.resume(returning: [])
                    return
                }
                let notes = dictionaries.compactMap { UserNote(dictionary: $0) }
                continuation.resume(returning: notes)
            }
        }
    }
    
    private func saveNotes(notes: [UserNote], userName: String) async throws -> [UserNote] {
        do {
            try await databaseRef.child(userName).child("notes").setValue(notes)
            return notes
        } catch {
           throw error
        }
    }
}
