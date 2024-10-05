//
//  File.swift
//  ScrollSegmentControl
//
//  Created by Jason Loewy on 10/5/24.
//

import SwiftUI

internal struct SegmentButtonView: View {
    
    let segment: Segment
    let style: SegmentControlStyler
    
    @Binding var activeSegment: String
    var scrollViewProxy: ScrollViewProxy?
    
    var segmentTapped:((Segment) -> Void)?
    
    private func isActiveSegment(currentSegment: Segment) -> Bool {
        (currentSegment.title == activeSegment)
    }
    
    var body: some View {
        Button {
            
            withAnimation {
                
                activeSegment = segment.title
                segmentTapped?(segment)
                
                if let scrollViewProxy {
                    scrollViewProxy.scrollTo(segment.id)
                }
            }
        } label: {
            
            switch self.style.style {
                case .underline(_), .overline(_):
                    UnderlineSegmentButtonView(
                        segment: segment,
                        style: style,
                        activeSegment: $activeSegment
                    )
                
                case .capsule:
                    Text(segment.title)
                        .font(isActiveSegment(currentSegment: segment) ? style.font.active : style.font.inactive)
                        .foregroundColor((segment.title == activeSegment) ? style.textColor.active : style.textColor.inactive)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(isActiveSegment(currentSegment: segment) ? style.activeBarColor : Color.clear)
                        .clipShape(.capsule)
                    
            }
        }
        .buttonStyle(.plain)
        .animation(.easeOut(duration: 0.35), value: activeSegment)
    }
}
