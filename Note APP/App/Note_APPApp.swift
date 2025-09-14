//
//  Note_APPApp.swift
//  Note APP
//
//  Created by Apple on 9/14/25.
//

import SwiftUI
import SwiftData
@main
struct Note_APPApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Folder.self, Note.self])
    }
}
