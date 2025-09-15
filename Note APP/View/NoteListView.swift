//
//  NoteListView.swift
//  Note APP
//
//  Created by Apple on 9/15/25.
//
import SwiftUI
import SwiftData

struct NotesListView: View {
    @Environment(\.modelContext) private var context
    @Bindable var folder: Folder

    var body: some View {
        // List All Notes
        VStack(spacing: 0){
            List {
                ForEach(folder.notes) { note in
                    NavigationLink(destination: NoteEditorView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title).bold()
                            Text(note.content).lineLimit(1).foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete { indices in
                    indices.forEach {
                        let note = folder.notes[$0]
                        context.delete(note)
                    }
                    try? context.save()
                }
            }
            .navigationTitle(folder.name)
            HStack {
                Spacer()
                Text("\(folder.notes.count) Notes")
                    .foregroundStyle(.gray)
                Spacer()
                Button {
                    // create new note and attach to this folder
                    let newNote = Note(title: "Untitled", content: "")
                    context.insert(newNote)
                    folder.notes.append(newNote)
                    try? context.save()
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
}

#Preview {
    ContentView()
        .modelContainer(for: [Folder.self, Note.self], inMemory: true)
}
