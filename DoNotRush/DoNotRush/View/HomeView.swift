//
//  HomeView.swift
//  DoNotRush
//
//  Created by developer on 2020/10/16.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var isShowMenuView = false
    @State var menuViewState = CGSize.zero
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .modifier(CustomFontModifier(size: 35))
                Spacer()
                
                Button.init(action: {
                    self.isShowMenuView.toggle()
                }, label: {
                    Image.init(systemName: "bell")
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color("background3"))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                })
           
            }.padding()
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: isShowMenuView ? 0 : UIScreen.main.bounds.height)
                .offset(y: menuViewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture(perform: {
                    self.isShowMenuView.toggle()
                })
                .gesture(
                    DragGesture().onChanged{value in
                                            
                        self.menuViewState = value.translation
                    }
                    .onEnded {value in
                        if self.menuViewState.height > 50 {
                            self.isShowMenuView = false
                        }
                        self.menuViewState = .zero
                    }
                )
                
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
