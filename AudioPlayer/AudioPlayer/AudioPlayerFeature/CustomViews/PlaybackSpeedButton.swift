//
//  PlaybackSpeedButton.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI

enum PlaybackSpeedType: Int, CaseIterable {
    
    case x05
    case x075
    case x1
    case x125
    case x15
    case x2
    
    var title: String {
        "\(rateValue)x speed"
    }
    
    var rateValue: Float {
        switch self {
        case .x05:
            return 0.5
        case .x075:
            return 0.75
        case .x1:
            return 1
        case .x125:
            return 1.25
        case .x15:
            return 1.5
        case .x2:
            return 2
        }
    }
    
    mutating func nextSpeed() {
        self = .init(rawValue: (rawValue + 1) % PlaybackSpeedType.allCases.count) ?? .x1
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
