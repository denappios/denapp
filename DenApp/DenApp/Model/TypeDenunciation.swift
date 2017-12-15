//
//  TypeDenunciation.swift
//  DenApp
//
//  Created by Aloc SP08609 on 14/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import Foundation

enum TypeDenunciation {
    
    case FIRE
    case ACCIDENT
    case CRIME
    case WILD_ANIMALS
    
    static func getValues(id: Int) -> TypeDenunciation {
        switch id {
        case 1:
            return TypeDenunciation.FIRE
        case 2:
            return TypeDenunciation.ACCIDENT
        case 3:
            return TypeDenunciation.CRIME
        case 4:
            return TypeDenunciation.WILD_ANIMALS
        default:
            return TypeDenunciation.FIRE
        }
    }
    
    func getCode() -> Int {
        switch self {
        case .FIRE:
            return 1
        case .ACCIDENT:
            return 2
        case .CRIME:
            return 3
        case .WILD_ANIMALS:
            return 4
    }
    }
}
