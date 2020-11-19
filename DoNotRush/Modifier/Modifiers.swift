//
//  Modifiers.swift
//  DoNotRush
//
//  Created by developer on 2020/10/16.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI


struct CustomFontModifier:ViewModifier {
    
    var size:CGFloat
    
    func body(content: Content) -> some View {
        content.font(.custom("Overpass-ExtraBold", size: size))
    }
}
