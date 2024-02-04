//
//  AudioPlayerFeature.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import ComposableArchitecture

@Reducer
struct AudioPlayerFeature {
        
    struct State: Equatable {
        let book: Book
        var currentChapter: Chapter
        var isPlaying = false
        
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
    }
    
    @Dependency(\.audioPlayerService) var audioPlayerService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                audioPlayerService.prepareToPlay(state.currentChapter.audioURL)
                return .none
            case .playButtonToggled:
                state.isPlaying ? audioPlayerService.pause() : audioPlayerService.play()
                state.isPlaying.toggle()
                return .none
            case .nextChapterButtonTapped:
                return .none

            case .previousChapterButtonTapped:
                return .none

            case .fastForwardButtonTapped:
                return .none

            case .rewindButtonTapped:
                return .none
            }
        }
    }
}
