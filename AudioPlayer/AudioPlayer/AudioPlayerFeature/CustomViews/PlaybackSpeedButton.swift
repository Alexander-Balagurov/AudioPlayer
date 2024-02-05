//
//  PlaybackSpeedButton.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI

enum PlaybackSpeedType: Float, CaseIterable {
    
    case x05 = 0.5
    case x075 = 0.75
    case x1 = 1
    case x125 = 1.25
    case x15 = 1.5
    case x2 = 2
    
    var title: String {
        "\(rawValue)x speed"
    }
    
    mutating func nextSpeed() {
        guard let index = PlaybackSpeedType.allCases.firstIndex(of: self),
              index + 1 < PlaybackSpeedType.allCases.count else {
            self = .x05
            return
        }
        self = PlaybackSpeedType.allCases[index + 1]
    }
    
}

struct PlaybackSpeedButton: View {
    
    let type: PlaybackSpeedType
    let onPlaybackSpeedButtonTap: () -> Void
    
    var body: some View {
        Button {
            onPlaybackSpeedButtonTap()
        } label: {
            Text(type.title)
                .foregroundStyle(.black)
        }
        .buttonStyle(.bordered)
    }
    
}

#Preview {
    PlaybackSpeedButton(type: .x1) {}
}
