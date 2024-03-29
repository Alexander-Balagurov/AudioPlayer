//
//  AudioSliderView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI

struct AudioSliderView: View {
    
    let duration: TimeInterval
    @Binding var currentProgress: TimeInterval
    
    var body: some View {
        HStack {
            Text((duration * currentProgress).stringFromTimeInterval())
                .foregroundStyle(Color.textColor)
                .monospacedDigit()
            Slider(value: $currentProgress)
            Text(duration.stringFromTimeInterval())
                .foregroundStyle(Color.textColor)
                .monospacedDigit()
        }
        .padding()
    }
    
}

#Preview {
    return AudioSliderView(duration: 180, currentProgress: .constant(0))
}
