//
//  HSTackSegmentedControl.swift
//  ScrollSegmentedControl
//
//  Created by Jason Loewy on 7/7/25.
//

import Foundation
import SwiftUI

internal struct HSTackSegmentedControl: View {
    
    let spacing: CGFloat
    let segments: [Segment]
    let style: SegmentControlStyler
    
    @Binding var activeSegment: Segment
    var scrollViewProxy: ScrollViewProxy?
    
    var body: some View {
        HStack(spacing: spacing) {
            
            ForEach(Array(segments.enumerated()), id: \.offset) { index, segment in

                SegmentButtonView(
                    segment: segment,
                    style: style,
                    activeSegment: $activeSegment,
                    scrollViewProxy: scrollViewProxy
                )
                .id(segment.id)
                .padding(.vertical)
                .hoverEffect()
                .accessibilityIdentifier("segment-\(index)")
            }
        }
        .padding(.top, style.parentPadding?.top ?? 0)
        .padding(.leading, style.parentPadding?.leading ?? 0)
        .padding(.trailing, style.parentPadding?.trailing ?? 0)
        .padding(.bottom, style.parentPadding?.bottom ?? 0)
        .onAppear {
            scrollViewProxy?.scrollTo(activeSegment.id)
        }
    }
}
