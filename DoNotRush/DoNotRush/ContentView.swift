//
//  ContentView.swift
//  DoNotRush
//
//  Created by developer on 2020/9/10.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI
 


struct ContentView: View {
    
    @State var isPushPage: Bool = false
 
    @ObservedObject var locationManager:UseLocationWithViewModel = UseLocationWithViewModel.init()

    
    

    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                             
                Text("Hurt your kidneys.")
                    .font(.system(size: 34))
                    .bold()
                    .padding(.leading,20)
                
  
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button.init(action: {
                      
                        print("点击跳转下一个页面")
                        isPushPage = true
                        
                        locationManager.stratLocation()
                    }) {
                        Image.init("right-arrow")
                            .resizable()
                            .renderingMode(.original)
//                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .padding(.trailing)
                        
//                        Spacer.init(minLength: 30)
                    }
                    NavigationLink.init(
                        destination: InfoRootView(),
                        isActive: $isPushPage,
                        label: {}
                    )

                }
            }
            .onAppear(perform: {
            })
            .navigationBarTitle("Don't")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
   
    static var isF = false

    static var previews: some View {
        ContentView(isPushPage:isF, locationManager: (UseLocationWithViewModel.init()))
    }
}
