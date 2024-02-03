//
//  AudioPlayerView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI

struct AudioPlayerView: View {
    
    let book: Book
    @State var progress: Double = 0
    @State var playbackSpeedType: PlaybackSpeedType = .x1
    @State var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            AsyncImage(url: book.imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .padding()
            } placeholder: {
                ProgressView()
            }
            
            Text("Book Title")
                .font(.headline)
            
            AudioSliderView(duration: 180, value: $progress)
            
            PlaybackSpeedButton(type: $playbackSpeedType)
            
            AudioControlView(isPlaying: $isPlaying) { action in
                self.handleAudioControlAction(action)
            }
            
            Spacer(minLength: 50)
        }
        .padding()
        .background(Color.mint.opacity(0.1))
    }
    
    func handleAudioControlAction(_ action: AudioControlAction) {
        
    }
}

#Preview {
    AudioPlayerView(book: .mockBook)
}
