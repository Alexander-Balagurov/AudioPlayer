//
//  AppView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import ComposableArchitecture
import SwiftUI

private extension String {
    static let audioPlayerTab = "Player"
}

struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            AudioPlayerView(book: .mockBook)
                .tabItem {
                    Text(verbatim: .audioPlayerTab)
                }
        }
    }
}

#Preview {
    AppView(
        store: Store(initialState: AppFeature.State()) {
            AppFeature()
        }
    )
}
