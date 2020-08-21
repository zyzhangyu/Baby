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
        Dictionary(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }
    
    var body: some View {
        NavigationView {
//            Text("Landmarks Content")
//                .navigationBarTitle(Text("Featured"))
            //
            List {
                ForEach(categories.keys.sorted(), id: \.self) { key in
                    Text(key)
                }
            }
            .navigationBarTitle(Text("Featured"))

        }
        
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
