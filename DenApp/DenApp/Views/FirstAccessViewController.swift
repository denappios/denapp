//
//  FisrtAccessViewController.swift
//  DenApp
//
//  Created by Pelorca on 05/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class FirstAccessViewController: UIViewController {
    
    
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmaPassword: UITextField!
    
    var ref: DatabaseReference!
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Criando referência para o banco de dados
        ref = Database.database().reference()

    }
    
    
    @IBAction func save(_ sender: UIButton) {
        
        if self.txtPassword.text! == self.txtConfirmaPassword.text! {
        
            Auth.auth().createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user, error) in
                
                let userId = Auth.auth().currentUser?.uid
                
                Repository.saveUser(uid: userId!, email: self.txtEmail.text!)
                
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
