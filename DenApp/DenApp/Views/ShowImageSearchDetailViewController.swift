//
//  ShowImageSearchDetailViewController.swift
//  DenApp
//
//  Created by Pelorca on 13/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Floaty
class ShowImageSearchDetailViewController: UIViewController {

    var imagem: UIImage?
    
    @IBOutlet weak var showImagen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        btnBack.addGestureRecognizer(tapGesture)
        self.showImagen.image = imagem
    }
    
    @IBOutlet weak var btnBack: Floaty!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backPage() {
        dismiss(animated: true, completion: nil)
    }
    
}
