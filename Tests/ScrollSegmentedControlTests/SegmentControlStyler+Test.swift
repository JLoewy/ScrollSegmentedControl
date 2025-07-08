//
//  File.swift
//  ScrollSegmentControl
//
//  Created by Jason Loewy on 10/5/24.
//

import Testing
import SwiftUI

@testable import ScrollSegmentedControl

@Suite("SegmentControlStyler tests")
struct SegmentControlStylerTests {

    // MARK: - Initialiser defaults

    @Test("Default style is underline with 4-pt top padding")
    func defaultStyleIsUnderline() {
        
        let styler = SegmentControlStyler(
            font: .init(active: .body),
            textColor: .init(active: .black),
            activeBarColor: .red
        )

        if case .underline(let padding) = styler.style {
            #expect(padding == 4)
        } else {
            // Shouldn't ever reach here
            #expect(Bool(false), "Expected the .underline style by default")
        }
    }

    @Test("When activeBarWidth is nil it falls back to 4")
    func activeBarWidthFallback() {
        let styler = SegmentControlStyler(
            font: .init(active: .body),
            textColor: .init(active: .black),
            activeBarColor: .blue,
            activeBarWidth: nil      // explicit nil
        )
        #expect(styler.activeBarWidth == 4)
    }

    @Test("Providing a custom activeBarWidth is respected")
    func customActiveBarWidth() {
        let styler = SegmentControlStyler(
            font: .init(active: .body),
            textColor: .init(active: .black),
            activeBarColor: .blue,
            activeBarWidth: 8
        )
        #expect(styler.activeBarWidth == 8)
    }

    // MARK: - titleSpacerText

    @Test("titleSpacerText returns the requested number of spaces")
    func titleSpacerTextMatchesCount() {
        let styler = SegmentControlStyler(
            font: .init(active: .body),
            textColor: .init(active: .black),
            activeBarColor: .orange,
            titleTextPaddingSpaces: 3
        )
        #expect(styler.titleSpacerText == "   ")
    }

    @Test("titleSpacerText is empty when titleTextPaddingSpaces is nil")
    func titleSpacerTextEmptyWhenNil() {
        let styler = SegmentControlStyler(
            font: .init(active: .body),
            textColor: .init(active: .black),
            activeBarColor: .orange
        )
        #expect(styler.titleSpacerText.isEmpty)
    }

    // MARK: - Convenience initialiser

    @Test("Convenience init(Font…) wraps the Font in SegmentControlStylerFont")
    func fontConvenienceInit() {
        let activeFont: Font = .title
        let styler = SegmentControlStyler(
            font: activeFont,                     // uses the convenience init
            textColor: .init(active: .black),
            activeBarColor: .green
        )

        // Compare via String(describing:) because Font is not Equatable.
        #expect(String(describing: styler.font.active) == String(describing: activeFont))
        #expect(String(describing: styler.font.inactive) == String(describing: activeFont))
    }

    // MARK: - SegmentControlStylerFont

    @Test("SegmentControlStylerFont defaults inactive == active")
    func fontInactiveDefaultsToActive() {
        let fonts = SegmentControlStylerFont(active: .footnote)
        #expect(String(describing: fonts.inactive) == String(describing: fonts.active))
    }

    @Test("SegmentControlStylerFont respects custom inactive font")
    func fontCustomInactive() {
        let fonts = SegmentControlStylerFont(active: .footnote, inactive: .caption)
        #expect(fonts.inactive == .caption)
    }

    // MARK: - SegmentControlStylerColor

    @Test("SegmentControlStylerColor defaults inactive == active")
    func colorInactiveDefaultsToActive() {
        let colors = SegmentControlStylerColor(active: .red)
        #expect(String(describing: colors.inactive) == String(describing: colors.active))
    }

    @Test("SegmentControlStylerColor respects custom inactive color")
    func colorCustomInactive() {
        let colors = SegmentControlStylerColor(active: .red, inactive: .gray)
        #expect(String(describing: colors.inactive) != String(describing: colors.active))
    }
}
