//
//  InfoView.swift
//  DoNotRush
//
//  Created by developer on 2020/10/13.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

enum RushReason:CaseIterable {
    case idea, meida, text, game, no_reason,other
}

extension RushReason {
    var text : String {
        switch self {
        case .idea:
            return "A flash of wisdom"
        case .meida:
            return "Voice and Video"
        case .text:
            return "Tekst (fictie, nieuws, kranten, artikelen)"
        case .game:
            return "Games"
        case .other:
            return "Other"
        case .no_reason:
            return "No reason. Just wanted to have a go."
        }
    }
}

enum RushFeel:CaseIterable {
    case worst, bad , normal, good, superlative
}

extension RushFeel {
    var text:String {
        switch self {
        case .worst:
            return "worst"
        case .bad:
            return "bad"
        case .normal:
            return  "normal"
        case .good:
            return "good"
        case .superlative:
            return "superlative"
        }
    }
}

struct InfoView: View {
    
    
    @State var date = Date()
    @State var reason = RushReason.idea
    @State var isPersonMore = false
    @State var weight: Double = 0 // create State
    var colors = [1...100]
    @State var favoriteColor = 0
    @State var weightSelection: [String] = ["50", "0"]
    @State var age = 27
    @State var feel = RushFeel.normal
    
    @State var otherReason = ""
    
    @State var cardXOffset = 400;
    
    @State var isCreatedCard = false

    func getDate(date:Date)->String{
       let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "MM月dd日"
       let stringDate = timeFormatter.string(from: date)
       return stringDate
      }
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            
            if self.isCreatedCard == false {
                Form.init(content: {
                    Section.init(header: Text("Why do you want to hand-job??")) {
                        Picker.init(selection: $reason, label: Text("Beacuse")) {
                            ForEach(RushReason.allCases, id:\.self) {
                                Text($0.text)
                            }
                        }

                        if reason == RushReason.other {
                            TextField.init("You can write the real reason here.", text: $otherReason)
                        }
                    }
                    Section.init(header: Text("Person Info(Only need to fill in once.)")) {
                        Toggle.init("个人信息", isOn: $isPersonMore)
                        NavigationLink.init(
                            destination: WeightPickerView.init(seletion: $weightSelection),
                            label: {
                                Button.init(action: {
                                    print("点击跳转选择体重页面")
                                }, label: {
                                    HStack {
                                        Text("体重").foregroundColor(.black)
                                        Spacer()
                                        Text("\(weightSelection[0]).\(weightSelection[1])KG").accentColor(.black)
                                    }
                                })
                            })
                        Picker.init("年龄", selection: $age) {
                            ForEach(13...60, id:\.self) { item in
                                Text("\(item)")
                            }
                        }
                    }
                })
                .frame(maxHeight:320)
                
                Button.init(action: {
                    self.isCreatedCard = true
                }, label: {
                    Text("Creat Card")
                })
                .frame(height:40)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("background3"))
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding(.horizontal)
//                .padding(isCreatedCard ? 300 : 0)
                .animation(Animation.default)
                
            } else {
                
                            RushCardViewItem()
                                .background(Color("background4"))
                                .offset(x:CGFloat(cardXOffset))
                                .onAppear(perform: {
                                    cardXOffset = 0
                                })
                                .padding()
                                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                                .animation(Animation.easeInOut(duration: 0.3))
            }
            
            

            
//            .background(Color("background4"))

            
//            .offset(y: -230)
            

            
            
            
            
//                .padding(.bottom,250)
            Spacer()
            
            
        

        }
        .background(Color("background4"))
        
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

