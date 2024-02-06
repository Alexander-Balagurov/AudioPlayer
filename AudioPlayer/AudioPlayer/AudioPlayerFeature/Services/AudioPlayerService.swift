//
//  AudioPlayerService.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 04.02.2024.
//

import AVFoundation
import Dependencies

struct AudioPlayerServiceInterface {

    var prepareToPlay: (URL) -> Void
    var pause: () -> Void
    var play: () -> Void
    var fastForward: () -> Void
    var rewind: () -> Void
    var seek: (TimeInterval) -> Void
    var trackDuration: () -> TimeInterval
    var currentProgress: () -> Double
    var updateRate: (PlaybackSpeedType) -> Void
    var playbackSpeed: () -> Float
    
}

final class AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    init() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Error configuring session: \(error.localizedDescription)")
        }
    }
    
    deinit {
        try? AVAudioSession.sharedInstance().setActive(false)
    }
    
    func prepareToPlay(trackURL: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: trackURL)
            player?.enableRate = true
            player?.prepareToPlay()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func fastForward() {
        guard let player else { return }
        player.currentTime = min(player.currentTime + 10, trackDuration() - 0.1)
    }

    func rewind() {
        player?.currentTime -= 5
    }
    
    func seek(to progress: TimeInterval) {
        player?.currentTime = trackDuration() * progress - 0.1
    }
    
    func trackDuration() -> TimeInterval {
        player?.duration ?? 0
    }
    
    func currentProgress() -> Double {
        guard let player else { return 0 }
        
        return player.currentTime / player.duration
    }
    
    func updateRate(type: PlaybackSpeedType) {
        player?.rate = type.rawValue
    }
    
    func playbackSpeed() -> Float {
        player?.rate ?? 1
    }
    
}

extension AudioPlayerServiceInterface: DependencyKey {
    
    static var liveValue: AudioPlayerServiceInterface {
        let player = AudioPlayerService()
        return AudioPlayerServiceInterface(
            prepareToPlay: player.prepareToPlay(trackURL:),
            pause: player.pause,
            play: player.play,
            fastForward: player.fastForward,
            rewind: player.rewind,
            seek: player.seek(to:),
            trackDuration: player.trackDuration,
            currentProgress: player.currentProgress,
            updateRate: player.updateRate(type:),
            playbackSpeed: player.playbackSpeed
        )
    }
    
    //TODO: Fill here accordingly to mock test values
    static var testValue: AudioPlayerServiceInterface {
        return AudioPlayerServiceInterface(
            prepareToPlay: { _ in },
            pause: {},
            play: {},
            fastForward: {},
            rewind: {},
            seek: { _ in },
            trackDuration: { 10 },
            currentProgress: { 0.5 },
            updateRate: { _ in },
            playbackSpeed: { 1 }
        )
    }
    
}

extension DependencyValues {
    
    var audioPlayerService: AudioPlayerServiceInterface {
        get { self[AudioPlayerServiceInterface.self] }
        set { self[AudioPlayerServiceInterface.self] = newValue }
    }
    
}
