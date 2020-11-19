//
//  RushCardView.swift
//  DoNotRush
//
//  Created by developer on 2020/10/14.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

struct RushCardView: View {
    
    @State var showBottomCard = false
    @State var showDragAnimation = false
    @State var dragViewState = CGSize.zero
    @State var bottomViewState = CGSize.zero
    @State var isShowFull = false
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: showDragAnimation ? 20 : 0)
                .opacity(showBottomCard ? 0.4 : 1)
                .offset(y: showBottomCard ? -200 : 0)
                .animation(Animation.default.delay(0.1).speed(1.3))

            BackCardView()
                .frame(maxWidth: showBottomCard ? 300 : 400)
                .frame(height:249.6)
                .background( showDragAnimation ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .offset(x:0)
                .offset(y: showDragAnimation ? -140 : 0)
                .offset(y: showBottomCard ? -140 :  -40)
                .offset(x: dragViewState.width, y: dragViewState.height)
                ///按照比例修改
                .scaleEffect(showBottomCard ? 1 : 0.9)
                .rotationEffect(Angle.init(degrees: showBottomCard ? 0 : 10))
                .rotationEffect(Angle.init(degrees: 0))
                .rotation3DEffect(
                    Angle.init(degrees: showBottomCard ? 0 : 10),
                    axis: (x: showBottomCard ? 0 : 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))


            BackCardView()
                .frame(maxWidth: 380)
                .frame(height:249.6)
                .background(Color.blue)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x:0)
                .offset(y:-20)
                .offset(y: showDragAnimation ? -70 : 0)
                .offset(y: showBottomCard ? -70 : 0)
                .offset(x: dragViewState.width, y: dragViewState.height)

                ///按照比例修改
                .scaleEffect(0.95)
                .rotationEffect(Angle.init(degrees: showBottomCard ? 0 : 5))
                .rotationEffect(Angle.init(degrees: 0))
                .rotation3DEffect(
                    Angle.init(degrees: 5),
                    axis: (x: 5.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            

            RushCardViewItem()
                .shadow(radius: 20)
                .offset(x: dragViewState.width, y: dragViewState.height)
                .onTapGesture {
                    self.showBottomCard.toggle()
                }
                .gesture(DragGesture().onChanged { value in
                    self.dragViewState = value.translation
                    self.showDragAnimation = true
                }
                .onEnded {value in
                    self.showDragAnimation = false
                    self.dragViewState = .zero
                }
            )
            
            
                
                
            GeometryReader {bounds in
                BottomCardView(show: self.$showBottomCard     )
                    .offset(x: 0,
                            y: self.showBottomCard ? bounds.size.height / 2 : bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom)
                    .offset(y: self.bottomViewState.height)
                    .blur(radius: self.showDragAnimation ? 20 : 0)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                    .gesture(
                        DragGesture().onChanged({ (value) in
                            
                            self.bottomViewState = value.translation
                            if self.isShowFull {
                                self.bottomViewState.height += -300
                            }
                            if self.bottomViewState.height < -300 {
                                self.bottomViewState.height = -300
                            }
                        })
                        .onEnded{ value in
                            if self.bottomViewState.height > 50 {
                                self.showBottomCard = false
                            }
                            ///没有向上 并且不是全屏模式 或者  向下 下上小于250 并且是全屏
                            if (self.bottomViewState.height < -100 && !self.isShowFull)  || (self.bottomViewState.height < -250 && self.isShowFull) {
                                self.bottomViewState.height = -300
                                self.isShowFull = true
                            }else {
                                self.bottomViewState = .zero
                                self.isShowFull = false
                            }
                        }
                    )
                
                
            }
            
         
        }
        
      
       
    }
}


struct RushCardViewItem:View {
    var body:some View {
        ZStack {
            Image.init("rush_card_background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .frame(width:400,height:249.6)
                .animation(Animation.default.delay(0.05))
            VStack {
                HStack {
                    Image.init("line_kidney")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150,height: 70)
                        .padding(.top, 20)
                    Spacer()
                    Text("KIDENTY BANK")
                        .font(.custom("LiSu", size: 18))
                        .padding()
                }
                .animation(Animation.default.delay(0.1))

                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Why my design so uglu")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .padding(.bottom, 3)
                        
                        Text("ShangHai City MinHang Area YanZhi Road")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }.padding(.leading,20)
                    Spacer()
                }
                .animation(Animation.default.delay(0.15))
                .padding(.bottom, 15)
                    HStack {
                        VStack {
                            Text("BODY WEIGHT")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .fontWeight(.light)

                            Text("50.00KG")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
                        }
                        .animation(Animation.default.delay(0.3))
                        .padding(.leading,20)
                        Spacer()
                        VStack {
                            Text("DATE")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .fontWeight(.light)
                            Text("10/14")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
                        }
                        .animation(Animation.default.delay(0.4))

                        Spacer()
                        VStack {
                            Text("AGE")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .fontWeight(.light)
                            Text("27")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
                        }
                        .animation(Animation.default.delay(0.45))

                        Spacer()
                    }.padding(.bottom, 20)
             }
        }
        .frame(width:400,height:249.6)
    }
}

struct BackCardView: View {
    var body: some View {
        ZStack {
            VStack{
                Spacer()
            }
        }
    }
}

struct TitleView:View {
    var body: some View {
        VStack {
            HStack {
                Text("Certifications")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            
            Image("Background1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth:375)
            Spacer()
        }
    }
}


struct BottomCardView:View {
    
    @Binding var show:Bool
    
    var body:some View {
        VStack(spacing:20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: 712)
        .background(BlurView.init(style: .systemThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20 )
        .frame(maxWidth: .infinity)
//        .frame(height:0)
    }
}

struct RushCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RushCardView()
        }
    }
}
