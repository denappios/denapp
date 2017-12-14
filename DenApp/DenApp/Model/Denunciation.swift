//
//  Denunciation.swift
//  DenApp
//
//  Created by Aloc SP08609 on 14/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

class Denunciation {
    
    var id:String?
    var title : String?
    var date : String?
    var latitude: Double?
    var longitude: Double?
    var DenunciationDescription : String?
    var listImagens : [UIImage] = [UIImage]()
    var type : TypeDenunciation?
    let position = GMSMarker()
    
    init() {}
}

extension GMSMarker {
    func toDenuciation() -> Denunciation {
        let denunciation = Denunciation()
        denunciation.title = self.title
        denunciation.DenunciationDescription = self.description
        denunciation.date = ""
        
        return denunciation
    }
}
