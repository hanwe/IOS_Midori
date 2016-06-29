//
//  MainViewController.swift
//  Emiir
//
//  Created by hanwe on 2016/4/29.
//  Copyright © 2016年 hanwe. All rights reserved.
//
import Foundation
import UIKit
import LiquidFloatingActionButton
import FirebaseDatabase
import Firebase


class MainViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate
{

    @IBOutlet weak var partnerBaritem: UIBarButtonItem!
    @IBOutlet weak var fbBaritem: UIBarButtonItem!
    @IBOutlet weak var gifImagView: UIImageView!
    @IBOutlet weak var MainTableView: UITableView!
    
    var floatingcells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!
    
    let imagesItem = ["innerbanner1" , "innerbanner2", "innerbanner3", "innerbanner4"]
    let titleTextArray = ["全戶式水處理裝置", "循環水處理裝置", "無藥劑水處理裝置", "無藥劑循環水淨化裝置"]
    let contentsArray = ["1.建築物水管，管線水垢防止及防鏽。\n2.冷卻水塔循環水管線清潔防鏽。" ,
                         "防止水垢附著，水垢的剝離，防止管線腐蝕，管壁上黏液的去除。",
                         "無藥劑水淨化裝置，運用嶄新的電器分解技術，完全不使用藥品。",
                         "1.除去冷卻塔迴圈水裡的汙垢。\n2.防止管路與設備鏽蝕。\n3.節約上下水道用水，節省水費。"]
    
    override func shouldAutorotate() -> Bool
    {
        return false
    }
    
       
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //設定
        self.navigationController?.navigationBar.barTintColor = UIColor.barTintColor()
        
        initCompoment()
        initNavigationbar()
        initFloatingAcctionButton()
        initFirbase()
    }
    
    func initCompoment()
    {
        let gifImage = UIImage.gifWithName("banner")
        gifImagView.image = gifImage
    }
    
    func initNavigationbar()
    {
        //左邊的圖示
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 140, height: 50))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        let letLogoImage = UIBarButtonItem(customView: imageView)
        self.navigationItem.leftBarButtonItem = letLogoImage
        
        //右邊的圖示
        
    }
    
    func initFloatingAcctionButton()
    {
        
        let createButton: (CGRect, LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton = { (frame, style) in
            let floatingActionButton = CustomFloatingActionButton(frame: frame)
            floatingActionButton.animateStyle = style
            floatingActionButton.dataSource = self
            floatingActionButton.delegate = self
            return floatingActionButton
        }
        
        let cellFactory: (String) -> LiquidFloatingCell = { (iconName) in
            let cell = LiquidFloatingCell(icon: UIImage(named: iconName)!)
            return cell
        }
        
        floatingcells.append(cellFactory("id_card_filled"))
        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 50, height: 50)
        let bottomRightButton = createButton(floatingFrame, .Up)
        
        let image = UIImage(named: "ic_add_white")
        bottomRightButton.image = image
        
        self.view.addSubview(bottomRightButton)

    }
    
    func initFirbase()
    {
        let rootRef = FIRDatabase.database().reference()
        rootRef.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            let postDict = snapshot.value as! NSDictionary
            
            let value  = postDict.valueForKey("IOS_Veriosn") as! Int
            
            var version : String
            version = (NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String)!
        
//           if( value)
            if value >= (version as NSString).integerValue
            {
                let alertController = UIAlertController(title: "Midori", message: "建議您更新到最新版以獲得更多的資訊，謝謝", preferredStyle: UIAlertControllerStyle.Alert)
                
                let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
                
                let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: {
                    (action:UIAlertAction!) -> Void in
                    let barsLink : String = "itms-apps://itunes.apple.com/app/id992329064"
                    UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        })
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return imagesItem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell =  MainTableViewCell()
        
        if(indexPath.row == 0)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("HomeEquipmentCell"  , forIndexPath: indexPath) as! MainTableViewCell
        }
        else if(indexPath.row == 1)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("RecycledWaterCell"  , forIndexPath: indexPath) as! MainTableViewCell
        }
        else if(indexPath.row == 2)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("WaterTreatmentCell"  , forIndexPath: indexPath) as! MainTableViewCell
        }
        else if(indexPath.row == 3)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("WaterTreatmentRecycleCell"  , forIndexPath: indexPath) as! MainTableViewCell
        }
        
        cell.titleImage.image = UIImage(named: imagesItem[indexPath.row])
        cell.titleLabel.text = titleTextArray[indexPath.row]
        cell.contnetLabel.text = contentsArray[indexPath.row]
        cell.strName = imagesItem[indexPath.row]
        
        return cell
    }
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int
    {
        return floatingcells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell
    {
        return floatingcells[index]
    }
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int)
    {
        let VC1 = UIStoryboard(name: "Main", bundle: nil) .instantiateViewControllerWithIdentifier("ContactsID")
        self.navigationController?.pushViewController(VC1, animated: true)
        
        liquidFloatingActionButton.close()
    }
    
    
}

// MARK:- Utility methods

extension MainViewController
{
    private func showAlertWithTitle(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}
