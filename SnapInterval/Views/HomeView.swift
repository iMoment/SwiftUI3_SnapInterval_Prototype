//
//  HomeView.swift
//  SnapInterval
//
//  Created by Stanley Pan on 2022/01/28.
//

import SwiftUI

struct HomeView: View {
    @State var offset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ScrollContent()
                .padding(.top, getScreenSize().height / 3)
                .padding(.bottom, CGFloat(links.count - 1) * 80)
                // MARK: Overlay Masking View
                .overlay(
                    GeometryReader { _ in
                        ScrollContent(showTitle: true)
                    }
                    .frame(height: 80)
                    .offset(y: offset)
                    .clipped()
                    .background(Color("yellow"))
                    .padding(.top, getScreenSize().height / 3)
                    .offset(y: -offset)
                    ,alignment: .top
                )
                .modifier(OffsetModifier(offset: $offset))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color("background"))
        // MARK: ScrollView Coordinate Namespace
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func ScrollContent(showTitle: Bool = false) -> some View {
        VStack(spacing:  0) {
            ForEach(links) { link in
                HStack {
                    if showTitle {
                        Text(link.title)
                            .font(.title2.bold())
                            .foregroundColor(Color("background"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Spacer()
                    }
                    
                    Image(systemName: link.logo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(showTitle ? Color("background") : Color("yellow"))
                }
                .padding(.horizontal, 15)
                .frame(height: 80)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension View {
    func getScreenSize() -> CGRect {
        return UIScreen.main.bounds
    }
}

// MARK: ScrollView Content Offset
struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                }
            }
            .onPreferenceChange(OffsetKey.self) { value in
                self.offset = value
            }
    }
}

// MARK: Content Offset Preference Key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
