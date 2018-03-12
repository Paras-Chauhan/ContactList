//
//  ContactCell.swift
//  ContactList
//
//  Created by Appinventiv mac on 26/02/18.
//  Copyright © 2018 Appinventiv mac. All rights reserved.
//

import UIKit
class ContactCell  : UITableViewCell {
    
    var link : ViewController?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //backgroundColor = .red
        // Kind of Cheat for the favourite star
        
        let starButton = UIButton(type: .system)
        starButton.setTitle("Some Title", for: .normal)
         starButton.setImage(#imageLiteral(resourceName: "starIcon2.jpg"), for: .normal)
        starButton.frame = CGRect(x: 0 , y: 0 ,width : 30, height  :30)
        
        starButton.addTarget(self, action: #selector(handleMarkAsFavourite),for : .touchUpInside)
        
        accessoryView = starButton
    }
    
    @objc func handleMarkAsFavourite()  {
        
        link?.TapforFavourite(cell123: self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
