//
//  NoteEditorView.swift
//  Note APP
//
//  Created by Apple on 9/15/25.
//

import SwiftUI
import SwiftData

struct NoteEditorView: View {
    @Environment(\.modelContext) private var context
    @Bindable var note: Note
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("Title", text: $note.title)
                .font(.title2)
                .padding(.horizontal)
            Divider()
            TextEditor(text: $note.content)
                .padding()
        }
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            try? context.save()
        }
        HStack {
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "square.and.pencil")
                    .font(.title2)
                    .foregroundColor(.yellow)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .overlay(Divider(), alignment: .top)
    }
}
#Preview {
    ContentView()
        .modelContainer(for: [Folder.self, Note.self], inMemory: true)
}
