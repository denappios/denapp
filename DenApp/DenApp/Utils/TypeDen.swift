//
//  TypeDen.swift
//  DenApp
//
//  Created by Pelorca on 13/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import Foundation
import UIKit

class TypeDen {
    
    
   static func indentifyType(_ id: Int) -> UIImage {
        
        switch id {
            case 1:
                return #imageLiteral(resourceName: "iconFire")
            case 2:
                return #imageLiteral(resourceName: "iconAccident")
            case 3:
                return #imageLiteral(resourceName: "iconCrime2")
            case 4:
                return #imageLiteral(resourceName: "iconWildAnimals")
            default:
                return UIImage(named: "nothing")!
            }
    }
    
    
    
    
    
}
