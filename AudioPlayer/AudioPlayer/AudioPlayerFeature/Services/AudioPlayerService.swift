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
    var trackDuration: () -> TimeInterval?
    var seek: (Float) -> Void
    
}


final class AudioPlayerService: NSObject {
    
    private var player: AVAudioPlayer?
    
    var currentPlaybackTime: TimeInterval {
        player?.currentTime ?? 0
    }
    
    override init() {
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
        print(#function)
        do {
            player = try AVAudioPlayer(contentsOf: trackURL)
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
        player?.currentTime += 10
    }

    func rewind() {
        player?.currentTime -= 5
    }
    
    func trackDuration() -> TimeInterval? {
        player?.duration
    }
    
    func seek(to progress: Float) {
        guard let duration = trackDuration() else { return }
        
        let timeToSeek = duration * Double(progress)
        player?.currentTime = timeToSeek
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
            trackDuration: player.trackDuration,
            seek: player.seek(to:)
        )
    }
    
}

extension DependencyValues {
    
    var audioPlayerService: AudioPlayerServiceInterface {
        get { self[AudioPlayerServiceInterface.self] }
        set { self[AudioPlayerServiceInterface.self] = newValue }
    }
    
}
