//
//  File.swift
//  
//
//  Created by Jason Loewy on 4/27/23.
//

import Foundation
import SwiftUI

public struct SegmentControlStyler {
    
    let style: SegmentControlStyler.Style
    
    let font: SegmentControlStylerFont
    let textColor: SegmentControlStylerColor
    
    let activeBarColor: Color
    let activeBarWidth: CGFloat
    
    let parentPadding: EdgeInsets?
    
    /// If you want to add spaces to the title text this is the number of spaces on each side that will be added
    let titleTextPaddingSpaces: Int?
    let scrollable: Bool
    
    public init(style: SegmentControlStyler.Style = .underline(),
                parentPadding: EdgeInsets? = nil,
                scrollable: Bool = true,
                font: SegmentControlStylerFont,
                textColor: SegmentControlStylerColor,
                activeBarColor: Color,
                activeBarWidth: CGFloat? = nil,
                titleTextPaddingSpaces: Int? = nil) {
        
        self.style          = style
        self.parentPadding  = parentPadding
        self.scrollable     = scrollable
        self.font           = font
        self.textColor      = textColor
        self.activeBarColor = activeBarColor
        self.titleTextPaddingSpaces = titleTextPaddingSpaces
        self.activeBarWidth = activeBarWidth ?? 4
    }
    
    public init(style: SegmentControlStyler.Style = .underline(),
                parentPadding: EdgeInsets? = nil,
                scrollable: Bool = true,
                font: Font,
                textColor: SegmentControlStylerColor,
                activeBarColor: Color,
                activeBarWidth: CGFloat? = nil) {
        
        self.init(
            style: style,
            parentPadding: parentPadding,
            scrollable: scrollable,
            font: SegmentControlStylerFont(active: font),
            textColor: textColor,
            activeBarColor: activeBarColor,
            activeBarWidth: activeBarWidth
        )
    }
    
    // MARK: - Accessors
    
    /// Gets the spacer text that should be used on each side of the title for the button based off of the titleTextPaddingSpaces variable
    /// The amount of spaces is >= 0 spaces 
    public var titleSpacerText: String {
         Array(repeating: " ", count: titleTextPaddingSpaces ?? 0).joined()
    }
}

// MARK: - SegmentedControlStyler.Style

extension SegmentControlStyler {
    
    public enum Style {
        case underline(topPadding: CGFloat = 4)
        case overline(bottomPadding: CGFloat = 4)
        case capsule
    }
}

// MARK: - SegmentControlStyler - Font

public struct SegmentControlStylerFont {
    
    let active: Font
    let inactive: Font
    
    public init(active: Font, inactive: Font? = nil) {
        self.active   = active
        self.inactive = inactive ?? active
    }
}

// MARK: - SegmentControlSyler - Color

public struct SegmentControlStylerColor {
    
    let active: Color
    let inactive: Color
    
    public init(active: Color, inactive: Color? = nil) {
        self.active   = active
        self.inactive = inactive ?? active
    }
}
