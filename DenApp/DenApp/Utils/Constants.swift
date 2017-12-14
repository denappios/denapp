//
//  Constants.swift
//  DenApp
//
//  Created by Pelorca on 05/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import Foundation


class Constants {
    
    public static let emailKey:String =  "emailKey"
    public static let password:String =  "passwordKey"
    
    static let rangeRadius = "RangeRadius"
    static let favoriteType = "FavoriteType"
    static let getNotification = "GetNotification"
      static let USER_ID = "USER_ID"
    
}

class Authenticate {
    static func setAuthenticate(user: String) {
        UserDefaults.standard.set(user, forKey: Constants.USER_ID)
    }
    
    static func getAuthenticate() -> Bool {
        guard UserDefaults.standard.object(forKey: Constants.USER_ID) != nil else {
            return false
        }
        return true
    }
    
}
