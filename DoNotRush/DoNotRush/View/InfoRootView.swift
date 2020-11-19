//
//  InfoRootView.swift
//  DoNotRush
//
//  Created by developer on 2020/10/13.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI


struct InfoRootView: View  {
    ///为了导航栏能够返回而存在 配合下面自定义的backButton 实现返回上一页功能
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image.init(systemName: "chevron.left")// BackButton Image
                .aspectRatio(contentMode: .fit)
                Text("back") //translated Back button title
            }
        }
    }
    
    
    var body: some View {

        InfoView()
                .onAppear(perform: {
                })
                .navigationBarTitle("Before Rush",displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
   
    }
    

}

struct InfoRootView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRootView()
    }
}


