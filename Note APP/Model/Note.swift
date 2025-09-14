//
//  Note.swift
//  Note APP
//
//  Created by Apple on 9/14/25.
//
import SwiftData
import Foundation

@Model
final class Note {
    var title: String
    var content: String
    var createdAt: Date

    init(title: String, content: String, createdAt: Date = .now) {
        self.title = title
        self.content = content
        self.createdAt = createdAt
    }
}
