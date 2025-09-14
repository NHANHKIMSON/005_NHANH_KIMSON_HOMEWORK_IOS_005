import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Folder.name) private var folders: [Folder]
    var body: some View {
        NavigationStack {
            // List All Folder
            VStack(spacing: 0){
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
                .background(.ultraThinMaterial)
                .overlay(Divider(), alignment: .top)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
                }
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [Folder.self, Note.self], inMemory: true)
}
