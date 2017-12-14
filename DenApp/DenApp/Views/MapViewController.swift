//
//  MapViewController.swift
//  DenApp
//
//  Created by Aloc SP08120 on 12/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class MapConfig {
    static let latitute = -18.919272
    static let longitude = -48.291317
    
    static let zoomLevel = 11.58
    static let actualPosition = GMSMarker()
    
    
}

class MapViewController: UIViewController , GMSMapViewDelegate {
    
    
    var placesClient: GMSPlacesClient!
    var mapView: GMSMapView?
    var positions = [GMSMarker]()
    var maxDistanceToShow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maxDistanceToShow = UserDefaults.standard.integer(forKey: Constants.favoriteType)
        placesClient = GMSPlacesClient.shared()
        loadView()
        loadLocal()
        mapView?.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: MapConfig.latitute, longitude: MapConfig.longitude, zoom: Float(MapConfig.zoomLevel))
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.isMyLocationEnabled = true
        view = mapView
        
        for i in 1...4 {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: MapConfig.latitute + Double(i/3), longitude: MapConfig.longitude )
            marker.title = "Assalto Viado"
            marker.icon = UIImage(named : "iconAccident")
            marker.snippet = "Uberlândia"
            marker.isFlat = true
            marker.map  = mapView
            positions.append(marker)
            
        }
    }
    
    func calcuDistance(_ marker : GMSMarker) -> CLLocationDistance {
        let actualPosition = CLLocation(latitude: MapConfig.actualPosition.position.latitude, longitude: MapConfig.actualPosition.position.longitude)
        
        let position =  CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        print("Distancia em metros do seu ponto eh \(position.distance(from: actualPosition))")
        return position.distance(from: actualPosition)
        
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
                    
                    
                    MapConfig.actualPosition.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                    MapConfig.actualPosition.title = place.name
                    //marker.icon
                    MapConfig.actualPosition.icon = GMSMarker.markerImage(with: .red)
                    MapConfig.actualPosition.snippet = "Uberlândia"
                    
                    MapConfig.actualPosition.map = self.mapView
                    
                    self.mapView?.camera = GMSCameraPosition.camera(withLatitude: MapConfig.actualPosition.position.latitude, longitude: MapConfig.actualPosition.position.longitude, zoom: Float(MapConfig.zoomLevel))
                    
                }
            }
        })
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //self.actualPosition.map = nil
        //            MapConfig.actualPosition.position = coordinate
        //            MapConfig.actualPosition.title = "Nova denuncia..."
        //            MapConfig.actualPosition.snippet = "Aqui"
        //            MapConfig.actualPosition.map = self.mapView
        createMarker(coordinate)
        
    }
    func createMarker(_ coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude , longitude: coordinate.longitude )
        marker.title = "Acidente aqui"
        marker.icon = UIImage(named : "iconAccident")
        marker.snippet = "roda dura do krl"
        marker.isFlat = true
        positions.append(marker)
        
        print("latitute : \(coordinate.latitude) longitude:\(coordinate.longitude)")
        print("")
        let distance : Double = calcuDistance(marker)
        if maxDistanceToShow == 0 || distance > Double(maxDistanceToShow)   {
            marker.map  = mapView
        }
        else {
            print("voce esta a \(distance) metros, e so exibe a no maximo \(maxDistanceToShow)")
        }
        
    }
    
    
    
}

