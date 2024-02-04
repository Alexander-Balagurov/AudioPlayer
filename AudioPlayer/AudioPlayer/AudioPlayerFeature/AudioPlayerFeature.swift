//
//  AudioPlayerFeature.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AudioPlayerFeature {
    
    @ObservableState
    struct State: Equatable {
        let book: Book
        var currentChapter: Chapter
        var isPlaying = false
        var progress: Double = 0
        var duration: TimeInterval = 0
        var playbackSpeedType: PlaybackSpeedType = .x1
        
        init(with book: Book = .mockBook, currentChapter: Chapter? = nil) {
            self.book = book
            self.currentChapter = currentChapter ?? book.chapters.first!
        }
    }
    
    enum Action {
        case viewAppeared
        case playButtonToggled
        case nextChapterButtonTapped
        case previousChapterButtonTapped
        case fastForwardButtonTapped
        case rewindButtonTapped
        case sliderValueChanged(TimeInterval)
        case playbackSpeedChanged
        case timerTick
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.audioPlayerService) var audioPlayerService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                audioPlayerService.prepareToPlay(state.currentChapter.audioURL)
                state.duration = audioPlayerService.trackDuration()
                return .none
            case .playButtonToggled:
                state.isPlaying ? audioPlayerService.pause() : audioPlayerService.play()
                state.isPlaying.toggle()
                
                if state.isPlaying {
                    return .run { send in
                        for await _ in clock.timer(interval: .milliseconds(500)) {
                            await send(.timerTick)
                            try await Task.sleep(for: .milliseconds(500))
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {
                    return .cancel(id: CancelID.timer)
                }
            case .nextChapterButtonTapped:
                return .none

            case .previousChapterButtonTapped:
                return .none

            case .fastForwardButtonTapped:
                audioPlayerService.fastForward()
                state.progress = audioPlayerService.currentProgress()
                return .none
            case .rewindButtonTapped:
                audioPlayerService.rewind()
                state.progress = audioPlayerService.currentProgress()
                return .none
            case .sliderValueChanged(let value):
                audioPlayerService.seek(value)
                state.progress = audioPlayerService.currentProgress()
                return .none
            case .playbackSpeedChanged:
                state.playbackSpeedType.nextSpeed()
                audioPlayerService.updateRate(state.playbackSpeedType)
                return .none
            case .timerTick:
                state.progress = audioPlayerService.currentProgress()
                return .none
            }
        }
    }
}
