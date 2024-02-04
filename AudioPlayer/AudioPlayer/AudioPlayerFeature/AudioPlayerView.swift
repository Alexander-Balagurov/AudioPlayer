//
//  AudioPlayerView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI
import ComposableArchitecture

struct AudioPlayerView: View {
    
    @Perception.Bindable var store: StoreOf<AudioPlayerFeature>
    var body: some View {
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: store.book.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: geometry.size.height * 0.55)
                
                Text(store.currentChapter.title)
                    .font(.headline)
                
                AudioSliderView(
                    duration: store.duration,
                    currentProgress: $store.progress.sending(\.sliderValueChanged)
                )
                
                PlaybackSpeedButton(type: store.playbackSpeedType) {
                    self.store.send(.playbackSpeedChanged)
                }
                
                AudioControlView(isPlaying: store.state.isPlaying) { action in
                    self.handleAudioControlAction(action: action)
                }
                
                Spacer(minLength: geometry.size.height * 0.2)
            }
            .padding()
            .background(Color.mint.opacity(0.1))
            .onAppear {
                store.send(.viewAppeared)
            }
        }
    }
    
    func handleAudioControlAction(action: AudioControlAction) {
        switch action {
        case .playToggle:
            store.send(.playButtonToggled)
        case .fastForward:
            store.send(.fastForwardButtonTapped)
        case .rewind:
            store.send(.rewindButtonTapped)
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
