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

class SearchDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var btnBack: Floaty!
    var den: Den?
    @IBOutlet weak var txtDescription: HoshiTextView!
    @IBOutlet weak var txtDate: HoshiTextField!
    @IBOutlet weak var txtTitle: HoshiTextField!
    @IBOutlet weak var viewMap: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtDescription.text = den?.descriacao
        self.txtDate.text = den?.data
        self.txtTitle.text = den?.title
        loadViewMap()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        btnBack.addGestureRecognizer(tapGesture)
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
    
    @objc func backPage() {
        dismiss(animated: true, completion: nil)
    }
    
}
