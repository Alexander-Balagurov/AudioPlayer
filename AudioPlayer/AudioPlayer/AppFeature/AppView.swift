//
//  AppView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import ComposableArchitecture
import SwiftUI

private extension String {
    static let audioPlayerTab = "Audio Player"
    static let audioPlayerImageName = "book.circle.fill"
}

struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            AudioPlayerView(store: store.scope(state: \.audioPlayerTab, action: \.audioPlayerTab))
                .tabItem {
                    VStack {
                        Image(systemName: .audioPlayerImageName)
                        Text(verbatim: .audioPlayerTab)
                    }
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
