//
//  RushStore.swift
//  DoNotRush
//
//  Created by developer on 2020/10/19.
//  Copyright © 2020 developer. All rights reserved.
//

import Combine


class RushStore:ObservableObject {
    
    
    var locationManager:UseLocationWithViewModel = UseLocationWithViewModel.init()
    
    init() {
        
        locationManager.stratLocation()
    }

}

