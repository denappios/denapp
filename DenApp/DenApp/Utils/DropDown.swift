//
//  DropDown.swift
//  tabbarCustom
//
//  Created by Pelorca on 12/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DropDownMenuDelegate: NSObjectProtocol {
    func didSelectItem(_ dropDownMenu: DropDownMenu, at atIndex: Int)
    
    func didShow(_ dropDownMenu: DropDownMenu)
    
    func didHide(_ dropDownMenu: DropDownMenu)
}


@IBDesignable
class DropDownMenu: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: DropDownMenuDelegate?
    /*This will assign title of the Drop Menu.*/
    @IBInspectable var title = ""
    /*This will assign color of Drop Menu title. Default is Black Color */
    @IBInspectable var titleColor: UIColor?
    /* This will assign font size of Drop Menu title. Defualt is 14.0 */
    @IBInspectable var titleFontSize: CGFloat = 0.0
    @IBInspectable var itemHeight: Double = 0.0
    /* This will assign background color of item in Drop Menu. Default is white color. */
    @IBInspectable var itemBackground: UIColor?
    /* This will assign item color in Drop Menu. Default is Black Color. */
    @IBInspectable var itemTextColor: UIColor?
    /* This will assign font size of item in Drop Menu. Defualt is 14.0 */
    @IBInspectable var itemFontSize: CGFloat = 0.0
    /* This will assign direction of Drop Menu. Defualt is Down. Possible Values are YES/NO. YES(On) = Down and NO(Off) = Up */
    @IBInspectable var isDirectionDown = false
    
    /* This will assign custom font to items in Drop Menu. Default is System Font. */
    var itemsFont: UIFont?
    /* This will assign alignment of title text of Drop Menu. Default Value is Center*/
    var titleTextAlignment: NSTextAlignment?
    
    var itemTextAlignment: NSTextAlignment?
    /* Array of items to be displayed in Drop Menu */
    var items = [Any]()
    /* Optional : Array of numbers indicating IDs which is assigned to Drop Menu as tag */
    var itemsIDs = [Any]()
    
    
    var selectedIndex: Int = 0
    var selectedStart: Bool = false
    private var tblView: UITableView?
    private var selectedFont: UIFont?
    private var font: UIFont?
    private var itemFont: UIFont?
    private var isCollapsed = false
    private var tapGestureBackground: UITapGestureRecognizer?
    private var label: UILabel?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initLayer()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayer()
        
    }
    
    func initLayer() {
        selectedIndex = -1
        isCollapsed = true
        titleTextAlignment = .center
        itemTextAlignment = titleTextAlignment
        titleColor = UIColor.black
        titleFontSize = 14.0
        itemHeight = 40.0
        itemBackground = UIColor.white
        itemTextColor = UIColor.black
        itemFontSize = 14.0
        itemsFont = UIFont.systemFont(ofSize: 14.0)
        isDirectionDown = true
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setTitleTextAlignment(_ titleTextAlignment: NSTextAlignment) {
        self.titleTextAlignment = titleTextAlignment
    }
    
    func setItemTextAlignment(_ itemTextAlignment: NSTextAlignment) {
        self.itemTextAlignment = itemTextAlignment
    }
    
    func setTitleColor(_ titleColor: UIColor) {
        self.titleColor = titleColor
    }
    
    func setTitleFontSize(_ titleFontSize: CGFloat) {
        if titleFontSize != 0.0 {
            self.titleFontSize = titleFontSize
        }
    }
    
    func setItemHeight(itemHeight: Double) {
        if itemHeight != 0.0 {
            self.itemHeight = itemHeight
        }
    }
    
    func setItemBackground(_ itemBackground: UIColor) {
        self.itemBackground = itemBackground
    }
    
    func setItemTextColor(_ itemTextColor: UIColor) {
        self.itemTextColor = itemTextColor
        
    }
    
    func setItemFontSize(_ itemFontSize: CGFloat) {
        
        self.itemFontSize = itemFontSize
        
    }
    
    func setItemsFont(_ itemFont1: UIFont) {
        
        itemsFont = itemFont1
        
    }
    
    func setDirectionDown(_ DirectionDown: Bool) {
        self.isDirectionDown = DirectionDown
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        if label == nil {
            label = UILabel(frame: CGRect(x: 10, y: 0, width: frame.size.width, height: frame.size.height))
            label?.textColor = titleColor
            label?.text = title
            
            if selectedIndex == -1 {
                title = "Selecione"
                label?.text = title
            } else if selectedStart {
                title = items[selectedIndex] as! String
                label?.text = title
            } else {
                label?.text = title
            }
            
            label?.textAlignment = titleTextAlignment!
            label?.font = font
            addSubview(label!)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        addGestureRecognizer(tapGesture)
        
        tblView = UITableView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height))
        tblView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblView?.delegate = self
        tblView?.dataSource = self
        tblView?.backgroundColor = itemBackground
    }
    
    
    
    
    @objc func didTap(_ gesture: UIGestureRecognizer) {
        isCollapsed = !isCollapsed
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        if !isCollapsed {
            let height = CGFloat(items.count > 5 ? itemHeight * 5 : itemHeight * Double(items.count))
            tblView?.layer.zPosition = 1
            tblView?.removeFromSuperview()
            tblView?.layer.borderColor = UIColor.lightGray.cgColor
            tblView?.layer.borderWidth = 1
            tblView?.layer.cornerRadius = 15
            superview?.addSubview(tblView!)
            tblView?.reloadData()
            
            UIView.animate(withDuration: 0.25, animations: {() -> Void in
                if self.isDirectionDown {
                    self.tblView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height + 5, width: self.frame.size.width, height: height)
                }
                else {
                    self.tblView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y - 5 - height, width: self.frame.size.width, height: height)
                }
            })
            
            if delegate != nil {
                delegate?.didHide(self)
            }
            var view = UIView(frame: UIScreen.main.bounds)
            view.tag = 99121
            superview?.insertSubview(view, belowSubview: tblView!)
            tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
            
            view.addGestureRecognizer(tapGestureBackground!)
            label?.addGestureRecognizer(tapGesture)
        }
        else{
            label?.removeGestureRecognizer(tapGesture)
            self.collapseTableView();
        }
    }
    
    @objc func didTapBackground(_ gesture: UIGestureRecognizer) {
        isCollapsed = true
        collapseTableView()
    }
    
    func collapseTableView() {
        if isCollapsed {
            UIView.animate(withDuration: 0.25, animations: {() -> Void in
                if self.isDirectionDown {
                    self.tblView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height + 5, width: self.frame.size.width, height: 0)
                }
                else {
                    self.tblView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: 0)
                }
            })
            superview?.viewWithTag(99121)?.removeFromSuperview()
            if delegate != nil {
                delegate?.didShow(self)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.textAlignment = NSTextAlignment.left
        cell?.textLabel?.text = items[indexPath.row] as! String
        cell?.textLabel?.font = itemsFont
        cell?.textLabel?.textColor = itemTextColor
        
        if indexPath.row == selectedIndex {
            cell?.accessoryType = .checkmark
        }
        else {
            cell?.accessoryType = .none
        }
        cell?.backgroundColor = itemBackground
        cell?.tintColor = tintColor
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(itemHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = Int(indexPath.row)
        label?.text = items[selectedIndex] as? String
        if itemsIDs.count > 0 {
            tag = itemsIDs[selectedIndex] as! Int
        }
        isCollapsed = true
        collapseTableView()
        if delegate != nil {
            delegate?.didSelectItem(self, at: selectedIndex)
        }
    }
    
}



