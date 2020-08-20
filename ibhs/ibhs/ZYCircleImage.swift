//
//  ZYCircleImage.swift
//  ibhs
//
//  Created by developer on 2020/8/19.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct ZYCircleImage: View {
    var image:Image
    var body: some View {
        image
            ///将图片裁剪成圆形
            .clipShape(Circle())
            ///添加边框
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
//            .overlay(Circle().fill(Color.red, style: FillStyle.init()))
            ///添加一个半径为10的阴影
            .shadow(radius: 10)
    }
}

struct ZYCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ZYCircleImage(image: Image("turtlerock"))
    }
}
