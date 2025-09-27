//
//  SwiftUIView.swift
//  ScrollSegmentControl
//
//  Created by Jason Loewy on 10/5/24.
//

import SwiftUI

internal struct UnderlineSegmentButtonView<S: Segment>: View {
    
    let segment: S
    let style: SegmentControlStyler
    
    @Binding var activeSegment: S
    
    init(segment: S,
         style: SegmentControlStyler,
         activeSegment: Binding<S>) {
        
        self.segment           = segment
        self.style             = style
        self._activeSegment    = activeSegment
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            switch style.style {
                case .overline(let bottomPadding):
                    underlineBarView(isActive: segment.isEqual(to: activeSegment))
                        .padding(.bottom, bottomPadding)
                    
                default:
                    EmptyView()
                        .frame(width: 0, height: 0)
            }
            
            getSegmentTitle(isActive: segment.isEqual(to: activeSegment))
            
            switch style.style {
                case .underline(let topPadding):
                    underlineBarView(isActive: segment.isEqual(to: activeSegment))
                        .padding(.top, topPadding)
                    
                default:
                    EmptyView()
                        .frame(width: 0, height: 0)
            }
        }
        .transition(.opacity)
        .animation(.linear(duration: 0.25), value: activeSegment.id)
    }
    
    private func getSegmentTitle(isActive: Bool) -> some View {
        
        Text(.init("\(style.titleSpacerText)\(segment.title)\(style.titleSpacerText)"))
            .font(isActive ? style.font.active : style.font.inactive)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .foregroundColor(isActive ? style.textColor.active : style.textColor.inactive)
    }
    
    private func underlineBarView(isActive: Bool) -> some View {
        style.activeBarColor
            .cornerRadius(style.activeBarWidth / 2)
            .frame(height: style.activeBarWidth)
            .opacity(isActive ? 1 : 0)
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
    
    @Previewable @State var activeSegment = SegmentItem(title: "Test One")
    let testOneSegmentItem = SegmentItem(title: "Test One")
    let testTwoSegmentItem = SegmentItem(title: "Test Two")
    
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
    
    let testSegmentItem = SegmentItem(title: "Test One")
    
    VStack {
        HStack {
            Button {
                
                withAnimation {
                    activeSegment = testOneSegmentItem
                }
                
            } label: {
                UnderlineSegmentButtonView<SegmentItem>(
                    segment: testSegmentItem,
                    style: stylerUnderlineDefault,
                    activeSegment: $activeSegment
                )
            }
            Button {
                withAnimation {
                    activeSegment = SegmentItem(title: "Test Two")
                }
            } label: {
                UnderlineSegmentButtonView(
                    segment: SegmentItem(title: "Test Two"),
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
                    activeSegment = testOneSegmentItem
                }
                
            } label: {
                UnderlineSegmentButtonView(
                    segment: testOneSegmentItem,
                    style: stylerUnderlineLarge,
                    activeSegment: $activeSegment
                )
            }
            Button {
                withAnimation {
                    activeSegment = testTwoSegmentItem
                }
            } label: {
                UnderlineSegmentButtonView(
                    segment: testTwoSegmentItem,
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
                    activeSegment = testOneSegmentItem
                }
                
            } label: {
                UnderlineSegmentButtonView(
                    segment: testOneSegmentItem,
                    style: stylerOverlineDefault,
                    activeSegment: $activeSegment
                )
            }
            Button {
                withAnimation {
                    activeSegment = testTwoSegmentItem
                }
            } label: {
                UnderlineSegmentButtonView(
                    segment: testTwoSegmentItem,
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
                    activeSegment = testOneSegmentItem
                }
                
            } label: {
                UnderlineSegmentButtonView(
                    segment: testOneSegmentItem,
                    style: stylerOverlineLarge,
                    activeSegment: $activeSegment
                )
            }
            Button {
                withAnimation {
                    activeSegment = testTwoSegmentItem
                }
            } label: {
                UnderlineSegmentButtonView(
                    segment: testTwoSegmentItem,
                    style: stylerOverlineLarge,
                    activeSegment: $activeSegment
                )
            }
            Spacer()
        }
        .padding(.vertical)
        .background(Color.cyan)
        
        Spacer()
    }
    
}
