//
//  AppFeature.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    
    struct State: Equatable {
        
        var audioPlayerTab = AudioPlayerFeature.State()
    }
    
    enum Action {
        case audioPlayerTab(AudioPlayerFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.audioPlayerTab, action: \.audioPlayerTab) {
            AudioPlayerFeature()
        }

        Reduce { state, action in
            .none
        }
    }
    
}
