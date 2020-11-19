//
//  MenuView.swift
//  DoNotRush
//
//  Created by developer on 2020/10/16.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        
        VStack {
            Spacer()
             VStack(spacing: 16) {
                
                Text("George - 28% Complete")
                    .font(.caption)
                
                Color.white
                    .frame(width:38, height: 6)
                    .cornerRadius(3)
                    .frame(width:130, height: 6, alignment: .leading)
                    .background(Color.black)
                    .cornerRadius(3)
                    .padding()
                    .frame(width:150, height:24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                    
                
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign Out", icon: "person.crop.circle")
                    .onTapGesture(perform: {
                        ///点击就设置为未登录状态
                        UserDefaults.standard.set(false, forKey: "isLogged")
                    })
            }
            .frame(maxWidth: 500)
            .frame(height: 300)
            .background(BlurView.init(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Image.init("rush_card_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:60, height:60)
                    .clipShape(Circle())
                    .offset(y:-150)
                    
            )
        }
        .padding(.bottom, 30)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}



struct MenuRow:View {
    var title:String
    var icon:String
    
    var body : some View {
        HStack(spacing: 16) {
            Image.init(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.5577465027, green: 0.6000000238, blue: 0.7197183337, alpha: 1)))
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 120, alignment: .leading)
        }
    }
}
