//
//  FisrtAccessViewController.swift
//  DenApp
//
//  Created by Pelorca on 05/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit

class FisrtAccessViewController: UIViewController {
    

    
    @IBOutlet weak var txtConfirmaPassword: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    
    @IBOutlet weak var txtEmail: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        if txtPassword.text == txtConfirmaPassword.text {
            KeyChain.save(key: Constants.emailKey, data: Data(from: txtEmail.text))
            KeyChain.save(key: Constants.password, data: Data(from: txtPassword.text))
            let alert = UIAlertController(title: "DenApp", message: "Usuário cadastrado com sucesso", preferredStyle: UIAlertControllerStyle.alert)
            
             alert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true, completion: nil)
        } else {
        
            let alert = UIAlertController(title: "Alerta", message: "Campo senhas diferentes", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
}
