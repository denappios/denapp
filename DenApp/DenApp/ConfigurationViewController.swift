//
//  ConfigurationViewController.swift
//  DenApp
//
//  Created by ALOC SP6450 on 11/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit

struct PickerKeyValue {
    let key: Int
    let value: String
}

class ConfigurationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var segmentRangeRadius: UISegmentedControl!
    @IBOutlet weak var pickerFavorite: UIPickerView!
    @IBOutlet weak var switchNotification: UISwitch!
    
    let arrayOne = [PickerKeyValue(key: 0, value: "Alagamento"),
                    PickerKeyValue(key: 1, value: "Assalto"),
                    PickerKeyValue(key: 2, value: "Engarrafamento"),
                    PickerKeyValue(key: 3, value: "Passeata"),
                    PickerKeyValue(key: 4, value: "Tiroteio")]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayOne.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        UserDefaults.standard.set(arrayOne[row].key, forKey: Constants.favoriteType)
        return arrayOne[row].value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerFavorite.delegate = self
        self.pickerFavorite.dataSource = self
        loadRangeRadius()
        loadUserDefaults()
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
        self.pickerFavorite.selectRow(UserDefaults.standard.integer(forKey: Constants.favoriteType), inComponent: 0, animated: false)
        self.switchNotification.isOn = UserDefaults.standard.bool(forKey: Constants.getNotification) 
    }
    
}
