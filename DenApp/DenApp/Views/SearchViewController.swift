//
//  SearchViewController.swift
//  DenApp
//
//  Created by Pelorca on 13/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit


class SearchViewController: UITableViewController {

    
    
    var dens: [Den] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dens = Den.mockDens
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dens.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    
    
  
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
    }
    
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             dens.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
   

}
