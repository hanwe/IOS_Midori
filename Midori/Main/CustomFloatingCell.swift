//
//  CustomFloatingCell.swift
//  Midori
//
//  Created by hanwe on 2016/6/7.
//  Copyright © 2016年 hanwe. All rights reserved.
//

import UIKit
import SnapKit
import LiquidFloatingActionButton

class CustomFloatingCell: LiquidFloatingCell
{

    var name: String = "sample"
    
    init(icon: UIImage, name: String) {
        self.name = name
        super.init(icon: icon)
    }
    
    required internal init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func setupView(view: UIView)
    {
        super.setupView(view)
        let label = UILabel()
        label.text = name
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Helvetica-Neue", size: 12)
        addSubview(label)
        label.snp_makeConstraints { make in
            make.left.equalTo(self).offset(-80)
            make.width.equalTo(75)
            make.top.height.equalTo(self)
        }
    }
}
