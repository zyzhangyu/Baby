//
//  ZYHikeDetail.swift
//  ibhs
//
//  Created by developer on 2020/8/21.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct ZYHikeDetail: View {
    let hike: ZYHike
    @State var dataToShow = \ZYHike.Observation.elevation
    
    var buttons = [
        ("Elevation", \ZYHike.Observation.elevation),
        ("Heart Rate", \ZYHike.Observation.heartRate),
        ("Pace", \ZYHike.Observation.pace),
    ]
    
    
    
    var body: some View {
        return VStack {
            HikeGraph(hike: hike, path: dataToShow)
                .frame(height: 200)
            
            HStack(spacing: 25) {
                Button(action: {
                    self.dataToShow = self.buttons[0].1
                    print("heiheihei0")

                        }) {
                                Text(buttons[0].0)
                                    .font(.system(size: 15))
                                    .foregroundColor(buttons[0].1 == self.dataToShow
                                        ? Color.gray
                                        : Color.accentColor)
                                    .animation(nil)
                }
                
                Button(action: {
                          self.dataToShow = self.buttons[1].1
                    print("heiheihei1")

                              }) {
                                      Text(buttons[1].0)
                                          .font(.system(size: 15))
                                          .foregroundColor(buttons[1].1 == self.dataToShow
                                              ? Color.gray
                                              : Color.accentColor)
                                          .animation(nil)
                      }
                
                
                
                Button(action: {
                    print("heiheihei2")
                          self.dataToShow = self.buttons[2].1
                              }) {
                                      Text(buttons[2].0)
                                          .font(.system(size: 15))
                                          .foregroundColor(buttons[2].1 == self.dataToShow
                                              ? Color.gray
                                              : Color.accentColor)
                                          .animation(nil)
                      }
                
            
            }

                
                
            
        }
    }
}

struct ZYHikeDetail_Previews: PreviewProvider {
    static var previews: some View {
        ZYHikeDetail(hike: hikeData[0])
    }
}
