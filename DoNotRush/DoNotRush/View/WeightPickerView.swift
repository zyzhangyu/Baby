//
//  WeightPickerView.swift
//  DoNotRush
//
//  Created by developer on 2020/10/13.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct WeightPickerView: View {
    typealias Label = String
    typealias Entry = String
    let data: [ (Label, [Entry]) ] =
        [("One", Array(35...150).map{"\($0)"}),
                ("Two",Array(0...9).map({"\($0)"}))]
    @Binding var seletion:[Entry]
    
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                Text("请选择您目前的体重:").frame(height: 30)
                Text("\(seletion[0]).\(seletion[1]) KG")
                HStack {
                    Spacer()
                    Picker.init(selection: self.$seletion[0], label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: /*@START_MENU_TOKEN@*/{
                        ForEach(0..<self.data[0].1.count) { row in
                            Text(verbatim: self.data[0].1[row])
                                .tag(self.data[0].1[row])
                        }
                    }/*@END_MENU_TOKEN@*/)
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / 4.0
                           , height:200)
                    .clipped()
                    
                    Text(".")
                        .font(.body)
                    
                    Picker.init(selection: self.$seletion[1], label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: /*@START_MENU_TOKEN@*/{
                        ForEach(0..<self.data[1].1.count) { row in
                            Text(verbatim: self.data[1].1[row])
                                .tag(self.data[1].1[row])
                        }
                    }/*@END_MENU_TOKEN@*/)
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / 4.0
                           , height: 200)
                    .clipped()
                    
                    Text("KG").font(.largeTitle)
                    Spacer()
                }
                Spacer()
            }
            
        }
    }
}

struct WeightPickerView_Previews: PreviewProvider {
    
    struct BindingTestHolder: View {
   
        @State var selection: [String] = [0, 20, 100].map { "\($0)" }
        
        var body: some View {
            VStack {
                HStack {
                    WeightPickerView(seletion: $selection)
                }
                
                Text(selection[0])
                Text(selection[1])
            }
      
            
            
            
        }
  
     }
    
    static var previews: some View {
        BindingTestHolder()
    }
}
