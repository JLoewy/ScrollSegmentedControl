//
//  File.swift
//  ScrollSegmentControl
//
//  Created by Jason Loewy on 10/5/24.
//

import XCTest
import SwiftUI

@testable import ScrollSegmentControl

final class SegmentControlStyler_Test: XCTestCase {
    
    func testInitializationWithDefaultStyle() {
        
        let font = Font.system(size: 14)
        let textColor = SegmentControlStylerColor(active: Color.black)
        let activeBarColor = Color.blue
        
        let styler = SegmentControlStyler(font: SegmentControlStylerFont(active: font),
                                          textColor: textColor,
                                          activeBarColor: activeBarColor)
        
        switch styler.style {
            case .underline(let topPadding):
                XCTAssertEqual(topPadding, 4) // Test that it is the default value
                
            default:
                XCTFail("Shouldn't hit here")
        }
        
        XCTAssertEqual(styler.font.active, font)
        XCTAssertEqual(styler.textColor.active, Color.black)
        XCTAssertEqual(styler.activeBarColor, activeBarColor)
        XCTAssertEqual(styler.activeBarWidth, 4)
    }
    
    func testInitializationWithCustomStyleAndBarWidth() {
        let font           = Font.system(size: 14)
        let textColor      = SegmentControlStylerColor(active: Color.red)
        let activeBarColor = Color.green
        let customBarWidth: CGFloat = 6
        
        let styler = SegmentControlStyler(style: .overline(),
                                          font: SegmentControlStylerFont(active: font),
                                          textColor: textColor,
                                          activeBarColor: activeBarColor,
                                          activeBarWidth: customBarWidth)
        
        switch styler.style {
            case .overline(let bottomPadding):
                XCTAssertEqual(bottomPadding, 4)
                
            default:
                XCTFail("Shouldn't hit here")
        }
        
        XCTAssertEqual(styler.font.active, font)
        XCTAssertEqual(styler.textColor.active, Color.red)
        XCTAssertEqual(styler.activeBarColor, activeBarColor)
        XCTAssertEqual(styler.activeBarWidth, customBarWidth)
    }
    
    func testInitializationOverlineExplicitValue() {
        let font           = Font.system(size: 14)
        let textColor      = SegmentControlStylerColor(active: Color.red)
        let activeBarColor = Color.green
        let customBarWidth: CGFloat = 6
        
        let styler = SegmentControlStyler(style: .overline(bottomPadding: 32),
                                          font: SegmentControlStylerFont(active: font),
                                          textColor: textColor,
                                          activeBarColor: activeBarColor,
                                          activeBarWidth: customBarWidth)
        
        switch styler.style {
            case .overline(let bottomPadding):
                XCTAssertEqual(bottomPadding, 32)
                
            default:
                XCTFail("Shouldn't hit here")
        }
    }
    
    func testInitializationUnderlineExplicitValue() {
        let font           = Font.system(size: 14)
        let textColor      = SegmentControlStylerColor(active: Color.red)
        let activeBarColor = Color.green
        let customBarWidth: CGFloat = 6
        
        let styler = SegmentControlStyler(style: .underline(topPadding: 24),
                                          font: SegmentControlStylerFont(active: font),
                                          textColor: textColor,
                                          activeBarColor: activeBarColor,
                                          activeBarWidth: customBarWidth)
        
        switch styler.style {
            case .underline(let topPadding):
                XCTAssertEqual(topPadding, 24)
                
            default:
                XCTFail("Shouldn't hit here")
        }
    }
    
    func testInitializationCapsule() {
        let font           = Font.system(size: 14)
        let textColor      = SegmentControlStylerColor(active: Color.red)
        let activeBarColor = Color.green
        let customBarWidth: CGFloat = 6
        
        let styler = SegmentControlStyler(style: .capsule,
                                          font: SegmentControlStylerFont(active: font),
                                          textColor: textColor,
                                          activeBarColor: activeBarColor,
                                          activeBarWidth: customBarWidth)
        
        switch styler.style {
            case .capsule:
                XCTAssertTrue(true)
                
            default:
                XCTFail("Shouldn't hit here")
        }
    }
    
    
    func testInitializationWithInactiveFontAndColor() {
        
        let activeFont     = Font.system(size: 14)
        let inactiveFont   = Font.system(size: 12)
        let textColor      = SegmentControlStylerColor(active: Color.blue, inactive: Color.gray)
        let activeBarColor = Color.orange
        
        let styler = SegmentControlStyler(font: SegmentControlStylerFont(active: activeFont, inactive: inactiveFont), textColor: textColor, activeBarColor: activeBarColor)
        
        XCTAssertEqual(styler.font.active, activeFont)
        XCTAssertEqual(styler.font.inactive, inactiveFont)
        XCTAssertEqual(styler.textColor.active, Color.blue)
        XCTAssertEqual(styler.textColor.inactive, Color.gray)
        XCTAssertEqual(styler.activeBarColor, activeBarColor)
    }

    func testDefaultInactiveFontAndColor() {
        let font           = Font.system(size: 14)
        let textColor      = SegmentControlStylerColor(active: Color.black)
        let activeBarColor = Color.purple
        
        let styler = SegmentControlStyler(font: SegmentControlStylerFont(active: font),
                                          textColor: textColor,
                                          activeBarColor: activeBarColor)
        
        XCTAssertEqual(styler.font.inactive, font) // Inactive should default to active
        XCTAssertEqual(styler.textColor.inactive, Color.black) // Inactive should default to active
    }
}
