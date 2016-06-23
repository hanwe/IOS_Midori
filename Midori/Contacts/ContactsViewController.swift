//
//  ContactsViewController.swift
//  Emiir
//
//  Created by hanwe on 2016/5/10.
//  Copyright © 2016年 hanwe. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource
{
    var contractsGroups: NSArray!
    var contractsArray = [ContactsInfo]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        contractsGroups = loadContactsList()
        contractsArray = contractsGroups as! [ContactsInfo]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contractsGroups!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContractsID", forIndexPath: indexPath) as! ContactsTableViewCell
        
        cell.nameLabel.text = contractsArray[indexPath.row].name
        cell.positionLabel.text = contractsArray[indexPath.row].positionJob
        cell.emailLabel.text = contractsArray[indexPath.row].email
        cell.phoneLabel.text = contractsArray[indexPath.row].phone
        cell.faxLabel.text = contractsArray[indexPath.row].fax
        cell.addressLabel.text = contractsArray[indexPath.row].address
        
        return cell
    }
    
    func loadContactsList() -> NSArray
    {
        var ContractsInfo: NSMutableArray?
        let fileUrl = NSBundle.mainBundle().URLForResource("Contacts", withExtension: "plist")
        let GroupDictionariesArray: NSArray?  = NSArray(contentsOfURL: fileUrl!)
        
        ContractsInfo = NSMutableArray(capacity: GroupDictionariesArray!.count)
        
        for GroupDictionary in GroupDictionariesArray!
        {
            let contactsInfo: ContactsInfo = ContactsInfo()
            
            contactsInfo.name = GroupDictionary["Name"] as! String
            contactsInfo.positionJob = GroupDictionary["Position"] as! String
            contactsInfo.email = GroupDictionary["Email"] as! String
            contactsInfo.phone = GroupDictionary["Phone"] as! String
            contactsInfo.fax = GroupDictionary["Fax"] as! String
            contactsInfo.address = GroupDictionary["Address"] as! String
           
            ContractsInfo!.addObject(contactsInfo)
        }
        
        return ContractsInfo!
    }
}
