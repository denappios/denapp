//
//  ConfigurationViewController.swift
//  DenApp
//
//  Created by ALOC SP6450 on 11/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Floaty


class ConfigurationViewController: UIViewController, DropDownMenuDelegate {
    
    @IBOutlet weak var dropDenuncia: DropDownMenu!
    @IBOutlet weak var segmentRangeRadius: UISegmentedControl!
    @IBOutlet weak var switchNotification: UISwitch!
    
    @IBOutlet weak var btnBack: Floaty!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.dropDenuncia.items = ["Incêndio", "Acidente", "Crime", "Animais Silvestre"];
        self.dropDenuncia.itemsIDs = [0, 1, 2, 3];
        self.dropDenuncia.titleTextAlignment = NSTextAlignment.left;
        self.dropDenuncia.delegate = self;
        
        loadRangeRadius()
        loadUserDefaults()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        btnBack.addGestureRecognizer(tapGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadRangeRadius() {
        self.segmentRangeRadius.setTitle("500m", forSegmentAt: 0)
        self.segmentRangeRadius.setTitle("1 km", forSegmentAt: 1)
        self.segmentRangeRadius.setTitle("1,5 km", forSegmentAt: 2)
        self.segmentRangeRadius.setTitle("2 km", forSegmentAt: 3)
    }
    
    @IBAction func alterRangeRadius(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(self.segmentRangeRadius.selectedSegmentIndex, forKey: Constants.rangeRadius)
    }
    
    @IBAction func alterGetNotification(_ sender: UISwitch) {
        UserDefaults.standard.set(self.switchNotification.isOn, forKey: Constants.getNotification)
    }
    
    func loadUserDefaults() {
        self.segmentRangeRadius.selectedSegmentIndex = UserDefaults.standard.integer(forKey: Constants.rangeRadius)
        self.switchNotification.isOn = UserDefaults.standard.bool(forKey: Constants.getNotification)
        self.dropDenuncia.selectedIndex = UserDefaults.standard.integer(forKey: Constants.favoriteType)
        self.dropDenuncia.selectedStart = true
    }
    
    func didSelectItem(_ dropDownMenu: DropDownMenu, at atIndex: Int) {
         UserDefaults.standard.set(self.dropDenuncia.itemsIDs[atIndex], forKey: Constants.favoriteType)
    }
    
    func didShow(_ dropDownMenu: DropDownMenu) {
        
    }
    
    func didHide(_ dropDownMenu: DropDownMenu) {
        
    }
    
    @objc func backPage() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
