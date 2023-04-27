//
//  File.swift
//  
//
//  Created by Jason Loewy on 4/27/23.
//

import Foundation
import SwiftUI

public struct SegmentControlStyler {
    
    let font: (active: Font, inactive: Font)
    let textColor: (active: Color, inactive: Color)
    
    var activeBarColor: Color
    var activeBarWidth: CGFloat = 4
    
    public init(font: (active: Font, inactive: Font),
                textColor: (active: Color, inactive: Color),
                activeBarColor: Color,
                activeBarWidth: CGFloat? = nil) {
        
        self.font           = font
        self.textColor      = textColor
        self.activeBarColor = activeBarColor
        
        if let activeBarWidth {
            self.activeBarWidth = activeBarWidth
        }
    }
    
    public init(font: Font,
                textColor: (active: Color, inactive: Color),
                activeBarColor: Color,
                activeBarWidth: CGFloat? = nil) {
        
        self.init(font: (font, font), textColor: textColor, activeBarColor: activeBarColor, activeBarWidth: activeBarWidth)
    }
}
