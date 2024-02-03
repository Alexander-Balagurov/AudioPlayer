//
//  Book.swift
//  AudioPlayer
//
//  Created by Alexander Balagurov on 03.02.2024.
//

import Foundation

private extension URL {
    static let bookCover: Self = .init(string: "https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781607102113/the-adventures-of-sherlock-holmes-and-other-stories-9781607102113_hr.jpg")!
}

struct Book {
    
    let imageURL: URL
    let chapters: [Chapter]
    
}

struct Chapter {
    
    let title: String
    let audioURL: URL
    
}

extension Book {
    
    static let mockBook: Self = .init(
        imageURL: .bookCover,
        chapters: .mockChapters
    )
    
}

private extension Array {
    
    static var mockChapters: [Chapter] {
        var chapters: [Chapter] = []
        for i in 1...5 {
            guard let audioURL = Bundle.main.url(forResource: "0\(i)_audio", withExtension: "m4a") else {
                print("Audio file not found.")
                continue
            }
            print(audioURL)
            chapters.append(.init(title: "\(i) title", audioURL: audioURL))
        }
        
        return chapters
    }
    
}
