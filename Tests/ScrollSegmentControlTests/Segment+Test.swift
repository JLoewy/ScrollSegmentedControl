//
//  Segmente+Test.swift
//  ScrollSegmentControl
//
//  Created by Jason Loewy on 10/5/24.
//

import XCTest

@testable import ScrollSegmentControl

final class Segment_Test: XCTestCase {
    
    
    func testInitializationWithTitle() {
        let segment = Segment(title: "Test Segment")
        XCTAssertEqual(segment.title, "Test Segment")
        XCTAssertNil(segment.object)
    }
    
    func testInitializationWithTitleAndObject() {
        let object = "Sample Object"
        let segment = Segment(title: "Test Segment", object: object)
        XCTAssertEqual(segment.title, "Test Segment")
        XCTAssertEqual(segment.object as? String, object)
    }
    
    func testIdIsEqualToTitle() {
        let segment = Segment(title: "Test Segment")
        XCTAssertEqual(segment.id, "Test Segment")
    }
    
    func testEquatableWithEqualSegments() {
        let segment1 = Segment(title: "Test Segment")
        let segment2 = Segment(title: "Test Segment")
        XCTAssertEqual(segment1, segment2)
    }
    
    func testEquatableWithDifferentSegments() {
        let segment1 = Segment(title: "Segment One")
        let segment2 = Segment(title: "Segment Two")
        XCTAssertNotEqual(segment1, segment2)
    }
    
    func testEquatableWithDifferentObjectsButSameTitle() {
        let segment1 = Segment(title: "Test Segment", object: "Object 1")
        let segment2 = Segment(title: "Test Segment", object: "Object 2")
        XCTAssertEqual(segment1, segment2)
    }
}
