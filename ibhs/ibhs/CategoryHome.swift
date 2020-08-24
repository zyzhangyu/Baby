//
//  CategoryHome.swift
//  ibhs
//
//  Created by developer on 2020/8/21.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    
    //
    var categories: [String: [Landmark]] {
        ///通过group by把地标 组合到分类中
        Dictionary(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }
    
    var featured:[Landmark] {
        landmarkData.filter {$0.isFeatured}
    }
    
    @State var showingProfile = false
    @EnvironmentObject var userData:UserData

    var profileButton: some View {
         Button(action: { self.showingProfile.toggle() }) {
             Image(systemName: "person.crop.circle")
                 .imageScale(.large)
                 .accessibility(label: Text("User Profile"))
                 .padding()
         }
     }
    
    var body: some View {
        NavigationView {
            List {
//                FeaturedLandmarks(landmarks: featured)
//                    .scaledToFill()
//                    .frame(height: 200)
//                    .clipped()
//                    .listRowInsets(EdgeInsets())
                
                PageView(features.map { FeatureCard(landmark: $0) })
                     .aspectRatio(3/2, contentMode: .fit)
//                     .frame(height: 200)
//                     .scaledToFill()
                     .clipped()
                     .listRowInsets(EdgeInsets())
                
                ForEach(categories.keys.sorted(), id: \.self) { key in
                    CategoryRow.init(categoryName: key, items: self.categories[key]!)
                    
                }
                .listRowInsets(EdgeInsets())
                
                NavigationLink.init(destination: ZYLandmarkList()){
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Featured"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(self.userData)
            }
        }
    }
}

//
struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    var body: some View {
        landmarks[0].image.resizable()
    }
}


struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
        .environmentObject(UserData())

    }
}
