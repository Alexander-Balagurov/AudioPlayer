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
        switch self {
        case .x05:
            return "0.5x speed"
        case .x075:
            return "0.75x speed"
        case .x1:
            return "1x speed"
        case .x125:
            return "1.25x speed"
        case .x15:
            return "1.5x speed"
        case .x2:
            return "2x speed"
        }
    }
    
    mutating func nextSpeed() {
        self = .init(rawValue: (rawValue + 1) % PlaybackSpeedType.allCases.count) ?? .x1
    }
}

struct PlaybackSpeedButton: View {
    
    @Binding var type: PlaybackSpeedType
    
    var body: some View {
        Button {
            type.nextSpeed()
        } label: {
            Text(type.title)
                .foregroundStyle(.black)
        }
        .buttonStyle(.bordered)
    }
    
}

#Preview {
    PlaybackSpeedButton(type: .constant(.x1))
}
