//
//  Cell.swift
//  LearnLanguage
//
//  Created by PIRATE on 12/7/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var anotation: UIButton!
    
    @IBOutlet weak var languageimage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        anotation.layer.cornerRadius = 15
        anotation.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
