//
//  MapViewController.swift
//  DenApp
//
//  Created by Aloc SP08120 on 12/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Mapbox

struct Uberlandia {
    static let latitute = -18.919272
    static let longitude = -48.291317
    //static let mapUrl = "mapbox://styles/pedroduraes/cjavchmeu14px2smlao9dujuw"
    static let mapUrlDefault = "mapbox://styles/mapbox/light-v9"
    static let zoomLevel = 15.00
}

class MapViewController: UIViewController {

    var mapView : MGLMapView!
    var anotations = [String : MGLAnnotationImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension MapViewController : MGLMapViewDelegate{
    
    
    func createAnotation()  {
        // Declare the marker `hello` and set its coordinates, title, and subtitle.
        let hello = MGLPointAnnotation()
        hello.coordinate = CLLocationCoordinate2D(latitude: Uberlandia.latitute, longitude: Uberlandia.longitude)
        hello.title = "Assalto"
        hello.subtitle = "Atencao:  Assalto registro aqui"
        let anotation = hello.setImageType(type: MGLPointAnnotation.TypeAlert.assalto )
        anotations.updateValue(anotation,forKey: hello.getReuseIdentifier())
        // Add marker `hello` to the map.
        mapView.addAnnotation(hello)
        
        let abc = MGLPointAnnotation() //-18.911416, -48.265340
        abc.coordinate = CLLocationCoordinate2D(latitude: -18.911416, longitude: -48.265340)
        abc.title = "Outra ocorrencia"
        abc.subtitle = "Muito barulho"
        let abcanotation = abc.setImageType(type: MGLPointAnnotation.TypeAlert.noise )
        anotations.updateValue(abcanotation,forKey: abc.getReuseIdentifier())
        // Add marker `hello` to the map.
        mapView.addAnnotation(abc)
        
        
        let xpto = MGLPointAnnotation() //-18.914697, -48.266898
        xpto.coordinate = CLLocationCoordinate2D(latitude: -18.914697, longitude: -48.266898)
        xpto.title = "Incendio a casa"
        xpto.subtitle = "ta pegando fogo bixo"
        let xptoanotation = xpto.setImageType(type: MGLPointAnnotation.TypeAlert.firealert )
        anotations.updateValue(xptoanotation,forKey: xpto.getReuseIdentifier())
        // Add marker `hello` to the map.
        mapView.addAnnotation(xpto)
        
    }
    
    func createMap()  {
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = URL(string: Uberlandia.mapUrlDefault)
        
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: Uberlandia.latitute , longitude: Uberlandia.longitude), zoomLevel: Uberlandia.zoomLevel , animated: false)
        view.addSubview(mapView)
        
        // Set the delegate property of our map view to `self` after instantiating it.
        mapView.delegate = self
        createAnotation()
         mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:))))
        
    }
    
    //https://www.mapbox.com/ios-sdk/examples/runtime-multiple-annotations/
    @objc func handleMapTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            
            // Try matching the exact point first.
            let point = sender.location(in: sender.view!)
            let touchCoordinate = mapView.convert(point, toCoordinateFrom: sender.view!)
            //let touchLocation = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
            
            
            let xpto = MGLPointAnnotation() //-18.914697, -48.266898
            xpto.coordinate = CLLocationCoordinate2D(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
            xpto.title = "teste add anotation dinamico"
            xpto.subtitle = "Roubaram aqui..."
            let xptoanotation = xpto.setImageType(type: MGLPointAnnotation.TypeAlert.assalto )
            anotations.updateValue(xptoanotation,forKey: xpto.getReuseIdentifier())
            // Add marker `hello` to the map.
            mapView.addAnnotation(xpto)
            mapView.selectAnnotation(xpto, animated: true)
            
        }
    }
    
    // Use the default marker. See also: our view annotation or custom marker examples.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        //let style = MGLAnnotationView(
        return nil
    }
    
    
    
    // Allow callout view to appear when an annotation is tapped.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        print("anotation selecionada")
        //centraliza o map
        //let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4000, pitch: 0, heading: 0)
        //mapView.setCamera(camera, animated: true)
    }
    func mapView(_ mapView: MGLMapView, didDeselect annotation: MGLAnnotation) {
        print("anotation des-selecionada")
    }
    func mapView(_ mapView: MGLMapView, didAdd annotationViews: [MGLAnnotationView]) {
        print("anotation adicionada ao mapa")
    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        print("tapOnCalloutFor")
    }
    private func mapView(mapView: MGLMapView, regionDidChangeAnimated animated: Bool) -> Bool {
        print("regionDidChangeAnimated")
        return true
    }
    
    
    //https://gist.github.com/friedbunny/27ece538f288230a5905
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        //        let reuseIdentifier = reuseIdentifierForAnnotation(annotation: annotation)
        //        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier)
        //
        //        if annotationImage == nil {
        //            let image = UIImage(named: "bandido")!
        //
        //            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
        //        }
        //
        //        return annotationImage
        let point = MGLPointAnnotation()
        point.coordinate = annotation.coordinate
        return anotations[point.getReuseIdentifier()]
        
    }
    
    func reuseIdentifierForAnnotation(annotation: MGLAnnotation) -> String {
        //        var reuseIdentifier = "\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
        //        if let title = annotation.title, title != nil {
        //            reuseIdentifier += title!
        //        }
        //        if let subtitle = annotation.subtitle, subtitle != nil {
        //            reuseIdentifier += subtitle!
        //        }
        //        return reuseIdentifier
        let point =  MGLPointAnnotation()
        point.coordinate = annotation.coordinate
        return point.getReuseIdentifier()
    }
    
}

extension MGLPointAnnotation {
    func getReuseIdentifier() -> String {
        let reuseIdentifier = "\(self.coordinate.latitude),\(self.coordinate.longitude)"
        //reuseIdentifier += self.title!
        //reuseIdentifier += self.subtitle!
        return reuseIdentifier
    }
    
    enum TypeAlert{
        case assalto
        case firealert
        case noise
        case accident
    }
    func setImageType( type : TypeAlert) -> MGLAnnotationImage {
        var annotationImage :  MGLAnnotationImage
        switch type {
        case .assalto:
            let image = UIImage(named: "iconCrime2")!
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: getReuseIdentifier())
        case .firealert :
            let image = UIImage(named: "iconFire")!
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: getReuseIdentifier())
            
        case .noise :
           let image = UIImage(named: "iconFire")!
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: getReuseIdentifier())
        case .accident :
            let image = UIImage(named: "iconAccident")!
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: getReuseIdentifier())
        }
        return annotationImage
    }
    
    
    
}





