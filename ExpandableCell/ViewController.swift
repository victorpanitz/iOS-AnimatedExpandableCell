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
        mTableView.register(CustomCell.self, forCellReuseIdentifier: "mCell")
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
        if (self.newTableView.cellForRow(at: indexPath) as! CustomCell).isExpanded {
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
                (self.newTableView.cellForRow(at: indexPath) as! CustomCell).frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
                (self.newTableView.cellForRow(at: indexPath) as! CustomCell).arrowImg.transform = CGAffineTransform.identity
                (self.newTableView.cellForRow(at: indexPath) as! CustomCell).layoutIfNeeded()
            }, completion: { (finished: Bool)  in
                    (self.newTableView.cellForRow(at: indexPath) as! CustomCell).cellHeight = 44
                    self.newTableView.reloadData()
            })
        }else{
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                (self.newTableView.cellForRow(at: indexPath) as! CustomCell).frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 88)
                (self.newTableView.cellForRow(at: indexPath) as! CustomCell).arrowImg.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
                (self.newTableView.cellForRow(at: indexPath) as! CustomCell).layoutIfNeeded()
            }, completion: { (finished: Bool)  in
                (self.newTableView.cellForRow(at: indexPath) as! CustomCell).cellHeight = 88
                self.newTableView.reloadData()
            })
            
        }
        (self.newTableView.cellForRow(at: indexPath) as! CustomCell).isExpanded = !(self.newTableView.cellForRow(at: indexPath) as! CustomCell).isExpanded

    }
    
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor.lightGray
        cell.label.text = "Name: Victor Panitz Magalhães"
        return cell
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





