//
//  File.swift
//  
//
//  Created by Jason Loewy on 4/27/23.
//

import Foundation
import SwiftUI

public struct SegmentControlStyler {
    
    public struct ParentPadding {

        let top: CGFloat
        let horizontal: CGFloat
        let bottom: CGFloat

        public init(top: CGFloat = 16, horizontal: CGFloat = 32, bottom: CGFloat = 6) {
            self.top        = top
            self.horizontal = horizontal
            self.bottom     = bottom
        }
    } 
    
    let style: SegmentControlStyler.Style
    
    let font: SegmentControlStylerFont
    let textColor: SegmentControlStylerColor
    
    var activeBarColor: Color
    var activeBarWidth: CGFloat = 4
    
    let parentPadding: ParentPadding
    
    public init(style: SegmentControlStyler.Style = .underline(),
                parentPadding: ParentPadding = .init(),
                font: SegmentControlStylerFont,
                textColor: SegmentControlStylerColor,
                activeBarColor: Color,
                activeBarWidth: CGFloat? = nil) {
        
        self.style          = style
        self.parentPadding  = parentPadding
        self.font           = font
        self.textColor      = textColor
        self.activeBarColor = activeBarColor
        
        if let activeBarWidth {
            self.activeBarWidth = activeBarWidth
        }
    }
    
    public init(style: SegmentControlStyler.Style = .underline(),
                parentPadding: ParentPadding = .init(),
                font: Font,
                textColor: SegmentControlStylerColor,
                activeBarColor: Color,
                activeBarWidth: CGFloat? = nil) {
        
        self.init(
            style: style,
            parentPadding: parentPadding,
            font: SegmentControlStylerFont(active: font),
            textColor: textColor,
            activeBarColor: activeBarColor,
            activeBarWidth: activeBarWidth
        )
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
