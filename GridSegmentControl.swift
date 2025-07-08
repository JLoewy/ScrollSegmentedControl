import SwiftUI

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