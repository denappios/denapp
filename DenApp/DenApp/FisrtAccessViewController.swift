//
//  FisrtAccessViewController.swift
//  DenApp
//
//  Created by Pelorca on 05/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit

class FisrtAccessViewController: UIViewController {
    

    
    @IBOutlet weak var txtConfirmaPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        if txtPassword.text == txtConfirmaPassword.text {
            
            MsgAlert().alert("Usuário cadastrado com sucesso", "DenApp", .success)
            //self.navigationController?.popViewController(animated: true)
     } else {
           MsgAlert().alert("Campo senhas diferentes", "DenApp", .error)
            }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
}
