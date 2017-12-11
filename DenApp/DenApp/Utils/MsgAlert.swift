//
//  MessageAlert.swift
//  tabbarCustom
//
//  Created by Pelorca on 09/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import Foundation
import SCLAlertView



class MsgAlert {
    
    func alert(_ message: String, _ title: String, _ type: SCLAlertViewStyle) {
        switch type {
        case .warning:
            SCLAlertView().showWarning(title, subTitle: message, closeButtonTitle: "OK")
        case .success:
            SCLAlertView().showSuccess(title, subTitle: message, closeButtonTitle: "OK")
        case .error:
            SCLAlertView().showError(title, subTitle: message, closeButtonTitle: "OK")
        case .info:
            SCLAlertView().showInfo(title, subTitle: message, closeButtonTitle: "OK")
        default:
            SCLAlertView().showInfo(title, subTitle: message, closeButtonTitle: "OK")
        }
    }
    
    func alertDecision(_ message: String, _ title: String, op:@escaping () -> Void) {
        let alertView = SCLAlertView()
        alertView.addButton("SIM") {
            op()
        }
        alertView.showInfo(title, subTitle: message, closeButtonTitle: "NÃO")
        
        
    }
    
    
}

