import SwiftUI

@available (iOS 15.0, *)
public struct ScrollSegmentControl: View {
    
    public let segments: [Segment]
    var spacing: CGFloat = 16
    var scrollable: Bool
    @State var activeSegment: String?
    
    let style: SegmentControlStyler
    
    var segmentTapped:((Segment) -> Void)?
    
    public init(segments: [Segment],
                spacing: CGFloat = 16,
                scrollable: Bool = true,
                activeSegment: String? = nil,
                style: SegmentControlStyler,
                segmentTapped: ((Segment) -> Void)? = nil) {
        
        self.segments      = segments
        self.spacing       = spacing
        self.scrollable    = scrollable
        self.activeSegment = activeSegment
        self.style         = style
        self.segmentTapped = segmentTapped
    }
    
    public var body: some View {
        
        Group {
            if scrollable {
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
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
            }
            else {
                HSTackSegmentedControl(
                    spacing: spacing,
                    segments: segments,
                    style: style,
                    activeSegment: $activeSegment,
                    segmentTapped: self.segmentTapped
                )
                .padding(.horizontal, 32)
            }
        }
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
    
    @Binding var activeSegment: String?
    var scrollViewProxy: ScrollViewProxy?
    
    var segmentTapped:((Segment) -> Void)?
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(Array(segments.enumerated()), id: \.offset) { (idx, segment) in
                withAnimation {
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
        }
        .padding(.top)
        .padding(.horizontal, 32)
        .padding(.bottom, 6)
        .onAppear {

            // Scroll to the active segment on appear
            if let activeSegmentString = self.activeSegment,
               let activeSegment = self.segments.first(where: { $0.title == activeSegmentString }) {
            
                scrollViewProxy?.scrollTo(activeSegment.id)
            }
        }
    }
}

// MARK: - SegmentButtonView

private struct SegmentButtonView: View {
    
    let segment: Segment
    let style: SegmentControlStyler
    
    @Binding var activeSegment: String?
    var scrollViewProxy: ScrollViewProxy?
    
    var segmentTapped:((Segment) -> Void)?
    
    private func isActiveSegment(currentSegment: Segment) -> Bool {
        (currentSegment.title == activeSegment)
    }
    
    var body: some View {
        Button {
            activeSegment = segment.title
            segmentTapped?(segment)
            
            if let scrollViewProxy {
                withAnimation {
                    scrollViewProxy.scrollTo(segment.id)
                }
            }
        } label: {
            
            switch self.style.style {
                case .underline:
                    UnderlineSegmentButtonView(
                        segment: segment,
                        style: style,
                        isActiveSegment: isActiveSegment(currentSegment: segment)
                    )
                    
                case .capsule:
                    Text(segment.title)
                        .font(isActiveSegment(currentSegment: segment) ? style.font.active : style.font.inactive)
                        .foregroundColor((segment.title == activeSegment) ? style.textColor.active : style.textColor.inactive)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(isActiveSegment(currentSegment: segment) ? style.activeBarColor : Color.clear)
                        .clipShape(Capsule())
                    
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - UnderlineSegment - ButtonView

private struct UnderlineSegmentButtonView: View {
    
    let segment: Segment
    let style: SegmentControlStyler
    
    let isActiveSegment: Bool
    
    var body: some View {
        
        VStack(spacing: 4) {
            Text(segment.title)
                .font(isActiveSegment ? style.font.active : style.font.inactive)
                .foregroundColor(isActiveSegment ? style.textColor.active : style.textColor.inactive)
            
            (isActiveSegment ? style.activeBarColor : Color.clear)
                .cornerRadius(style.activeBarWidth / 2)
                .frame(height: style.activeBarWidth)
        }
    }
}

// MARK: - Preview

struct ScrollSegmentControl_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ScrollSegmentControl(
                segments: [
                    Segment(title: "Study"),
                    Segment(title: "Practice")
                ],
                scrollable: false,
                activeSegment: "Study",
                style: SegmentControlStyler(
                    font: Font.system(size: 22, weight: .bold),
                    textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                    activeBarColor: Color.blue)
            )
            
            ScrollSegmentControl(
                segments: [
                    Segment(title: "Section One"),
                    Segment(title: "Section Two"),
                    Segment(title: "Section Three")
                ],
                spacing: 0,
                activeSegment: "Section Two",
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
                activeSegment: "Section Two",
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
                activeSegment: "Section Two",
                style: SegmentControlStyler(
                    font: Font.system(size: 22, weight: .bold),
                    textColor: SegmentControlStylerColor(active: Color.black, inactive: Color.gray),
                    activeBarColor: Color.blue)
            )
            Spacer()
        }
    }
}
