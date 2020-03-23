//
//  SettingCell.swift
//  Youtube
//
//  Created by Ashwini shalke on 20/03/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            imageIcon.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.labelName.rawValue
            if let image = setting?.imageName {
                imageIcon.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
                imageIcon.tintColor = UIColor.darkGray
                
            }
        }
    }
    
    override func setup() {
        super.setup()
        addSubview(nameLabel)
        addSubview(imageIcon)
        addConstraintswithFormat(format: "H:|-8-[v0(30)]-8-[v1]-|", views: imageIcon,nameLabel)
        addConstraintswithFormat(format: "V:|-[v0]-|", views: nameLabel)
        addConstraintswithFormat(format: "V:|-[v0]-|", views: imageIcon)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        return label
    }()
    
    let imageIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "switch_account")
        icon.contentMode = .scaleAspectFill
        return icon
    }()
}
