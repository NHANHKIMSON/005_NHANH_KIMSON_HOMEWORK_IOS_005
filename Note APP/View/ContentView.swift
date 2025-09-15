import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Folder.name) private var folders: [Folder]
    @State var search: String = ""
    @State var GoToPage2: Bool = false
    var body: some View {
        NavigationStack {
            // List All Folder
            VStack(spacing: 0){
                List {
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $search)
                    }
                    .listRowBackground(Color(UIColor.lightGray).opacity(0.34))
                    Section(header: Text("")) {
                        ForEach(folders) { folder in
                            if folder.name != "Notes" {
                                NavigationLink(destination: NotesListView(folder: folder)) {
                                    HStack {
                                        Image(systemName: folder.name == "Notes" ? "folder" : "calendar")
                                            .foregroundStyle(.blue)
                                        Text(folder.name)
                                        Spacer()
                                        Text("\(folder.notes.count)")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .onDelete { indices in
                            indices.forEach { context.delete(folders[$0]) }
                            try? context.save()
                        }
                    }
                    
                    Section(header: Text("ICLOUD")) {
                        ForEach(folders) { folder in
                            if folder.name == "Notes"{
                                NavigationLink(destination: NotesListView(folder: folder)) {
                                    HStack {
                                        Image(systemName: folder.name == "Notes" ? "folder" : "calendar")
                                            .foregroundStyle(.blue)
                                        Text(folder.name)
                                        Spacer()
                                        Text("\(folder.notes.count)")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .onDelete { indices in
                            indices.forEach { context.delete(folders[$0]) }
                            try? context.save()
                        }
                    }
                    
                }
                .navigationTitle("Folders")
                .task {
                            if folders.isEmpty {
                                context.insert(Folder(name: "Notes"))
                                context.insert(Folder(name: "Quick Notes"))
                                try? context.save()
                            }
                        }
                
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
                        GoToPage2 = true
                        
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
