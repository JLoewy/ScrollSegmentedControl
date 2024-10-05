import SwiftUI

// MARK: - GridSegmentControl

@available(iOS 16.0, *)
public struct GridSegmentControl: View {
    
    public let segments: [Segment]
    @Binding var activeSegment: String
    
    let style: SegmentControlStyler
    let leftAligned: Bool
    
    var segmentTapped:((Segment) -> Void)?
    
    public init(segments: [Segment],
                activeSegment: Binding<String>,
                leftAligned: Bool = (UIDevice.current.userInterfaceIdiom == .pad),
                style: SegmentControlStyler,
                segmentTapped: ((Segment) -> Void)? = nil) {
        
        self.segments       = segments
        self._activeSegment = activeSegment
        self.style          = style
        self.leftAligned    = leftAligned
        self.segmentTapped  = segmentTapped
    }
    
    public var body: some View {
        
        HStack {
            Grid(horizontalSpacing: leftAligned ? 8 : 16) {
                GridRow {
                    ForEach(segments) {
                        SegmentButtonView(
                            segment: $0,
                            style: style,
                            activeSegment: $activeSegment,
                            scrollViewProxy: nil,
                            segmentTapped: segmentTapped
                        )
                    }
                }
            }
            
            if leftAligned {
                Spacer()
            }
        }
    }
}

// MARK: - ScrollSegmentControl

@available(iOS 15.0, *)
public struct ScrollSegmentControl: View {
    
    public let segments: [Segment]
    var spacing: CGFloat = 16
    var scrollable: Bool
    @Binding var activeSegment: String
    
    let style: SegmentControlStyler
    
    var segmentTapped:((Segment) -> Void)?
    
    public init(segments: [Segment],
                spacing: CGFloat = 16,
                scrollable: Bool = true,
                activeSegment: Binding<String>,
                style: SegmentControlStyler,
                segmentTapped: ((Segment) -> Void)? = nil) {
        
        self.segments       = segments
        self.spacing        = spacing
        self.scrollable     = scrollable
        self._activeSegment = activeSegment
        self.style          = style
        self.segmentTapped  = segmentTapped
    }
    
    public var body: some View {

        
        Group {
            if scrollable {
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        getHSTackSegmentedControl(scrollViewProxy: scrollViewProxy)
                    }
                }
            }
            else {
                getHSTackSegmentedControl(scrollViewProxy: nil)
                    .padding(.horizontal, 32)
            }
        }
    }
    
    private func getHSTackSegmentedControl(scrollViewProxy: ScrollViewProxy?) -> some View {
        HSTackSegmentedControl(
            spacing: spacing,
            segments: segments,
            style: style,
            activeSegment: $activeSegment,
            scrollViewProxy: scrollViewProxy,
            segmentTapped: self.segmentTapped
        )
    }
}

// MARK: - Mutators

extension ScrollSegmentControl {
    
    /// If the Segments contains the new active segment provided then
    /// selected it as the new one, otherwise fail quietly
    ///
    /// - Parameter newActiveSegment: **String**
    public mutating func update(activeSegment newActiveSegment: String) {
        
        if segments.contains(where: { $0.title == newActiveSegment }) {
            activeSegment = newActiveSegment
        }
    }
    
    public mutating func update(activeSegmentIdx newSegmentIdx: Int) {
        if newSegmentIdx < segments.count {
            activeSegment = segments[newSegmentIdx].title
        }
    }
}

// MARK: - HSTackSegmentedControl

private struct HSTackSegmentedControl: View {
    
    let spacing: CGFloat
    let segments: [Segment]
    let style: SegmentControlStyler
    
    @Binding var activeSegment: String
    var scrollViewProxy: ScrollViewProxy?
    
    var segmentTapped:((Segment) -> Void)?
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(segments) { segment in

                SegmentButtonView(
                    segment: segment,
                    style: style,
                    activeSegment: $activeSegment,
                    scrollViewProxy: scrollViewProxy,
                    segmentTapped: segmentTapped
                )
                .id(segment.id)
                .padding(.vertical)
                .hoverEffect()
            }
        }
        .padding(.top)
        .padding(.horizontal, 32)
        .padding(.bottom, 6)
        .onAppear {

            // Scroll to the active segment on appear
            if let activeSegment = self.segments.first(where: { $0.title == self.activeSegment }) {
            
                scrollViewProxy?.scrollTo(activeSegment.id)
            }
        }
    }
}

// MARK: - Preview

@available(iOS 18.0, *)
#Preview {
    
    @Previewable @State var activeSegmentOne = "Item One"
    @Previewable @State var activeSegmentTwo = "Section Two"
    @Previewable @State var activeSegmentThree = "Study"
    
    VStack {
        
        GridSegmentControl(
            segments: [
                Segment(title: "Item One"),
                Segment(title: "Item Two"),
                Segment(title: "Item Three")
            ],
            activeSegment: $activeSegmentOne,
            leftAligned: true,
            style: SegmentControlStyler(
                style: .capsule,
                font: Font.system(size: 16, weight: .semibold),
                textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
                activeBarColor: Color.blue
            ),
            segmentTapped: nil
        )
        
        GridSegmentControl(
            segments: [
                Segment(title: "Item One"),
                Segment(title: "Item Two"),
                Segment(title: "Item Three")
            ],
            activeSegment: $activeSegmentOne,
            leftAligned: false,
            style: SegmentControlStyler(
                style: .capsule,
                font: Font.system(size: 16, weight: .semibold),
                textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
                activeBarColor: Color.blue
            ),
            segmentTapped: nil
        )
        
        ScrollSegmentControl(
            segments: [
                Segment(title: "Study"),
                Segment(title: "Practice")
            ],
            scrollable: false,
            activeSegment: $activeSegmentThree,
            style: SegmentControlStyler(
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue
            )
        )
        
        ScrollSegmentControl(
            segments: [
                Segment(title: "Study"),
                Segment(title: "Practice")
            ],
            scrollable: false,
            activeSegment:  $activeSegmentThree,
            style: SegmentControlStyler(
                style: .overline(),
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue
            )
        )
        .background(Color.red)
        
        ScrollSegmentControl(
            segments: [
                Segment(title: "Study"),
                Segment(title: "Practice")
            ],
            scrollable: false,
            activeSegment:  $activeSegmentThree,
            style: SegmentControlStyler(
                style: .overline(bottomPadding: 16),
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue
            )
        )
        .background(Color.yellow)
        
        ScrollSegmentControl(
            segments: [
                Segment(title: "Section One"),
                Segment(title: "Section Two"),
                Segment(title: "Section Three")
            ],
            spacing: 0,
            activeSegment: $activeSegmentTwo,
            style: SegmentControlStyler(
                style: .capsule,
                font: Font.system(size: 16, weight: .semibold),
                textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
                activeBarColor: Color.blue)
        )
        
        ScrollSegmentControl(
            segments: [
                Segment(title: "Section One"),
                Segment(title: "Section Two"),
                Segment(title: "Section Three")
            ],
            activeSegment: $activeSegmentTwo,
            style: SegmentControlStyler(
                font: Font.system(size: 22, weight: .bold),
                textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                activeBarColor: Color.blue)
        )
        
        ScrollSegmentControl(
            segments: [
                Segment(title: "Section One"),
                Segment(title: "Section Two"),
                Segment(title: "Section Three"),
                Segment(title: "Section Four"),
                Segment(title: "Section Five"),
                Segment(title: "Section Six"),
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
