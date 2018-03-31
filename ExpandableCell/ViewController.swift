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
        mTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        mTableView.register(CustomTextFieldCell.self, forCellReuseIdentifier: "mCell")
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        return mTableView
    }()
    
    
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
        let cell = (self.newTableView.cellForRow(at: indexPath) as! CustomTextFieldCell)
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
                cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: self.view.frame.width, height: 88)
                cell.arrowImg.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
                cell.layoutIfNeeded()
            }, completion: { (finished: Bool)  in
                cell.cellHeight = 88
                self.newTableView.reloadData()
            })
        }
        cell.isExpanded = !cell.isExpanded

    }
    
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as! CustomTextFieldCell
            cell.backgroundColor = UIColor.lightGray
            cell.label.text = "Name: Victor Panitz Magalhães"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
            cell.textLabel?.text = "Any Text"
            return cell

        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.newTableView.cellForRow(at: indexPath) as? CustomTextFieldCell)?.cellHeight != nil ?
            (self.newTableView.cellForRow(at: indexPath) as! CustomTextFieldCell).cellHeight :
            CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateCell(indexPath)
    }

   
    
}





