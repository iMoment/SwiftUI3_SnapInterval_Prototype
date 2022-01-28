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
            
            VStack(spacing: 0) {
                ForEach(links) { link in
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: link.logo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color("yellow"))
                            
                    }
                    .padding(.horizontal, 15)
                    .frame(height: 80)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
