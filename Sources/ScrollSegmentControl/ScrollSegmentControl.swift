import SwiftUI

@available (iOS 15.0, *)
public struct ScrollSegmentControl: View {
    
    let segments: [Segment]
    var spacing: CGFloat = 16
    @State var activeSegment: String?
    
    let style: SegmentControlStyler
    
    var segmentTapped:((Segment) -> Void)?

    public init(segments: [Segment],
                spacing: CGFloat = 16,
                activeSegment: String? = nil,
                style: SegmentControlStyler,
                segmentTapped: ((Segment) -> Void)? = nil) {
        
        self.segments      = segments
        self.spacing       = spacing
        self.activeSegment = activeSegment
        self.style         = style
        self.segmentTapped = segmentTapped
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HSTackSegmentedControl(
                spacing: spacing,
                segments: segments,
                style: style,
                activeSegment: $activeSegment,
                segmentTapped: self.segmentTapped
            )
        }
    }
}

// MARK: - HSTackSegmentedControl

private struct HSTackSegmentedControl: View {
    
    let spacing: CGFloat
    let segments: [Segment]
    let style: SegmentControlStyler
    
    @Binding var activeSegment: String?
    
    var segmentTapped:((Segment) -> Void)?
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(Array(segments.enumerated()), id: \.offset) { (idx, segment) in
                withAnimation {
                    SegmentButtonView(
                        segment: segment,
                        style: style,
                        activeSegment: $activeSegment,
                        segmentTapped: segmentTapped
                    )
                }
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
}

// MARK: - SegmentButtonView

private struct SegmentButtonView: View {
    
    let segment: Segment
    let style: SegmentControlStyler
    
    @Binding var activeSegment: String?
    
    var segmentTapped:((Segment) -> Void)?
    
    var body: some View {
        Button {
            activeSegment = segment.title
            segmentTapped?(segment)
            
        } label: {
            VStack(spacing: 4) {
                Text(segment.title)
                ((segment.title == activeSegment) ? style.activeBarColor : Color.clear)
                    .cornerRadius(style.activeBarWidth / 2)
                    .frame(height: style.activeBarWidth)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview

struct ScrollSegmentControl_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScrollSegmentControl(
                segments: [
                    Segment(title: "Section One"),
                    Segment(title: "Section Two"),
                    Segment(title: "Section Three")
                ],
                activeSegment: "Section Two",
                style: SegmentControlStyler(
                    font: Font.system(size: 22, weight: .bold),
                    textColor: (Color.black, Color.gray),
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
                    textColor: (Color.black, Color.gray),
                    activeBarColor: Color.blue)
            )
            Spacer()
        }
    }
}
