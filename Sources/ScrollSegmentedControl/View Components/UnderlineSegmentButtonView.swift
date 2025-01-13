//
//  SwiftUIView.swift
//  ScrollSegmentControl
//
//  Created by Jason Loewy on 10/5/24.
//

import SwiftUI

internal struct UnderlineSegmentButtonView: View {
    
    let segment: Segment
    let style: SegmentControlStyler
    
    @Binding var activeSegment: String
    
    private var isActiveSegment: Bool {
        activeSegment == segment.title
    }
    
    init(segment: Segment,
         style: SegmentControlStyler,
         activeSegment: Binding<String>) {
        
        self.segment           = segment
        self.style             = style
        self._activeSegment    = activeSegment
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            switch style.style {
                case .overline(let bottomPadding):
                    underlineBarView
                        .padding(.bottom, bottomPadding)
                    
                default:
                    EmptyView()
                        .frame(width: 0, height: 0)
            }
            
            Text(.init("\(style.titleSpacerText)\(segment.title)\(style.titleSpacerText)"))
                .font(isActiveSegment ? style.font.active : style.font.inactive)
                .foregroundColor(isActiveSegment ? style.textColor.active : style.textColor.inactive)
            
            switch style.style {
                case .underline(let topPadding):
                    underlineBarView
                        .padding(.top, topPadding)
                    
                default:
                    EmptyView()
                        .frame(width: 0, height: 0)
            }
        }
        .transition(.opacity)
        .animation(.linear(duration: 0.25), value: activeSegment)
    }
    
    private var underlineBarView: some View {
        style.activeBarColor
            .cornerRadius(style.activeBarWidth / 2)
            .frame(height: style.activeBarWidth)
            .opacity(isActiveSegment ? 1 : 0)
    }
}

extension UnderlineSegmentButtonView {
    
    public enum UnderlinePosition {
        case top
        case bottom
    }
}

@available(iOS 17.0, *)
#Preview {
    
    @Previewable @State var activeSegment: String = "Test One"
    
    let stylerUnderlineDefault = SegmentControlStyler(
        style: .underline(),
        font: Font.system(size: 16, weight: .semibold),
        textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
        activeBarColor: Color.blue
    )
    
    let stylerUnderlineLarge = SegmentControlStyler(
        style: .underline(topPadding: 16),
        font: Font.system(size: 16, weight: .semibold),
        textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
        activeBarColor: Color.blue
    )
    
    let stylerOverlineDefault = SegmentControlStyler(
        style: .overline(),
        font: Font.system(size: 16, weight: .semibold),
        textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
        activeBarColor: Color.blue
    )
    
    let stylerOverlineLarge = SegmentControlStyler(
        style: .overline(bottomPadding: 16),
        font: Font.system(size: 16, weight: .semibold),
        textColor: SegmentControlStylerColor(active: Color.white, inactive: Color.gray),
        activeBarColor: Color.blue
    )
    
    VStack {
        HStack {
            Button {
                
                withAnimation {
                    activeSegment = "Test One"
                }
                
            } label: {
                UnderlineSegmentButtonView(
                    segment: .init(title: "Test One"),
                    style: stylerUnderlineDefault,
                    activeSegment: $activeSegment
                )
            }
            Button {
                withAnimation {
                    activeSegment = "Test Two"
                }
            } label: {
                UnderlineSegmentButtonView(
                    segment: .init(title: "Test Two"),
                    style: stylerUnderlineDefault,
                    activeSegment: $activeSegment
                )
            }
            Spacer()
        }
        .padding(.vertical)
        .background(Color.cyan)
        
        HStack {
            Button {
                
                withAnimation {
                    activeSegment = "Test One"
                }
                
            } label: {
                UnderlineSegmentButtonView(
                    segment: .init(title: "Test One"),
                    style: stylerUnderlineLarge,
                    activeSegment: $activeSegment
                )
            }
            Button {
                withAnimation {
                    activeSegment = "Test Two"
                }
            } label: {
                UnderlineSegmentButtonView(
                    segment: .init(title: "Test Two"),
                    style: stylerUnderlineLarge,
                    activeSegment: $activeSegment
                )
            }
            Spacer()
        }
        .padding(.vertical)
        .background(Color.cyan)
        
        HStack {
            Button {
                
                withAnimation {
                    activeSegment = "Test One"
                }
                
            } label: {
                UnderlineSegmentButtonView(
                    segment: .init(title: "Test One"),
                    style: stylerOverlineDefault,
                    activeSegment: $activeSegment
                )
            }
            Button {
                withAnimation {
                    activeSegment = "Test Two"
                }
            } label: {
                UnderlineSegmentButtonView(
                    segment: .init(title: "Test Two"),
                    style: stylerOverlineDefault,
                    activeSegment: $activeSegment
                )
            }
            Spacer()
        }
        .padding(.vertical)
        .background(Color.cyan)
        
        HStack {
            Button {
                
                withAnimation {
                    activeSegment = "Test One"
                }
                
            } label: {
                UnderlineSegmentButtonView(
                    segment: .init(title: "Test One"),
                    style: stylerOverlineLarge,
                    activeSegment: $activeSegment
                )
            }
            Button {
                withAnimation {
                    activeSegment = "Test Two"
                }
            } label: {
                UnderlineSegmentButtonView(
                    segment: .init(title: "Test Two"),
                    style: stylerOverlineLarge,
                    activeSegment: $activeSegment
                )
            }
            Spacer()
        }
        .padding(.vertical)
        .background(Color.cyan)
    }
}
