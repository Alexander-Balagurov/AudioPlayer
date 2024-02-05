//
//  AudioPlayerView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI
import ComposableArchitecture

private extension EdgeInsets {
    
    static let chapterTitleEdgeInsets = EdgeInsets(
        top: UIDimension.defaultMargin2x,
        leading: 0,
        bottom: UIDimension.defaultMargin2x,
        trailing: 0
    )
    
}

private extension CGFloat {
    
    static let asyncImageHeightMultiplier: CGFloat = 0.55
    static let spacerHeightMultiplier: CGFloat = 0.2
    
}

private extension String {
    
    static func headerText(index: Int, amount: Int) -> String {
        "Chapter \(index) of \(amount)".uppercased()
    }
    
}

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
                .frame(height: geometry.size.height * .asyncImageHeightMultiplier)
                
                Text(
                    verbatim: .headerText(
                        index: store.currentChapter.index,
                        amount: store.book.chapters.count
                    )
                )
                .font(.footnote)
                
                Text(store.currentChapter.title)
                    .font(.headline)
                    .padding(.chapterTitleEdgeInsets)
                
                AudioSliderView(
                    duration: store.duration,
                    currentProgress: $store.progress.sending(\.sliderValueChanged)
                )
                
                PlaybackSpeedButton(type: store.playbackSpeedType) {
                    self.store.send(.playbackSpeedChanged)
                }
                
                AudioControlView(
                    isPlaying: store.state.isPlaying,
                    isNextEnabled: store.currentChapter.index != store.book.chapters.count,
                    isPreviousEnabled: store.currentChapter.index != 1
                ) { action in
                    self.handleAudioControlAction(action: action)
                }
                
                Spacer(minLength: geometry.size.height * .spacerHeightMultiplier)
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
        case .nextAudio(let type):
            store.send(.nextChapterButtonTapped(type))
        }
    }
    
}

#Preview {
    AudioPlayerView(store: Store(initialState: AudioPlayerFeature.State()) {
        AudioPlayerFeature()
    })
}
