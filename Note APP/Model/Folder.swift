//
//  Folder.swift
//  Note APP
//
//  Created by Apple on 9/14/25.
//
import SwiftData
import Foundation

@Model
final class Folder {
    var name: String
    @Relationship(deleteRule: .cascade) var notes: [Note] = []
    init(name: String) {
        self.name = name
    }
}
