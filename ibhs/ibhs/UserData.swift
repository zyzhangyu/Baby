//
//  UserData.swift
//  ibhs
//
//  Created by developer on 2020/8/20.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI
import Combine

final class UserData:ObservableObject {
     
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
