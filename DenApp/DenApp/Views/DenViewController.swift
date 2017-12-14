//
//  DenViewController.swift
//  DenApp
//
//  Created by Fábio Santos Alveson 13/12/2017.
//  Copyright © 2017 DenApp. All rights reserved.
//

import UIKit
import Floaty
import FSCalendar

class DenViewController: UIViewController, UICollectionViewDelegate,  UIImagePickerControllerDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, FSCalendarDataSource, FSCalendarDelegate {
    
    
    @IBOutlet weak var collectioView: UICollectionView!
    
    @IBOutlet weak var textTitle: UITextField!
   
    @IBOutlet weak var backButton: Floaty!
    
    @IBOutlet weak var saveButton: Floaty!
    
    @IBOutlet weak var labelDate: UILabel!
    
    
    @IBOutlet weak var textDescription: UITextView!
    
    var listImagens: [UIImage] = [#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "iconCamera")]
    
    var indexPath: IndexPath?
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let denunciation: Denunciation = Denunciation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.delegate = self
        initGesture()
        
        //TODO - Remover posteriormente MOCK de localizaçao
       
     

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath  = indexPath
        getPhoto()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImagem", for: indexPath) as! CollectionViewCell
        cell.photoDen.image = listImagens[indexPath.row]
        
        if listImagens[indexPath.row] != #imageLiteral(resourceName: "iconCamera") {
            cell.btnDelete.isHidden = false
        } else {
            cell.btnDelete.isHidden = true
        }
        
        cell.btnDelete.layer.setValue(indexPath.row, forKey: "index")
        cell.btnDelete.addTarget(self, action: #selector(self.deletePhoto(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc  func deletePhoto(_ sender: UIButton) {
        let index = sender.layer.value(forKey: "index") as! Int
        listImagens[index] = #imageLiteral(resourceName: "iconCamera")
        
        getImages()
        
    }
    
    func getImages() {
        self.collectionView?.reloadData()
    }
    
    
    @objc func getPhoto() {
        
        imagePicker.allowsEditing = false
        
        let alertController = UIAlertController(title: "Escolhe uma Foto", message: "", preferredStyle: .actionSheet)
        let Cancelar = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction!) in
            return
        }
        alertController.addAction(Cancelar)
        let cancelAction = UIAlertAction(title: "Camera", style: .default) { (action:UIAlertAction!) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "Galeria", style: .default) { (action:UIAlertAction!) in
            self.imagePicker.sourceType = .photoLibrary;
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        if listImagens[(self.indexPath?.row)!] != #imageLiteral(resourceName: "iconCamera") {
            let showPhoto = UIAlertAction(title: "Visualizar", style: .default) { (action:UIAlertAction!) in
                self.performSegue(withIdentifier: "showImage",  sender: self)
            }
            alertController.addAction(showPhoto)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            listImagens[(indexPath?.row)!] = pickedImage
            getImages()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func backPage() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveDenunciation(){
        print("Salvando Denunciation...")
        
        createDenuciation()
        print(denunciation)
        
    }
    
    func createDenuciation () {
        denunciation.title = textTitle.text
        denunciation.DenunciationDescription = textDescription.text
        denunciation.date = labelDate.text
        denunciation.listImagens = listImagens
    }
    
    func getCalendar() -> FSCalendar {
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 3, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.titleWeekendColor = UIColor.red
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.calendarHeaderView.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        calendar.appearance.headerTitleColor = UIColor.white
        calendar.appearance.selectionColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        calendar.locale = Locale(identifier: "pt_BR")
        return calendar
        
    }
    
    @IBAction func showCalendar(_ sender: UIButton) {
        var calendar = getCalendar()
        let alert = Calendar(title: "Selecione uma Data", calendar: &calendar, labelDate)
        alert.show(animated: true)
    }
    
    func initGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        let tapGestureSave = UITapGestureRecognizer(target: self, action: #selector(self.saveDenunciation))
        
        backButton.addGestureRecognizer(tapGesture)
        saveButton.addGestureRecognizer(tapGestureSave)
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
