//
//  DetailsViewController.swift
//  DenApp
//
//  Created by Pelorca on 13/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class DetailsViewController: UIViewController, GMSMapViewDelegate {
    
    let actualPosition = GMSMarker()
    var placesClient: GMSPlacesClient!
    var mapView: GMSMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        loadView()
        loadLocal()
        mapView?.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
   
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: Uberlandia.latitute, longitude: Uberlandia.longitude, zoom: Float(Uberlandia.zoomLevel))
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.isMyLocationEnabled = true
        view = mapView
        
        for i in 1...4 {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Uberlandia.latitute + Double(i), longitude: Uberlandia.longitude + Double(i))
            marker.title = "Assalto Viado"
            marker.icon = TypeDen.indentifyType(i)
            marker.snippet = "Uberlândia"
            marker.isFlat = true
            marker.map  = mapView
            
        }
        
       
        
      
    
    }
    
    func loadLocal() {
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    
                   
                    self.actualPosition.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                    self.actualPosition.title = place.name
                    //marker.icon
                    self.actualPosition.icon = GMSMarker.markerImage(with: .black)
                    self.actualPosition.snippet = "Uberlândia"
                
                    self.actualPosition.map = self.mapView
                    
                    self.mapView?.camera = GMSCameraPosition.camera(withLatitude: self.actualPosition.position.latitude, longitude: self.actualPosition.position.longitude, zoom: Float(Uberlandia.zoomLevel))
                }
            }
        })
    }
    


    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //self.actualPosition.map = nil
        self.actualPosition.position = coordinate
        self.actualPosition.title = "Estou Aqui"
        self.actualPosition.snippet = ""
        self.actualPosition.map = self.mapView
    }


}
