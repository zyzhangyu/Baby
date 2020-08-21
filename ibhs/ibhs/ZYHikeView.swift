//
//  ZYHikeView.swift
//  ibhs
//
//  Created by developer on 2020/8/21.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

//
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.slide
        
//        AnyTransition.move(edge: .trailing)
        
        
//        let insertion = AnyTransition.move(edge: .trailing)
//            .combined(with: .opacity)
//        let removal = AnyTransition.scale
//            .combined(with: .opacity)
//        return .asymmetric(insertion: insertion, removal: removal)

    }
}
struct ZYHikeView: View {
    
    var hike: ZYHike
    @State private var showDetail = false
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)
//                    .scaleEffect(1.0, anchor: .top)
                

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button(action: {
                    withAnimation(.easeInOut(duration: 0.4)) {
                         self.showDetail.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                        //
//                        .animation(.spring())
                        //
                }
            }
            if showDetail {
                 ZYHikeDetail(hike: hike)
                    .transition(.moveAndFade)
             }
        }
    }
}

struct ZYHikeView_Previews: PreviewProvider {
    static var previews: some View {
        ZYHikeView(hike: hikeData[0])
    }
}
