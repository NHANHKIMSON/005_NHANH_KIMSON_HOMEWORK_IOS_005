//
//  FolderListView.swift
//  Note APP
//
//  Created by Apple on 9/15/25.
//

import SwiftUI
import SwiftData

struct FolderListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Folder.name) private var folders: [Folder]

    var body: some View {
        NavigationStack {
            List {
                ForEach(folders) { folder in
                    NavigationLink(destination: NotesListView(folder: folder)) {
                        HStack {
                            Image(systemName: "folder")
                            Text(folder.name)
                            Spacer()
                            Text("\(folder.notes.count)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete { indices in
                    indices.forEach { context.delete(folders[$0]) }
                    try? context.save()
                }
            }
            .navigationTitle("Folders")
            HStack {
                Button {
                    let folder = Folder(name: "New Folder")
                    context.insert(folder)
                    try? context.save()
                } label: {
                    Image(systemName: "folder.badge.plus")
                        .font(.title2)
                        .foregroundColor(.yellow)
                }
                
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
            .background(.ultraThinMaterial) // blurred like iOS
            .overlay(Divider(), alignment: .top)
            
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { EditButton() } }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    // Add folder
                    Button {
                        let newFolder = Folder(name: "New Folder")
                        context.insert(newFolder)
                        try? context.save()
                    } label: {
                        Image(systemName: "folder.badge.plus")
                            .font(.system(size: 22))
                    }

                    Spacer()

                    // Quick note: attach to first folder (or create one if none)
                    Button {
                        if let first = folders.first {
                            let note = Note(title: "New Note", content: "")
                            context.insert(note)
                            first.notes.append(note)          // attach
                        } else {
                            let folder = Folder(name: "Quick Notes")
                            context.insert(folder)
                            let note = Note(title: "New Note", content: "")
                            context.insert(note)
                            folder.notes.append(note)
                        }
                        try? context.save()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 22))
                    }
                }
                .padding()
                .background(.thinMaterial)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Folder.self, Note.self], inMemory: true)
}
