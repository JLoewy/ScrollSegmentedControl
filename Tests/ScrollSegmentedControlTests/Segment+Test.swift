//
//  Segmente+Test.swift
//  ScrollSegmentControl
//
//  Created by Jason Loewy on 10/5/24.
//

import Testing

@testable import ScrollSegmentedControl

// MARK: - Custom conformer used only for tests
private struct CustomSegment: Segment {
    let title: String
    var object: Any?
    
    var id: String { title }         // distinct stored property → id
}

// MARK: - Test Suite
@Suite("Segment protocol – isEqual(to:) tests")
struct SegmentTests {
    
    private func makeCustom(_ id: String) -> CustomSegment {
        CustomSegment(title: id, object: nil)
    }
    
    // MARK: SegmentItem
    
    @Test("SegmentItem equality – same id, same type")
    func segmentItemEquality() {
        let a = SegmentItem(title: "Home")
        let b = SegmentItem(title: "Home")
        #expect(a.isEqual(to: b))
    }
    
    @Test("SegmentItem inequality – different id")
    func segmentItemInequality() {
        let a = SegmentItem(title: "Home")
        let b = SegmentItem(title: "Profile")
        #expect(!a.isEqual(to: b))
    }
    
    // MARK: CustomSegment
    
    @Test("CustomSegment equality – same id, same type")
    func customSegmentEquality() {
        let a = makeCustom("Library")
        let b = makeCustom("Library")
        #expect(a.isEqual(to: b))
    }
    
    @Test("CustomSegment vs Standard equality – same id, same type")
    func customVsSegmentEquality() {
        let a = makeCustom("Library")
        let b = SegmentItem(title: "Library")
        #expect(!a.isEqual(to: b))
    }
    
    @Test("CustomSegment inequality – different id")
    func customSegmentInequality() {
        let a = makeCustom("Library")
        let b = makeCustom("Search")
        #expect(!a.isEqual(to: b))
    }
    
    // MARK: Cross-type behavior
    
    @Test("Different concrete types with identical id are NOT equal")
    func crossTypeInequality() {
        let item   = SegmentItem(title: "SharedID")
        let custom = makeCustom("SharedID")
        #expect(!item.isEqual(to: custom))
        #expect(!custom.isEqual(to: item))   // symmetry check
    }
    
    // MARK: Object property does not affect isEqual
    
    @Test("`object` differences do NOT influence equality")
    func objectDoesNotAffectEquality() {
        let a = SegmentItem(title: "Settings", object: nil)
        let b = SegmentItem(title: "Settings", object: 12345)     // same id, diff object
        #expect(a.isEqual(to: b)) // still equal
        #expect(b.object != nil)
        #expect((b.object as! Int) == 12345)
    }
}
