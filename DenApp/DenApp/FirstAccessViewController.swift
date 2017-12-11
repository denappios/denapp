//
//  FisrtAccessViewController.swift
//  DenApp
//
//  Created by Pelorca on 05/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Firebase


class FirstAccessViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmaPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func save(_ sender: UIButton) {
        
        if self.txtPassword.text! == self.txtConfirmaPassword.text! {
        
            Auth.auth().createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user, error) in
                
                print("User: \(user)")
                print("User: \(error)")
                
                if error != nil {
                    MsgAlert().alert("Erro ao cadastrar e-mail", "DenApp", .error)
                } else {
                    MsgAlert().alert("Usuário cadastrado com sucesso", "DenApp", .success)
                }
            }
            
        } else {
            MsgAlert().alert("Campo senhas diferentes", "DenApp", .error)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
}
