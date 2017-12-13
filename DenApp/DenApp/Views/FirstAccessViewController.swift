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
                
                print("User: \(user)")
                print("User: \(error)")
                
                if error != nil {
                    MsgAlert().alert("Erro ao cadastrar e-mail", "DenApp", .error)
                } else {
                    
                    let userId = String(arc4random())
                    
                    self.ref.child("users").child(userId).setValue(["email": self.txtEmail.text!, "password": self.txtPassword.text!])
                    
                    self.ref.child("pins").child(userId).setValue(["type" : "accident", "lat": String(arc4random()), "lon": String(arc4random())])
                    
                    
                    let pinsRef = self.ref.child("pins")
                    
                    
                    pinsRef.observe(DataEventType.value, with: { (snapshot) in
                        
                        if snapshot.childrenCount > 0 {
                            
                            print("snap.childrenCount \(snapshot.childrenCount)")
                            
                            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                                //iterating through all the values
                                
                                print("snapshots.count \(snapshots.count)")
                                
                                for snap in snapshots {
                                    //getting values
                                    
                                    //print("snap.key \(snap.key)")
                                    //print("snap.value \(snap.value as? [String:String])")
                                    
                                    let pin = snap.value as? [String:String]
                                    
                                    for fields in pin! {
                                        print("- \(fields.key) \(fields.value)")
                                    }
                                    
                                    /*
                                    let temp = snap.children.allObjects as! [DataSnapshot]
                                    
                                    print("\(temp[0].key) \(temp[0].value as! String)")
                                    print("\(temp[1].key) \(temp[1].value as! String)")
                                    print("\(temp[2].key) \(temp[2].value as! String)")
                                    print(" ")
                                    */
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
