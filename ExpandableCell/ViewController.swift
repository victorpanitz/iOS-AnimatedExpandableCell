//
//  ViewController.swift
//  ExpandableCell
//
//  Created by Victor Magalhaes on 26/03/2018.
//  Copyright © 2018 Victor Magalhaes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let newTableView : UITableView = {
        let mTableView = UITableView()
        mTableView.tableFooterView = UIView()
        mTableView.register(CustomCell.self, forCellReuseIdentifier: "mCell")
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return mTableView
    }()
    
    let type = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newTableView.delegate = self
        self.newTableView.dataSource = self
        setupLayout()
    }

    func setupLayout(){
        self.view.addSubview(newTableView)
        newTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.newTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.newTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.newTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.newTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func updateCell(_ indexPath: IndexPath){
        self.newTableView.deselectRow(at: indexPath, animated: true)
        let cell = (self.newTableView.cellForRow(at: indexPath) as! CustomCell)
        if cell.isExpanded {
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
                cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: self.view.frame.width, height: 44)
                cell.arrowImg.transform = CGAffineTransform.identity
                cell.layoutIfNeeded()
            }, completion: { (finished: Bool)  in
                    cell.cellHeight = 44
                    self.newTableView.reloadData()
            })
        }else{
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: self.view.frame.width, height: cell.type == 1 ? 88 : 176)
                cell.arrowImg.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
                cell.layoutIfNeeded()
            }, completion: { (finished: Bool)  in
                cell.cellHeight = cell.type == 1 ? 88 : 176
                self.newTableView.reloadData()
            })
        }
        cell.isExpanded = !cell.isExpanded
    }
    
    @objc func handleCustomTxtField(sender: UITextField){
        (newTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CustomCell).label.text = "Name: \(sender.text!)"
    }
    
    @objc func handleCustomDatePicker(sender: UIDatePicker){
        let mDateFormatter: DateFormatter = DateFormatter()
        mDateFormatter.dateFormat = "MM/dd/yyyy"
        let mSelectedDate = mDateFormatter.string(from: sender.date)
        (newTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! CustomCell).label.text = "Date: \(mSelectedDate)"
    }
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as! CustomCell
            cell.type = type.textFieldCell
            cell.backgroundColor = UIColor.white
            cell.textField.addTarget(self, action: #selector(handleCustomTxtField(sender:)), for: .editingChanged)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as! CustomCell
            cell.type = type.datePickerCell
            cell.backgroundColor = UIColor.white
            cell.datePicker.addTarget(self, action: #selector(handleCustomDatePicker(sender:)), for: .valueChanged)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.newTableView.cellForRow(at: indexPath) as? CustomCell)?.cellHeight != nil ?
            (self.newTableView.cellForRow(at: indexPath) as! CustomCell).cellHeight :
            CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateCell(indexPath)
    }


}





