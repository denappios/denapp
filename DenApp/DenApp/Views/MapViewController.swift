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
import FirebaseDatabase
import NVActivityIndicatorView
class MapConfig {
    static let latitute = -18.919272
    static let longitude = -48.291317
    
    static let zoomLevel = 15.58
    static let actualPosition = GMSMarker()
    static let rangeRadius = [500,1000,1500,2000]
}

class MapViewController: UIViewController , GMSMapViewDelegate, NVActivityIndicatorViewable {
    var placesClient: GMSPlacesClient!
    var mapView: GMSMapView?
    var positions = [GMSMarker]()
    var maxDistanceToShow = 0
    let uuidCurrentUser = Repository.getLoggedUserId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoading()
        placesClient = GMSPlacesClient.shared()
        loadView()
        mapView?.delegate = self
        
        
    }
    //no load e quando volta  executa este metodo
    override func viewWillAppear(_ animated: Bool) {
        maxDistanceToShow = UserDefaults.standard.integer(forKey: Constants.rangeRadius) //index referente ao array rangeRadius
        mapView?.clear()//limpar todos os markers
        mapView?.isMyLocationEnabled = true
        if positions.count  == 0 {
            loadLocal() //carrega a posicao atual do usuario e lista posicoes
        }else {
            loadMarkers() //somente lista posicoes
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: MapConfig.latitute, longitude: MapConfig.longitude, zoom: Float(MapConfig.zoomLevel))
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.isMyLocationEnabled = true
        view = mapView

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
                MapConfig.actualPosition.position = CLLocationCoordinate2D(latitude: MapConfig.latitute, longitude: MapConfig.longitude)
                self.listMarkersByApplication()
                return
            }
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    MapConfig.actualPosition.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                    MapConfig.actualPosition.title = place.name
                    MapConfig.actualPosition.icon = GMSMarker.markerImage(with: .red)
                    MapConfig.actualPosition.snippet = "Nova denuncia"
                    MapConfig.actualPosition.map = self.mapView
                    self.listMarkersByApplication()
                }
            }
        })
    }
    
    func listMarkersByApplication() {
        self.startLoading()
        self.positions = [GMSMarker]()//limpa as posicoes no mapa
        Repository.ref.child("markers").observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshots {
                        
                        if let pin = snap.value as? [String:String] {
                        
                            let title = pin["title"]
                            let desc = pin["description"]
                            let dt = pin["creationDate"]
                            let lat = Double((pin["lat"]! as NSString).doubleValue)
                            let lon = Double((pin["lon"]! as NSString).doubleValue)
                            let type = Int(pin["type"]!)
                        
                        
                        // TODO: Utilizar imagens reais
                        let d = Den(title!, type!, lat, lon, dt!, desc!, [#imageLiteral(resourceName: "iconCrime"),#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "iconFire")], snap.key)
                        self.positions.append(d.toMarker())
                        }
                        else {
                            print("erro no objeto \(snap.value)")
                        }
                        
                    }
                }
            }
            self.loadMarkers()
            self.stopAnimating()
        })
    }
    
    func startLoading() {
        let size = CGSize(width: 70, height: 70)
        startAnimating(size, type: NVActivityIndicatorType(rawValue: NVActivityIndicatorType.ballGridPulse.rawValue)!,color: UIColor.white )
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        MapConfig.actualPosition.position = coordinate
        MapConfig.actualPosition.title = "Nova denuncia"
        MapConfig.actualPosition.snippet = ""
        MapConfig.actualPosition.map = self.mapView
        loadMarkers()
    }
    func loadMarkers()  {

            for item in self.positions {
                let distance : Double = calcuDistance(item)
                print("voce esta a \(distance) metros, e so exibe a no maximo \(MapConfig.rangeRadius[maxDistanceToShow])")
                if Double(MapConfig.rangeRadius[maxDistanceToShow]) > distance ||  !CLLocationManager.locationServicesEnabled()  {
                   item.map = mapView
                }
                
            }
        
    }
}

extension Den {
    func toMarker() -> GMSMarker {
        let item = GMSMarker()
        item.title = self.title
        item.snippet = self.descriacao
        item.position = CLLocationCoordinate2D(latitude: self.latitute , longitude: self.longitude )
        item.isFlat = true
        item.icon =  TypeDen.indentifyType(self.typeDen)
        return item
    }
    
}

