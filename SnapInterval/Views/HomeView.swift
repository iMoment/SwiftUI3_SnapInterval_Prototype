//
//  HomeView.swift
//  SnapInterval
//
//  Created by Stanley Pan on 2022/01/28.
//

import SwiftUI

struct HomeView: View {
    @State var offset: CGFloat = 0
    @State var delegate = ScrollViewDelegate()
    
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
        .ignoresSafeArea()
        // MARK: ScrollView Coordinate Namespace
        .coordinateSpace(name: "SCROLL")
        // MARK: Setting Delegate
        .onAppear {
            UIScrollView.appearance().delegate = delegate
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().delegate = nil
            UIScrollView.appearance().bounces = true
        }
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
        .padding(.top, getSafeArea().top)
        .padding(.bottom, getSafeArea().bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// MARK: ScrollView Delegate Manager (Not UIKit approach)
class ScrollViewDelegate: NSObject, ObservableObject, UIScrollViewDelegate {
    @Published var snapInterval: CGFloat = 80
    
    // MARK: Offset also can be fetched here
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
    }
    
    // MARK: ScrollView fires EndDecelerating when scrolling fast
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let target = scrollView.contentOffset.y
        let condition = (target / snapInterval).rounded(.toNearestOrAwayFromZero)
        
        print(condition)
        scrollView.setContentOffset(CGPoint(x: 0, y: snapInterval * condition), animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let target = targetContentOffset.pointee.y
        let condition = (target / snapInterval).rounded(.toNearestOrAwayFromZero)
        
        print(condition)
        scrollView.setContentOffset(CGPoint(x: 0, y: snapInterval * condition), animated: true)
    }
}

extension View {
    func getScreenSize() -> CGRect {
        return UIScreen.main.bounds
    }
    
    // MARK: Get SafeArea Value
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
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
