//
//  TESTEViewController.swift
//  DenApp
//
//  Created by Pelorca on 13/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import TextFieldEffects
import GoogleMaps
import GooglePlaces
import Floaty
import FirebaseDatabase
import FirebaseStorage
import NVActivityIndicatorView
class SearchDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NVActivityIndicatorViewable {
    @IBOutlet weak var btnBack: Floaty!
    var den: Den?
    @IBOutlet weak var txtDescription: HoshiTextView!
    @IBOutlet weak var txtDate: HoshiTextField!
    @IBOutlet weak var txtTitle: HoshiTextField!
    @IBOutlet weak var viewMap: GMSMapView!
    
    @IBOutlet weak var collectionPhotos: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.txtDescription.text = den?.descriacao
        self.txtDate.text = den?.data
        self.txtTitle.text = den?.title
        loadViewMap()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        btnBack.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.startLoading()
       getPhotos()
    }
    
    func getPhotos() {
        
        self.den?.fotos = []
        var count = 0
        var list: [UIImage] = []
        Repository.ref.child("images").child((den?.key)!).observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshots {
                        // Get download URL from snapshot
                        let downloadURL = snap.value as? String
                        // Create a storage reference from the URL
                        let storageRef = Storage.storage().reference(forURL: downloadURL!)
                        // Download the data, assuming a max size of 1MB (you can change this as necessary)
                        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            if let error = error {
                                // Uh-oh, an error occurred!
                            } else {
                                // Data for "images/island.jpg" is returned
                                let image = UIImage(data: data!)
                                self.den?.fotos.append(image!)
                                self.collectionPhotos.reloadData()
                                count += 1
                                if count == snapshot.childrenCount {
                                    self.stopAnimating()
                                }
                                
                            }
                        }
                    }
                }
            }
            
            
        })
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImagem", for: indexPath) as! SearchDetailCollectionViewCell
        cell.photosDen.image = den?.fotos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (den?.fotos.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showImage", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let page: ShowImageSearchDetailViewController = segue.destination as! ShowImageSearchDetailViewController
        if segue.identifier == "showImage" {
            let indexPath = sender as! IndexPath
            page.imagem =  den?.fotos[indexPath.row]
        }
        
    }
    
    func loadViewMap() {
        let camera = GMSCameraPosition.camera(withLatitude: den!.latitute, longitude: den!.longitude, zoom: 16.0)
        self.viewMap.camera = camera
        self.viewMap.isMyLocationEnabled = true
        self.viewMap.isUserInteractionEnabled = false
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: den!.latitute, longitude: den!.longitude)
        marker.title = den?.title
        marker.icon = TypeDen.indentifyType((den?.typeDen)!)
        marker.snippet = den?.descriacao
        marker.map  = self.viewMap
        
    }
    func startLoading() {
        let size = CGSize(width: 70, height: 70)
        startAnimating(size, type: NVActivityIndicatorType(rawValue: NVActivityIndicatorType.ballGridPulse.rawValue)!,color: UIColor.white )
    }
    
    @objc func backPage() {
        dismiss(animated: true, completion: nil)
    }
    
}
