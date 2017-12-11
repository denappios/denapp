//
//  ViewController.swift
//  DenApp
//
//  Created by Pelorca on 05/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SCLAlertView
import FoldingTabBar
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        signInButton.style = GIDSignInButtonStyle.iconOnly
        // TODO(developer) Configure the sign-in button look/feel
        // ...

        
        //if the user is already logged in
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
        
    }

    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //self.dict = result as! [String : AnyObject]
                    //print(result!)
                    //print(self.dict)
                    print("erro")
                }
            })
        }
    }
    
    
    @IBAction func fbLoginAction(_ sender: Any) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            
            if error != nil {
                NSLog("Process error")
            }
            else if (result?.isCancelled)! {
                NSLog("Cancelled")
            }
            else {
                NSLog("Logged in")
                self.getFBUserData()
            }
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
       
        if "" == txtEmail.text || "" == txtPassword.text {
            MsgAlert().alert("Email ou Password incorretos.", "DenApp", .error)
 
        }
         else {
           setupTabBarController()
        }
     }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTabBarController() {
        
        let testAppDelegate = UIApplication.shared.delegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabObj = storyboard.instantiateViewController(withIdentifier: "tabController") as? TabBarViewController
        testAppDelegate?.window??.rootViewController = tabObj
        testAppDelegate?.window??.makeKeyAndVisible()
        
        let window = testAppDelegate?.window
        guard let tabBarController = window??.rootViewController as? YALFoldingTabBarController else { return }
        
        let item1 = YALTabBarItem(itemImage: #imageLiteral(resourceName: "iconFire"), leftItemImage: UIImage(named: "search_icon"), rightItemImage: UIImage(named: "settings_icon"))
        let item2 = YALTabBarItem(itemImage: #imageLiteral(resourceName: "iconAccident2"), leftItemImage: UIImage(named: "search_icon"), rightItemImage: UIImage(named: "settings_icon"))
        let item3 = YALTabBarItem(itemImage: #imageLiteral(resourceName: "iconWildAnimals"), leftItemImage: UIImage(named: "search_icon"), rightItemImage: UIImage(named: "settings_icon"))
        
         let item4 = YALTabBarItem(itemImage: #imageLiteral(resourceName: "iconCrime2"), leftItemImage: UIImage(named: "search_icon"), rightItemImage: UIImage(named: "settings_icon"))
        
        tabBarController.leftBarItems = [item1, item2]
        
          tabBarController.rightBarItems = [item3, item4]
        
        tabBarController.centerButtonImage = UIImage(named:"plus_icon")!
        tabBarController.selectedIndex = 0
        
        tabBarController.tabBarView.dotColor = UIColor(
            red: 94.0/255.0,
            green: 91.0/255.0,
            blue: 149.0/255.0,
            alpha: 0.1)
        
        //customize tabBarView
        tabBarController.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
        tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
        tabBarController.tabBarView.backgroundColor = UIColor.clear
        
        tabBarController.tabBarView.tabBarColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBarController.tabBarView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight;
        tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
        tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
        
        self.present(tabObj!, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func loginEmailPass(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user, error) in
            
            print("User: \(user)")
            print("Error: \(error)")
            
            if error != nil {
                MsgAlert().alert("Erro ao realizar login", "DenApp", .error)
            } else {
                MsgAlert().alert("Login realizado com sucesso", "DenApp", .success)
            }

        }
    }
    

}

