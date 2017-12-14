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
class Calendar: UIView, Modal, FSCalendarDelegate{
    var backgroundView = UIView()
    var dialogView = UIView()
    var target:Any?
    
    convenience init(title:String, calendar: inout FSCalendar, _ target:Any) {
        self.init(frame: UIScreen.main.bounds)
        initialize(title: title, calendar: &calendar, target)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(title:String, calendar:inout FSCalendar, _ target:Any){
        dialogView.clipsToBounds = true
        self.target = target
        calendar.delegate = self
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
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if target is UILabel{
            let labelData = target as! UILabel
            labelData.text = "DATA: \(Calendar.formatter.string(from: date))"
        }
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
         dismiss(animated: true)
    }
}


