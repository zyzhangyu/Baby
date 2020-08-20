//
//  ZYLandmarkList.swift
//  ibhs
//
//  Created by developer on 2020/8/20.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct ZYLandmarkList: View {
    var body: some View {
//        List {
//            ZYLandmarkRow(landmark: landmarkData[0])
//            ZYLandmarkRow(landmark: landmarkData[1])
//        }
        
        NavigationView {
            List.init(landmarkData) {landmark in
                NavigationLink.init(destination: ZYLandmarkDetail(landmark: landmark)) {
                    ZYLandmarkRow(landmark: landmark)
                }
            }
            .navigationBarTitle(Text("Landmarks"))
        }
    }
}

struct ZYLandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max", "iPad Pro (12.9-inch)"], id: \.self) { deviceName in
            ZYLandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
