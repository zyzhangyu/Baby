//
//  ContentView.swift
//  ibhs
//
//  Created by developer on 2020/8/19.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

///描述内容和布局
struct ZYLandmarkDetail: View {
    
    var landmark:Landmark
    
    var body: some View {
        VStack {
            ZYMapView(coordinate: landmark.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(width: nil, height: 300)
            
            ZYCircleImage(image: landmark.image)
                .offset(x: 0, y: -130)
                .padding(.bottom, -130)
                
            VStack(alignment: .leading, spacing: nil) {
                Text("Turtle Rock")
                    .font(.title)
                    .foregroundColor(.green)
                HStack {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
            }

            .padding()
            Spacer()
        }
        .navigationBarTitle(Text(landmark.name), displayMode: .inline)

    }
}

///生命该视图的预览
struct ZYLandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        ZYLandmarkDetail(landmark: landmarkData[10])
    }
}
