//
//  GridSegmentControl.swift
//  ScrollSegmentedControl
//
//  Created by Jason Loewy on 7/7/25.
//


import SwiftUI

@available(iOS 16.0, *)
public struct GridSegmentControl: View {
    
    public let segments: [Segment]
    @Binding var activeSegment: Segment
    
    let style: SegmentControlStyler
    let leftAligned: Bool
    
    public init(segments: [Segment],
                activeSegment: Binding<Segment>,
                leftAligned: Bool = (UIDevice.current.userInterfaceIdiom == .pad),
                style: SegmentControlStyler) {
        
        self.segments       = segments
        self._activeSegment = activeSegment
        self.style          = style
        self.leftAligned    = leftAligned
    }
    
    public var body: some View {
        
        HStack {
            
            if !leftAligned {
                Spacer(minLength: 0)
            }
            
            Grid(horizontalSpacing: leftAligned ? 8 : 16) {
                GridRow {
                    ForEach(segments, id: \.id) {
                        SegmentButtonView(
                            segment: $0,
                            style: style,
                            activeSegment: $activeSegment,
                            scrollViewProxy: nil
                        )
                        .hoverEffect()
                    }
                }
            }
            
            Spacer(minLength: 0)
        }
    }
}

@available(iOS 17.0, *)
#Preview {

    @Previewable @State var activeSegmentOne: any Segment = SegmentItem(title: "Item One")
    @Previewable @State var activeSegmentTwo: any Segment = SegmentItem(title: "Item One")
    @Previewable @State var activeSegmentThree: any Segment = SegmentItem(title: "Item One")
    @Previewable @State var activeSegmentFour: any Segment = SegmentItem(title: "Item One")
    
    let segments = [
        SegmentItem(title: "Item One"),
        SegmentItem(title: "Item Two"),
        SegmentItem(title: "Item Three")
    ]
    
    VStack(alignment: .leading, spacing: 16) {
        
        GridSegmentControl(
            segments: segments,
            activeSegment: $activeSegmentOne,
            leftAligned: true,
            style: SegmentControlStyler(
                style: .capsule,
                font: Font.headline,
                textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
                activeBarColor: Color.blue
            )
        )
        
        GridSegmentControl(
            segments: segments,
            activeSegment: $activeSegmentTwo,
            leftAligned: true,
            style: SegmentControlStyler(
                style: .overline(bottomPadding: 4),
                font: Font.headline,
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue
            )
        )
        
        GridSegmentControl(
            segments: Array(segments[0..<2]),
            activeSegment: $activeSegmentThree,
            leftAligned: false,
            style: .init(
                style: .underline(topPadding: 4),
                parentPadding: nil,
                scrollable: false,
                font: .init(active: Font.headline),
                textColor: .init(active: .black, inactive: .gray),
                activeBarColor: Color.cyan,
                activeBarWidth: 4,
                titleTextPaddingSpaces: nil)
            )
        
        GridSegmentControl(
            segments: Array(segments[0..<2]),
            activeSegment: $activeSegmentFour,
            leftAligned: false,
            style: .init(
                style: .capsule,
                parentPadding: nil,
                scrollable: false,
                font: .init(active: Font.headline),
                textColor: .init(active: .black, inactive: .gray),
                activeBarColor: Color.cyan,
                activeBarWidth: 4,
                titleTextPaddingSpaces: nil)
            )
        
        Spacer()
    }
    .padding()
}
