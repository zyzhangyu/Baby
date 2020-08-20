//
//  ZYLandmarkRow.swift
//  ibhs
//
//  Created by developer on 2020/8/20.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct ZYLandmarkRow: View {
    
    var landmark:Landmark
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
            Text(landmark.name)
            Spacer()
        }
    }
}

struct ZYLandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZYLandmarkRow(landmark: landmarkData[0])
                .previewLayout(.fixed(width: 300, height: 100))
            ZYLandmarkRow(landmark: landmarkData[1])
                .previewLayout(.fixed(width: 300, height: 100))
            ZYLandmarkRow(landmark: landmarkData[2])

        }
        .previewLayout(.fixed(width: 400, height: 100))

    }
}
