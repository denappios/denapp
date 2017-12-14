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
        
        let markersRef = Repository.ref.child("pins")
        
        let autoIdMarkersRef = markersRef.childByAutoId()
        
        let newMarkerId = autoIdMarkersRef.key
        
        let userId = UserDefaults.standard.string(forKey: Constants.USER_ID) ?? "d-A-L-1-L-4"
        
    self.ref.child("users").child(userId).child("markers").child(newMarkerId).setValue(["type" : "2", "lat": String(marker.position.latitude), "lon": String(marker.position.longitude), "userId" : userId ?? "", "creationDate": String(describing: Date()), "title": marker.title ?? "", "description": marker.snippet])
        
        
        self.ref.child("markers").child(newMarkerId).setValue(["type" : "1", "lat": String(marker.position.latitude), "lon": String(marker.position.longitude), "userId" : userId ?? "", "creationDate": String(describing: Date()), "title": marker.title ?? "", "description": marker.snippet])
        
    }
    
    static func saveUser(uid: String, email: String) {
        
        self.ref.child("users").child(uid).setValue(["email" : email, "markers": []])
        
        UserDefaults.standard.setValue(uid, forKeyPath: Constants.USER_ID)
        
    }
    
    //TODO
    static func printMarkers() {
        
        let markersRef = Repository.ref.child("markers")
        
        markersRef.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                print("snap.childrenCount \(snapshot.childrenCount)")
                
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    //iterating through all the values
                    
                    print("snapshots.count \(snapshots.count)")
                    
                    for snap in snapshots {
                        //getting values
                        
                        //print("snap.key \(snap.key)")
                        //print("snap.value \(snap.value as? [String:String])")
                        
                        let marker = snap.value as? [String:String]
                        
                        for fields in marker! {
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
    
    static func getLoggedUserId() -> String? {
        
        if let uuid = UserDefaults().object(forKey: Constants.USER_ID)  {
            return (uuid as! String)
        }
        return nil
    }
    
}
