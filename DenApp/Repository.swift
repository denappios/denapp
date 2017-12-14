//
//  Repository.swift
//  DenApp
//
//  Created by Guilherme on 14/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import GoogleMaps

class Repository {
    
    // Criando referência para o banco de dados
    static var ref: DatabaseReference = Database.database().reference()
    
  
    
    
    static func saveMarker(marker: GMSMarker) {
        
        let pinsRef = Repository.ref.child("pins")
        
        let autoIdPinsRef = pinsRef.childByAutoId()
        
        let newPinId = autoIdPinsRef.key
        
        self.ref.child("markers").child(newPinId).setValue(["type" : "accident", "lat": String(marker.position.latitude), "lon": String(marker.position.longitude)])
        
    }
    
    static func saveUser(uid: String, email: String) {
        
        self.ref.child("users").child(uid).setValue(["email" : email, "markers": []])
        
        UserDefaults.standard.setValue(uid, forKeyPath: USER_ID)
        
    }
    
    
    static func printMarkers() {
        
        let pinsRef = Repository.ref.child("pins")
        
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

    }
    
}
