//
//  AudioControlView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 04.02.2024.
//

import SwiftUI

private extension EdgeInsets {
    static let audioControlViewEdgeInsets = EdgeInsets(top: 32, leading: 16, bottom: 32, trailing: 16)
}

enum AudioControlAction {
    
    case playToggle
    case fastForward
    case rewind
    case nextAudio
    case previousAudio
    
}

struct AudioControlView: View {
    
    var isPlaying: Bool
    let controlAction: (AudioControlAction) -> Void
    
    var body: some View {
        HStack(spacing: 28) {
            Button {
                controlAction(.previousAudio)
            } label: {
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            
            Button {
                controlAction(.rewind)
            } label: {
                Image(systemName: "gobackward.5")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            
            Button {
                controlAction(.playToggle)
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            
            Button {
                controlAction(.fastForward)
            } label: {
                Image(systemName: "goforward.10")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            
            Button {
                controlAction(.nextAudio)
            } label: {
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        }
        .foregroundStyle(.black)
        .padding(.audioControlViewEdgeInsets)
    }
    
}

#Preview {
    AudioControlView(isPlaying: true, controlAction: { _ in })
}
