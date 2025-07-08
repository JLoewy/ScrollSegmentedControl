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
    
    @Binding var activeSegment: Segment
    var scrollViewProxy: ScrollViewProxy?
    
    var body: some View {
        Button {
            
            withAnimation {
                activeSegment = segment
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
                    getCapsule(text: segment.title,
                               isActive: (segment.isEqual(to: activeSegment)))
            }
        }
        .buttonStyle(.plain)
        .animation(.easeOut(duration: 0.35), value: activeSegment.id)
    }
    
    private func getCapsule(text: String, isActive: Bool) -> some View {
        
        Text(.init("\(style.titleSpacerText)\(text)\(style.titleSpacerText)"))
            .font(isActive ? style.font.active : style.font.inactive)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .foregroundColor(isActive ? style.textColor.active : style.textColor.inactive)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(isActive ? style.activeBarColor : Color.clear, in: .capsule)
        
    }
}
