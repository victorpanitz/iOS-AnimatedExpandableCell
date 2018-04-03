//
//  CustomCell.swift
//  ExpandableCell
//
//  Created by Victor Magalhaes on 27/03/2018.
//  Copyright © 2018 Victor Magalhaes. All rights reserved.
//

// TYPE 0 = UITextField

import Foundation
import UIKit

class CustomTextFieldCell : UITableViewCell {
    
    var label : UILabel = {
        let mLabel = UILabel()
        mLabel.textColor = UIColor.black
        mLabel.text = "Victor Panitz Magalhães"
        mLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        mLabel.textAlignment = .left
        mLabel.numberOfLines = 2
        mLabel.minimumScaleFactor = 0.5
        mLabel.adjustsFontSizeToFitWidth = true
        return mLabel
    }()
    
    var containerView : UIView = {
       let mContainerView = UIView()
        return mContainerView
    }()
    
    var arrowImg : UIImageView = {
        var mImage = UIImageView()
        mImage.image = UIImage(named: "up-arrow")!.withRenderingMode(.alwaysTemplate)
        mImage.contentMode = .scaleAspectFit
        mImage.tintColor = UIColor.black
        mImage.clipsToBounds = true
        return mImage
    }()
    
    var textField : UITextField = {
        let mTextField = UITextField()
        mTextField.placeholder = "Text input"
        mTextField.font = UIFont.systemFont(ofSize: 12)
        mTextField.textColor = UIColor.black
        mTextField.backgroundColor = UIColor.white
        mTextField.keyboardType = .alphabet
        mTextField.isUserInteractionEnabled = true
        mTextField.textAlignment = .center
        return mTextField
    }()
    
    var datePicker : UIDatePicker = {
        let mDatePicker = UIDatePicker()
        mDatePicker.datePickerMode = UIDatePickerMode.date
        mDatePicker.timeZone = NSTimeZone.local
        mDatePicker.maximumDate = Date()
        return mDatePicker
    }()
    
    private var firstRun = true
    var isExpanded = false
    var cellHeight: CGFloat = 44
    var type: Int? {
        didSet{
            type = oldValue ?? type
            setupCell(type!)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)        {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell(type)
    }
    
    func setupCell(_ type: Int){
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(arrowImg)
        arrowImg.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 44),
            
            arrowImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            arrowImg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            arrowImg.heightAnchor.constraint(equalToConstant: 16),
            arrowImg.widthAnchor.constraint(equalToConstant: 16),
            
            containerView.topAnchor.constraint(equalTo: self.label.bottomAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        switch type {
        case 1:
            containerView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: self.containerView.topAnchor),
                textField.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -8),
                textField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8),
                textField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8)
                ])
            
        case 2:
            containerView.addSubview(datePicker)
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                datePicker.topAnchor.constraint(equalTo: self.containerView.topAnchor),
                datePicker.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
                datePicker.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                datePicker.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
                
                ])
        default:
            print("default")
        }
        
    
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }

    
}
