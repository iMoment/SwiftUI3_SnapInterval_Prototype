//
//  HomeView.swift
//  SnapInterval
//
//  Created by Stanley Pan on 2022/01/28.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ScrollContent()
                .padding(.top, getScreenSize().height / 3)
                .padding(.bottom, CGFloat(links.count - 1) * 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        // MARK: Overlay Masking View
        .background(
            Color("yellow")
                .frame(height: 80)
                .padding(.top, getScreenSize().height / 3)
            ,alignment: .top
        )
        .background(Color("background"))
    }
    
    @ViewBuilder
    func ScrollContent(showTitle: Bool = false) -> some View {
        VStack(spacing: 0) {
            ForEach(links) { link in
                HStack {
                    if showTitle {
                        Text(link.title)
                            .font(.title2.bold())
                            .foregroundColor(Color("background"))
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
