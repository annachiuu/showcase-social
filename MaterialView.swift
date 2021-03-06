//
//  MasterView.swift
//  first-social-media
//
//  Created by anna :)  on 8/10/16.
//  Copyright © 2016 Anna Chiu. All rights reserved.
//

/*** for styling changes ***/

import UIKit

class MaterialView: UIView {
    
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }
   
}
