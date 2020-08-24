//
//  ZYLandmarkList.swift
//  ibhs
//
//  Created by developer on 2020/8/20.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct ZYLandmarkList: View {
    ///是否只显示收藏的
//    @State var showFavoritesOnly = true
    @EnvironmentObject var userData:UserData
    
    
    var body: some View {
//        List {
//            ZYLandmarkRow(landmark: landmarkData[0])
//            ZYLandmarkRow(landmark: landmarkData[1])
//        }
        
        
//        NavigationView {
//            List.init(landmarkData) {landmark in
//                if !self.showFavoritesOnly || landmark.isFavorite {
//                    NavigationLink.init(destination: ZYLandmarkDetail(landmark: landmark)) {
//                        ZYLandmarkRow(landmark: landmark)
//                    }
//                }
//            }
//            .navigationBarTitle(Text("Landmarks"))
            
            List {
                
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(userData.landmarks) {landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink.init(destination: ZYLandmarkDetail(landmark: landmark)) {
                            ZYLandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Landmarks"))

            
        }
//    }
}

struct ZYLandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZYLandmarkList()
                .environmentObject(UserData())
        }

//        ForEach(["iPhone SE", "iPhone XS Max", "iPad Pro (12.9-inch)"], id: \.self) { deviceName in
//            ZYLandmarkList()
//                .environmentObject(UserData())
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
    }
}
