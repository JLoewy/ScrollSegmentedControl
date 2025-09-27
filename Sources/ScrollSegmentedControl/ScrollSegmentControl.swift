import SwiftUI

public struct ScrollSegmentControl<S: Segment>: View {
    
    public let segments: [S]
    
    let spacing: CGFloat
    let style: SegmentControlStyler
    
    @Binding var activeSegment: S
    
    public init(segments: [S],
                spacing: CGFloat = 16,
                activeSegment: Binding<S>,
                style: SegmentControlStyler) {
        
        self.segments       = segments
        self.spacing        = spacing
        self._activeSegment = activeSegment
        self.style          = style
    }
    
    public var body: some View {
        Group {
            if style.scrollable {
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        getHSTackSegmentedControl(scrollViewProxy: scrollViewProxy)
                    }
                }
            }
            else {
                getHSTackSegmentedControl(scrollViewProxy: nil)
                    .padding(.leading, style.parentPadding?.leading ?? 0)
                    .padding(.leading, style.parentPadding?.trailing ?? 0)
            }
        }
    }
    
    
    private func getHSTackSegmentedControl(scrollViewProxy: ScrollViewProxy?) -> some View {
        HSTackSegmentedControl(
            spacing: spacing,
            segments: segments,
            style: style,
            activeSegment: $activeSegment,
            scrollViewProxy: scrollViewProxy
        )
    }
}

// MARK: - Preview

@available(iOS 18.0, *)
#Preview {
    
    @Previewable @State var activeSegmentOne   = SegmentItem(title: "Item One")
    @Previewable @State var activeSegmentTwo   = SegmentItem(title: "Section Two")
    @Previewable @State var activeSegmentThree = SegmentItem(title: "Study")
    
    let segments = [
        SegmentItem(title: "Item One"),
        SegmentItem(title: "Item Two"),
        SegmentItem(title: "Item Three")
    ]
    
    let studySegments = [
        SegmentItem(title: "Study"),
        SegmentItem(title: "Practice")
    ]
    
    VStack {
        
        ScrollSegmentControl(
            segments: studySegments,
            activeSegment: $activeSegmentThree,
            style: SegmentControlStyler(
                scrollable: false,
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue
            )
        )
        
        ScrollSegmentControl(
            segments: studySegments,
            activeSegment:  $activeSegmentThree,
            style: SegmentControlStyler(
                style: .overline(),
                scrollable: false,
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue
            )
        )
        .background(Color.red)
        
        ScrollSegmentControl(
            segments: studySegments,
            activeSegment:  $activeSegmentThree,
            style: SegmentControlStyler(
                style: .overline(bottomPadding: 16),
                scrollable: false,
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue
            )
        )
        .background(Color.yellow)
        
        ScrollSegmentControl(
            segments: segments,
            spacing: 0,
            activeSegment: $activeSegmentTwo,
            style: SegmentControlStyler(
                style: .capsule,
                font: Font.system(size: 16, weight: .semibold),
                textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
                activeBarColor: Color.blue)
        )
        
        ScrollSegmentControl(
            segments: segments,
            activeSegment: $activeSegmentTwo,
            style: SegmentControlStyler(
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue)
        )
        
        ScrollSegmentControl(
            segments: [
                SegmentItem(title: "Section One"),
                SegmentItem(title: "Section Two"),
                SegmentItem(title: "Section Three"),
                SegmentItem(title: "Section Four"),
                SegmentItem(title: "Section Five"),
                SegmentItem(title: "Section Six"),
            ],
            activeSegment: $activeSegmentTwo,
            style: SegmentControlStyler(
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue)
        )
        Spacer()
    }
}
