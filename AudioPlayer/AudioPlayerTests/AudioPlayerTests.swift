//
//  AudioPlayerTests.swift
//  AudioPlayerTests
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import ComposableArchitecture
import XCTest
@testable import AudioPlayer

@MainActor
final class AudioPlayerTests: XCTestCase {

    func testFirstPlayAndPause() async {
        let clock = TestClock()
        let store = TestStore(initialState: AudioPlayerFeature.State()) {
            AudioPlayerFeature()
        } withDependencies: {
            $0.audioPlayerService = .testValue
            $0.continuousClock = clock
        }
        
        await store.send(.viewAppeared) {
            $0.duration = 10
        }
        await store.send(.playButtonToggled) {
            $0.isPlaying = true
        }
        await clock.advance(by: .milliseconds(500))
        await store.receive(\.timerTick) {
            $0.progress = 0.5
        }
        await store.send(.playButtonToggled) {
            $0.isPlaying = false
        }
    }
    
    func testNextChapterTapped() async {
        let clock = TestClock()
        let store = TestStore(initialState: AudioPlayerFeature.State()) {
            AudioPlayerFeature()
        } withDependencies: {
            $0.audioPlayerService = .testValue
            $0.continuousClock = clock
        }
        
        await store.send(.nextChapterButtonTapped(.next)) {
            let nextChapter = $0.book.nextChapter(currentIndex: $0.currentChapter.index, type: .next)
            $0.currentChapter = nextChapter!
            $0.duration = 10
            $0.isPlaying = !$0.isPlaying
        }
        await store.receive(\.playButtonToggled) {
            $0.isPlaying = !$0.isPlaying
        }
    }

}
