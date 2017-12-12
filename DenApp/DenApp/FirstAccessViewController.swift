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
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmaPassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Criando referência para o banco de dados
        ref = Database.database().reference()

    }
    
    
    @IBAction func save(_ sender: UIButton) {
        
        if self.txtPassword.text! == self.txtConfirmaPassword.text! {
        
            Auth.auth().createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user, error) in
                
                print("User: \(user)")
                print("User: \(error)")
                
                if error != nil {
                    MsgAlert().alert("Erro ao cadastrar e-mail", "DenApp", .error)
                } else {
                    
                    let userId = String(arc4random())
                    
                    self.ref.child("users").child(userId).setValue(["email": self.txtEmail.text!, "password": self.txtPassword.text!])
                    
                    self.ref.child("pins").child(userId).setValue(["type" : "accident", "lat": arc4random(), "lon": arc4random()])
                    
                    
                    let pinsRef = self.ref.child("pins")
                    
                    pinsRef.observe(DataEventType.value, with: { (snapshot) in
                    
                        let pinsDict = snapshot.value as? [String : AnyObject] ?? [:]
                        
                        for pin in pinsDict {
                            
                            
                            
                        }
                        
                    })
                    
                        
                    
                    
                    pinsRef.observe(DataEventType.value, with: { (snapshot) in
                        
                        if snapshot.childrenCount > 0 {
                            
                            print("snap.childrenCount \(snapshot.childrenCount)")
                            
                            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                                //iterating through all the values
                                
                                print("snapshots.count \(snapshots.count)")
                                
                                for snap in snapshots {
                                    //getting values
                                    
                                    print("snap.key \(snap.key)")
                                    print("snap.value \(snap.value as? [String:String])")
                                    
                                    let values = snap.children.allObjects as! [DataSnapshot]
                                    
                                    print("\(values[0].key) \(values[0].value as! Int)")
                                    print("\(values[1].key) \(values[1].value as! Int)")
                                    print("\(values[2].key) \(values[2].value as! String)")

                                }
                                
                            }
        
                            
                        } else {
                            print("vazio")
                        }
                        
                    })
                    
                    
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
