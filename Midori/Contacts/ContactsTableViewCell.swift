//
//  ContactsTableViewCell.swift
//  Emiir
//
//  Created by hanwe on 2016/5/10.
//  Copyright © 2016年 hanwe. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var contactPeople: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var faxLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var callButton: UIButton!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func ClickAction(sender: UIButton)
    {
        if(sender.tag == 0)
        {
//            let email = emailLabel.text
//            let url = NSURL(string: "mailto:\(email)")
            UIApplication.sharedApplication().openURL(NSURL(string: "mailto:\(emailLabel.text!)")!)
        }
        else if(sender.tag == 1)
        {
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(phoneLabel.text!)")!)
        }
    }
}
