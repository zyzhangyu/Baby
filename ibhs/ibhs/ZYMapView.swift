//
//  ZYMapView.swift
//  ibhs
//
//  Created by developer on 2020/8/19.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI
import MapKit

struct ZYMapView: UIViewRepresentable {
    
    var coordinate:CLLocationCoordinate2D
    
    ///UIViewRepresentable协议的方法之一
    func makeUIView(context: Context) -> MKMapView  {
        MKMapView.init(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
                
        let span = MKCoordinateSpan.init(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion.init(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct ZYMapView_Previews: PreviewProvider {
    static var previews: some View {
        ZYMapView.init(coordinate: landmarkData[0].locationCoordinate)
    }
}
