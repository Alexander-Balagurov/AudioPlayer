//
//  AudioSliderView.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import SwiftUI

struct AudioSliderView: View {
    
    let duration: TimeInterval
    @State var currentProgress: TimeInterval = 0
    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text(currentProgress.stringFromTimeInterval())
            Slider(value: $value) { changed in
                currentProgress = value * duration
            }
            Text(duration.stringFromTimeInterval())
        }
        .padding()
    }
    
}

#Preview {
    return AudioSliderView(duration: 180, value: .constant(0.3))
}
