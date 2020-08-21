//
//  ZYRotatedBadgeSymbol.swift
//  ibhs
//
//  Created by developer on 2020/8/21.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct ZYRotatedBadgeSymbol: View {
    let angle: Angle

    var body: some View {
        ZYBadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom)
    }
}

struct ZYRotatedBadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        ZYRotatedBadgeSymbol(angle: .init(degrees: 5))
    }
}
