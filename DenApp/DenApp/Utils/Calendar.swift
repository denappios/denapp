//
//  Calendar.swift
//  tabbarCustom
//
//  Created by Pelorca on 09/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar
class CalendarSwift: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    
    convenience init(title:String, calendar: inout FSCalendar) {
        self.init(frame: UIScreen.main.bounds)
        initialize(title: title, calendar: &calendar)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(title:String, calendar:inout FSCalendar){
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.lightGray
        backgroundView.alpha = 0.3
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let dialogViewWidth = frame.width-64
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: dialogViewWidth-16, height: 30))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        dialogView.addSubview(titleLabel)
        
        let separatorLineView = UIView()
        separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 8)
        separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 1)
        separatorLineView.backgroundColor = UIColor.groupTableViewBackground
        dialogView.addSubview(separatorLineView)
        
        
        calendar.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
        calendar.frame.size = CGSize(width: dialogViewWidth - 16 , height: dialogViewWidth - 16)
        
        calendar.layer.cornerRadius = 5
        calendar.clipsToBounds = true
        
        dialogView.addSubview(calendar)
        
        
        
        let dialogViewHeight = titleLabel.frame.height + 8 + separatorLineView.frame.height + 8 + calendar.frame.height + 8
        
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width-64, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        
        
        dialogView.layer.masksToBounds = false
        dialogView.layer.shadowColor = UIColor.black.cgColor
        dialogView.layer.shadowOpacity = 0.5
        dialogView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        dialogView.layer.shadowRadius = 5
        
        addSubview(dialogView)
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
}


