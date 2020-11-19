//
//  MutilePicker.swift
//  DoNotRush
//
//  Created by developer on 2020/10/13.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct MultiPickerView: View {
   
    typealias Label = String
    typealias Entry = String

    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                            .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
        
    }
}



struct MultiPickerView_Previews: PreviewProvider {
    
 
 

    
    
    struct BindingTestHolder: View {
        var data: [(String, [String])] = [
            ("One", Array(0...10).map { "\($0)" }),
            ("Two", Array(20...40).map { "\($0)" }),
            ("Three", Array(100...200).map { "\($0)" })
        ]
        @State var selection: [String] = [0, 20, 100].map { "\($0)" }
        
        var body: some View {
            VStack {
                HStack {
                    MultiPickerView(data:data, selection: $selection)
                }
                
                Text(selection[0])
                Text(selection[1])
                Text(selection[2])
            }
      
            
            
            
        }
  
     }
    
    static var previews: some View {
       
        BindingTestHolder()
    }
}
