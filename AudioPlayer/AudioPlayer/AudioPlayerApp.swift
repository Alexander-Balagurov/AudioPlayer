//
//  AudioPlayerApp.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct AudioPlayerApp: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: AudioPlayerApp.store)
        }
    }
}
