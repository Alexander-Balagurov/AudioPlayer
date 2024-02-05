//
//  AudioControlView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 04.02.2024.
//

import SwiftUI

private extension EdgeInsets {
    
    static let audioControlViewEdgeInsets = EdgeInsets(
        top: UIDimension.defaultMargin8x,
        leading: UIDimension.defaultMargin4x,
        bottom: UIDimension.defaultMargin8x,
        trailing: UIDimension.defaultMargin4x
    )
    
}

private extension Double {
    static let disabledOpacity = 0.2
}

private extension CGFloat {
    
    static let buttonsSpacing: CGFloat = UIDimension.defaultMargin7x
    static let defaultIconSide: CGFloat = UIDimension.defaultMargin8x
    
}

enum AudioControlAction {
    
    case playToggle
    case fastForward
    case rewind
    case nextAudio(NextAudioType)
    
    enum NextAudioType {
        
        case next
        case previous
        
    }
    
}

struct AudioControlView: View {
    
    var isPlaying: Bool
    let isNextEnabled: Bool
    let isPreviousEnabled: Bool
    let controlAction: (AudioControlAction) -> Void
    
    var body: some View {
        HStack(spacing: .buttonsSpacing) {
            Button {
                controlAction(.nextAudio(.previous))
            } label: {
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .frame(width: .defaultIconSide, height: .defaultIconSide)
            }
            .disabled(!isPreviousEnabled)
            .opacity(isPreviousEnabled ? 1 : .disabledOpacity)
            
            Button {
                controlAction(.rewind)
            } label: {
                Image(systemName: "gobackward.5")
                    .resizable()
                    .frame(width: .defaultIconSide, height: .defaultIconSide)
            }
            
            Button {
                controlAction(.playToggle)
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: .defaultIconSide, height: .defaultIconSide)
            }
            
            Button {
                controlAction(.fastForward)
            } label: {
                Image(systemName: "goforward.10")
                    .resizable()
                    .frame(width: .defaultIconSide, height: .defaultIconSide)
            }
            
            Button {
                controlAction(.nextAudio(.next))
            } label: {
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .frame(width: .defaultIconSide, height: .defaultIconSide)
            }
            .disabled(!isNextEnabled)
            .opacity(isNextEnabled ? 1 : .disabledOpacity)
        }
        .foregroundStyle(.black)
        .padding(.audioControlViewEdgeInsets)
    }
    
}

#Preview {
    AudioControlView(isPlaying: true, isNextEnabled: true, isPreviousEnabled: false) { _ in }
}
