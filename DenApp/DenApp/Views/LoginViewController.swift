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
import NVActivityIndicatorView

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate,NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.siginGoogle))
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        signInButton.addGestureRecognizer(tapGesture)
        signInButton.style = GIDSignInButtonStyle.iconOnly
        btnLogin.imageView?.contentMode = .scaleAspectFit
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
        
        if Authenticate.getAuthenticate() {
            self.setupTabBarController()
         }
        
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //MsgAlert().alert("Erro ao realizar login no Facebook", "DenApp", .error)
                }
            })
        }
    }
    
    
    
    
    @IBAction func fbLoginAction(_ sender: Any) {
        self.startLoading()
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            
            if error != nil {
                self.stopAnimating()
                MsgAlert().alert("Erro ao realizar login no Facebook", "DenApp", .error)
            }
            else if (result?.isCancelled)! {
                self.stopAnimating()
                MsgAlert().alert("Login no Facebook Cancelado", "DenApp", .error)
            }
            else {
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                let credential = FacebookAuthProvider.credential(withAccessToken: fbloginresult.token.tokenString)
                
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                      MsgAlert().alert("Erro ao realizar login no Facebook", "DenApp", .error)
                        self.stopAnimating()
                    } else {
                        self.getFBUserData()
                        Authenticate.setAuthenticate(user: (Auth.auth().currentUser?.uid)!)
                        Repository.saveUser(uid: (Auth.auth().currentUser?.uid)!, email: "")
                        self.stopAnimating()
                        self.setupTabBarController()
                    }
                }
            }
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
        let item4 = YALTabBarItem(itemImage: #imageLiteral(resourceName: "iconWildAnimals"), leftItemImage: UIImage(named: "search_icon"), rightItemImage: UIImage(named: "settings_icon"))
        
        let item3 = YALTabBarItem(itemImage: #imageLiteral(resourceName: "iconCrime2"), leftItemImage: UIImage(named: "search_icon"), rightItemImage: UIImage(named: "settings_icon"))
        
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
    
    @objc func siginGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        self.startLoading()
        if let error = error {
            // ...
            MsgAlert().alert("Erro ao realizar login no Google", "DenApp", .error)
            self.stopAnimating()
        } else {
            
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    self.stopAnimating()
                    MsgAlert().alert("Erro ao realizar login no Google", "DenApp", .error)
                } else {
                    Authenticate.setAuthenticate(user: (Auth.auth().currentUser?.uid)!)
                    Repository.saveUser(uid: (Auth.auth().currentUser?.uid)!, email: "")
                    self.stopAnimating()
                    self.setupTabBarController()
                }
                // User is signed in
                // ...
            }
        }
    }
    
    
    
    
    
    @IBAction func loginEmailPass(_ sender: Any) {
        self.startLoading()
        if "" == txtEmail.text || "" == txtPassword.text {
            MsgAlert().alert("Email ou Password incorretos.", "DenApp", .error)
            self.stopAnimating()
        }
        else {
            Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user, error) in
                
                print("User: \(user)")
                print("Error: \(error)")
                
                if error != nil {
                    MsgAlert().alert("Erro ao realizar login", "DenApp", .error)
                    self.stopAnimating()
                } else {
                    Authenticate.setAuthenticate(user: (Auth.auth().currentUser?.uid)!)
                    self.stopAnimating()
                    self.setupTabBarController()
                }
                
            }
        }
    }
    
    func startLoading() {
        let size = CGSize(width: 70, height: 70)
        startAnimating(size, type: NVActivityIndicatorType(rawValue: NVActivityIndicatorType.ballGridPulse.rawValue)!,color: UIColor.white )
    }
}

