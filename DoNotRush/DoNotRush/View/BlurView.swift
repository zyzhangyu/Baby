//
//  BlurView.swift
//  DoNotRush
//
//  Created by developer on 2020/10/15.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI


struct BlurView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    
    var style:UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView.init(frame: CGRect.zero)
        ///确保背景没有任何颜色
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect.init(style: style)
        
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    
        
    
}

 
