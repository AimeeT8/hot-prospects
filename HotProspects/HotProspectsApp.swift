//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Aimee Temple on 2024-07-20.
//
import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
