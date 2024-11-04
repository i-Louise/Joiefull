//
//  LikeTests.swift
//  JoiefullTests
//
//  Created by Louise Ta on 05/11/2024.
//

import Foundation
import XCTest
@testable import Joiefull

final class LikeTests: XCTestCase {
    
    // Given a not liked state, When toggling like, Then ensure correct behaviour
    func test_toggleLike_notLiked() {
        // Given
        let like = Like(likes: 42, isLiked: false)
        // When
        like.toggleLike()
        // Then
        XCTAssertEqual(like.totalLikes, 43)
        XCTAssertTrue(like.isLiked)
    }
    
    // Given a liked state, When toggling like, Then ensure correct behaviour
    func test_toggleLike_liked() {
        // Given
        let like = Like(likes: 42, isLiked: true)
        // When
        like.toggleLike()
        // Then
        XCTAssertEqual(like.totalLikes, 41)
        XCTAssertFalse(like.isLiked)
    }
    
    // Given a not liked state, When toggling like twice, Then ensure state remains the same
    func test_toggleLikeTwice_notLiked() {
        // Given
        let like = Like(likes: 42, isLiked: false)
        // When
        like.toggleLike()
        like.toggleLike()
        // Then
        XCTAssertEqual(like.totalLikes, 42)
        XCTAssertFalse(like.isLiked)
    }
    
    // Given a liked state, When toggling like twice, Then ensure state remains the same
    func test_toggleLikeTwice_liked() {
        // Given
        let like = Like(likes: 42, isLiked: true)
        // When
        like.toggleLike()
        like.toggleLike()
        // Then
        XCTAssertEqual(like.totalLikes, 42)
        XCTAssertTrue(like.isLiked)
    }
}
