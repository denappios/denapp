//
//  TabBarViewController.swift
//  tabbarCustom
//
//  Created by Pelorca on 08/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit
import FoldingTabBar

class TabBarViewController: YALFoldingTabBarController, YALTabBarDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDen" {
            let typeDenunciation = (sender as! Int) + 1
            let page = segue.destination as! DenViewController
            page.typeDenuciation = typeDenunciation
        }
    }
    
    func tabBarDidExpand(_ tabBar: YALFoldingTabBar) {
        print("dali viado")
    }
    
    func tabBarDidCollapse(_ tabBar: YALFoldingTabBar) {
       
    }
    
    func tabBarDidSelectExtraLeftItem(_ tabBar: YALFoldingTabBar) {
        self.performSegue(withIdentifier: "showSearch", sender: nil)
    }
    
    func  tabBarDidSelectExtraRightItem(_ tabBar: YALFoldingTabBar) {
        self.performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    func tabBar(_ tabBar: YALFoldingTabBar, didSelectItemAt index: UInt) {
       self.performSegue(withIdentifier: "addDen", sender: index)
    }
    
    func tabBar(_ tabBar: YALFoldingTabBar, shouldSelectItemAt index: UInt) -> Bool {
        return true
    }
    
    
}

