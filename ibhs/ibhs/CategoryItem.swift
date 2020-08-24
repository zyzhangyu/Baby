//
//  CategoryItem.swift
//  ibhs
//
//  Created by developer on 2020/8/24.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct CategoryItem: View {
        var landmark: Landmark
        var body: some View {
            VStack(alignment: .leading) {
                landmark.image
                    .renderingMode(.original)
    //            Image.init("turtlerock")
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
                Text(landmark.name)
                    .font(.caption)
            }
            .padding(.leading, 15)
        }
}
 
struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: landmarkData[7])
    }
}
