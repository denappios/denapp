//
//  ViewController.swift
//  DenApp
//
//  Created by Pelorca on 05/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func btnLogin(_ sender: Any) {
        let email: String? = KeyChain.load(key: Constants.emailKey, type: String.self)
        
        let pass: String? = KeyChain.load(key: Constants.password, type: String.self)
        
        if email != txtEmail.text || pass != txtPassword.text {
            txtEmail.borderActiveColor = UIColor.red
            txtPassword.borderActiveColor = UIColor.red
            msgAlert("Email ou Password incorretos.")
        }
         else {
            txtEmail.borderActiveColor = UIColor.blue
            txtPassword.borderActiveColor = UIColor.blue
            msgAlert("Sucesso")
        }
     }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func msgAlert(_ msg: String) {
        
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}
