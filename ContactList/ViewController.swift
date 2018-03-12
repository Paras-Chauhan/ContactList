//
//  ViewController.swift
//  ContactList
//
//  Created by Appinventiv mac on 23/02/18.
//  Copyright © 2018 Appinventiv mac. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellID = "cell123"
    
    func TapforFavourite(cell123 : UITableViewCell)
    {
        // try to figure out which name is we are tapping
        guard let indexPathTapped = tableView.indexPath(for: cell123 ) else
        { return
            
        }
        print(indexPathTapped)
        let contact = TwoDimensionalArray[(indexPathTapped.section)].names[(indexPathTapped.row)]
        print(contact)
        
        let hasFavorited = contact.hasFavourited

        TwoDimensionalArray[(indexPathTapped.section)].names[(indexPathTapped.row)].hasFavourited = !hasFavorited
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    
    let FirstName = [ "Paras","Nishant","Khushboo","Shivangi","Tanya","Natasha" ,"Sunil","Deepak","Shubham","Vasu"]
     let Secondnames = [ "Ritwik","Vansh","Arjun","AAstha","Diyvya"]
    
     let Thirdnames = [ "Deepak","Dramebaaz","Daman","Doli"]
    
    var TwoDimensionalArray = [
        ExpandableNames(isExpanded : true, names: [ "Paras","Nishant","Khushboo","Shivangi","Tanya","Natasha" ,"Sunil","Deepak","Shubham","Vasu"].map{
            Contact(name : $0,hasFavourited: false)
        }),
        ExpandableNames(isExpanded : true, names:["Ritwik","Vansh","Arjun","AAstha","Diyvya"].map{
            Contact(name : $0,hasFavourited: false)}),
        ExpandableNames(isExpanded : true, names: [
            Contact(name: "Paras", hasFavourited: false)])
   
    ]
    var showIndexPath = false
    
    @objc func handleShowIndexPath() {
       
        print ("Attempting Animations ....")
        
        // Build all the indexPath we want to Reload
        
        var indexPathToReload = [IndexPath]()
        
        for section in TwoDimensionalArray.indices
        {
         for row in TwoDimensionalArray[section].names.indices
         {
                print(section,row)
            let indexPath = IndexPath(row : row ,section: section)
            indexPathToReload.append(indexPath)
            }
        }
      
//        for index in TwoDimensionalArray[0].indices {
//           let indexPath = IndexPath(row : index ,section : 0)
//            indexPathToReload.append(indexPath)
//
//        }
      // let indexPath = IndexPath(row : 0, section :0)
        
        showIndexPath = !showIndexPath
        let animationStyle = showIndexPath ?
        UITableViewRowAnimation.right : .left
            tableView.reloadRows(at: indexPathToReload , with: animationStyle )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Show Index Path",style : .plain,target : self,action : #selector(handleShowIndexPath))
        
        navigationItem.title = "contoller"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ContactCell.self , forCellReuseIdentifier: cellID)
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type : .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = UIColor.lightGray
   
       button.addTarget(self, action: #selector (handleExpandClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
    }
    @objc func handleExpandClose(button : UIButton) {
            print ("Trying to Expand the section")
        print(button.tag)
             let section = button.tag
            
            var indexPaths = [IndexPath]()
            for row in TwoDimensionalArray[section].names.indices
            {
                print(0,row)
        
                let indexPath = IndexPath(row: row,section : section)
                indexPaths.append(indexPath)
           }
    
        let isExpanded = TwoDimensionalArray[section].isExpanded
        
        TwoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "OPEN" : "CLOSE" , for : .normal)
        
        if isExpanded
        {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        else
        {
            tableView.insertRows(at: indexPaths, with: .fade)
       }
        
        }
        
       
//        let label = UILabel()
//        label.text = "Header"
//        label.backgroundColor = UIColor.lightGray
//        return label
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TwoDimensionalArray.count
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if !TwoDimensionalArray[section].isExpanded {
            return 0
        }
        return TwoDimensionalArray[section].names.count
        
        
//        if(section == 0){
//            return FirstName.count
//        }
//        else
//        {
//            return Secondnames.count
//       }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ContactCell
        
        cell.link = self
       
        //let name  = self.names[indexPath.row]
        //let name = indexPath.section == 0 ? FirstName[indexPath.row] : Secondnames[indexPath.row]
        
        
        let contact = TwoDimensionalArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = contact.name
        
        
        cell.accessoryView?.tintColor = contact.hasFavourited ? UIColor.blue: .lightGray
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        if showIndexPath
        {
             cell.textLabel?.text = "\(contact.name) Section: \(indexPath.section) Row:\(indexPath.row)"
        }
       
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

