//
//  ZYGraphCapsule.swift
//  ibhs
//
//  Created by developer on 2020/8/21.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct ZYGraphCapsule: View {
    var index: Int
    var height: CGFloat
    var range: Range<Double>
    var overallRange: Range<Double>
    
    var heightRatio: CGFloat {
        max(CGFloat(magnitude(of: range) / magnitude(of: overallRange)), 0.15)
    }
    
    var offsetRatio: CGFloat {
        CGFloat((range.lowerBound - overallRange.lowerBound) / magnitude(of: overallRange))
    }
    
    var animation:Animation {
//        Animation.spring(dampingFraction: 0.5)
//            .speed(2)
//            .delay(0.03 * Double(index))
        
//        Animation.default
        
        Animation.spring(dampingFraction: 0.5)
        .speed(2)
        .delay(0.03 * Double(index))

    }
    
    var body: some View {
        Capsule()
            .fill(Color.gray)
            .frame(height: height * heightRatio, alignment: .bottom)
            .offset(x: 0, y: height * -offsetRatio)
            .animation(animation)
    }
}

struct ZYGraphCapsule_Previews: PreviewProvider {
    static var previews: some View {
        ZYGraphCapsule(index: 0, height: 150, range: 10..<50, overallRange: 0..<100)
    }
}
