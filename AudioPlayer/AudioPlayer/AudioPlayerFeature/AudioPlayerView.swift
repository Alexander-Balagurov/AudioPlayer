//
//  AudioPlayerView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI
import ComposableArchitecture

struct AudioPlayerView: View {
    
    let store: StoreOf<AudioPlayerFeature>
    @State var progress: Double = 0
    @State var playbackSpeedType: PlaybackSpeedType = .x1
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                AsyncImage(url: viewStore.book.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                
                Text(viewStore.currentChapter.title)
                    .font(.headline)
                
                AudioSliderView(duration: 180, value: $progress)
                
                PlaybackSpeedButton(type: $playbackSpeedType)
                
                AudioControlView(isPlaying: viewStore.state.isPlaying) { action in
                    self.handleAudioControlAction(viewStore: viewStore, action: action)
                }
                
                Spacer(minLength: 50)
            }
            .padding()
            .background(Color.mint.opacity(0.1))
            .onAppear {
                viewStore.send(.viewAppeared)
            }
        }
    }
    
    func handleAudioControlAction(
        viewStore: ViewStore<AudioPlayerFeature.State, AudioPlayerFeature.Action>,
        action: AudioControlAction
    ) {
        switch action {
        case .playToggle:
            print(Unmanaged.passUnretained(viewStore).toOpaque())
            viewStore.send(.playButtonToggled)
        case .fastForward:
            break
        case .rewind:
            break
        case .nextAudio:
            break
        case .previousAudio:
            break
        }
    }
}

#Preview {
    AudioPlayerView(store: Store(initialState: AudioPlayerFeature.State()) {
        AudioPlayerFeature()
    })
}
