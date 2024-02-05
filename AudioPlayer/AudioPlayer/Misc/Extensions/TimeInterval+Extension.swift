//
//  TimeInterval+Extension.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import Foundation

extension TimeInterval {
    
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        
        return String(format: "%2d:%0.2d", minutes, seconds)
        
    }
    
}
