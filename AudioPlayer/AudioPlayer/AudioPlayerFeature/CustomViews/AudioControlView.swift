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
    
    let isPlaying: Bool
    let isNextEnabled: Bool
    let isPreviousEnabled: Bool
    let controlAction: (AudioControlAction) -> Void
    
    var body: some View {
        HStack(spacing: .buttonsSpacing) {
            
            button(for: .nextAudio(.previous))
                .disabled(!isPreviousEnabled)
                .opacity(isPreviousEnabled ? 1 : .disabledOpacity)
            
            button(for: .rewind)
            button(for: .playToggle)
            button(for: .fastForward)
            
            button(for: .nextAudio(.next))
                .disabled(!isNextEnabled)
                .opacity(isNextEnabled ? 1 : .disabledOpacity)
        }
        .foregroundStyle(.black)
        .padding(.audioControlViewEdgeInsets)
        
    }
    
}

private extension AudioControlView {
    
    func button(for action: AudioControlAction) -> some View {
        Button {
            controlAction(action)
        } label: {
            image(for: action)
        }
    }
    
    func image(for action: AudioControlAction) -> some View {
        let systemName: String
        switch action {
        case .playToggle:
            systemName = isPlaying ? "pause.fill" : "play.fill"
        case .fastForward:
            systemName = "goforward.10"
        case .rewind:
            systemName = "gobackward.5"
        case .nextAudio(let type):
            systemName = type == .next ? "forward.end.fill" : "backward.end.fill"
        }
        
        return Image(systemName: systemName)
            .resizable()
            .frame(width: .defaultIconSide, height: .defaultIconSide)
    }
    
}

#Preview {
    AudioControlView(isPlaying: true, isNextEnabled: true, isPreviousEnabled: false) { _ in }
}
