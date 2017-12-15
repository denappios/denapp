//
//  SearchViewController.swift
//  DenApp
//
//  Created by Pelorca on 13/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Floaty
import FirebaseDatabase
import FirebaseStorage

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var btnBack: Floaty!
    
    var dens: [Den] = []
    var selected: Den?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listMarkersByLoggedUser()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        btnBack.addGestureRecognizer(tapGesture)
    }
    
    func listMarkersByLoggedUser() {
        let uuid = Repository.getLoggedUserId()
        self.dens.removeAll()
        var list: [UIImage] = []
        Repository.ref.child("users").child(uuid!).child("markers").observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshots {
                        
                        let pin = snap.value as? [String:String]
                        
                        let title = pin!["title"]
                        let desc = pin!["description"]
                        let dt = pin!["creationDate"]
                        let lat = Double((pin!["lat"] as! NSString).doubleValue)
                        let lon = Double((pin!["lon"] as! NSString).doubleValue)
                        let type = Int(pin!["type"]!)
                        
                        // TODO: Utilizar imagens reais
                        let d = Den(title!, type!, lat, lon, dt!, desc!, list,snap.key)
                        self.dens.append(d)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dens.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDen") as! SearchViewCell
        cell.selectedBackgroundView = createSelectedBackgroundView()
        
        let den = dens[indexPath.row]
        cell.txtTitulo.text = den.title
        cell.typeDen.image = TypeDen.indentifyType(den.typeDen)
        return cell
    }
    
    func createSelectedBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected = dens[indexPath.row]
        self.performSegue(withIdentifier: "viewDetails", sender: selected)
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dens.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewDetails" {
            let page: SearchDetailViewController = segue.destination as! SearchDetailViewController
            page.den = (sender as! Den)
        }
    }
    
    @objc func backPage() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
