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

struct Book: Equatable {
    
    let id: UUID
    let imageURL: URL
    let chapters: [Chapter]
    
}

struct Chapter: Equatable {
    
    let id: UUID
    let index: Int
    let title: String
    let audioURL: URL
    
}

extension Book {
    
    static let mockBook: Self = .init(
        id: .init(),
        imageURL: .bookCover,
        chapters: .mockChapters
    )
    
    func nextChapter(currentIndex: Int, type: AudioControlAction.NextAudioType) -> Chapter? {
        let nextChapterIndex: Int
        switch type {
        case .next:
            nextChapterIndex = min(currentIndex + 1, chapters.count)
        case .previous:
            nextChapterIndex = max(currentIndex - 1, 1)
        }
        let nextChapter = chapters.first { $0.index == nextChapterIndex }
        
        return nextChapter
    }
    
}

private extension Array {
    
    static var mockChapters: [Chapter] {
        var chapters: [Chapter] = []
        for i in 1...19 {
            guard let audioURL = Bundle.main.url(forResource: "\(i)_audio", withExtension: "mp3") else {
                print("Audio file not found.")
                continue
            }
            chapters.append(.init(id: .init(), index: i, title: "\(i) title", audioURL: audioURL))
        }
        
        return chapters
    }
    
}
