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
import AWSMobileHubHelper

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
//        initAWSPushNotification()
        
//        showAlertWithTitle("Test", message: "[\"aps\": {\"alert = 23131;\"}]")
        
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
    
    func initAWSPushNotification()
    {
        let pushManager = AWSPushManager.defaultPushManager()
        pushManager.delegate = self
//        pushManager.registerForPushNotifications()
        if let topicARNs = pushManager.topicARNs {
            pushManager.registerTopicARNs(topicARNs)
        }
        
        if let defaultSubscribeTopic = pushManager.topicARNs?.first
        {
            let topic = pushManager.topicForTopicARN(defaultSubscribeTopic)
            topic.subscribe()
        }
        
        
//        if pushManager.enabled
//        {
//            let topic = pushManager.topics[0]
//            topic.subscribe()
//        }
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


// MARK:- AWSPushManagerDelegate

extension MainViewController: AWSPushManagerDelegate
{
    func pushManagerDidRegister(pushManager: AWSPushManager)
    {
        print("Successfully enabled Push Notifications.")

        // Subscribe the first topic among the configured topics (all-device topic)
        if let defaultSubscribeTopic = pushManager.topicARNs?.first {
            let topic = pushManager.topicForTopicARN(defaultSubscribeTopic)
            topic.subscribe()
        }
    }
    
    func pushManager(pushManager: AWSPushManager, didFailToRegisterWithError error: NSError)
    {

        showAlertWithTitle("Error", message: "Failed to enable Push Notifications.")
    }
    
    func pushManager(pushManager: AWSPushManager, didReceivePushNotification userInfo: [NSObject : AnyObject]) {
        dispatch_async(dispatch_get_main_queue(), {
            print("Received a Push Notification: \(userInfo)")
            
            let aps = userInfo["aps"] as? [NSObject: AnyObject]
            let msg = aps!["alert"] as? String
            
            self.showAlertWithTitle("Received a Push Notification.", message: userInfo.description)
        })
    }
    
    func pushManagerDidDisable(pushManager: AWSPushManager)
    {
        print("Successfully disabled Push Notification.")
    }
    
    func pushManager(pushManager: AWSPushManager, didFailToDisableWithError error: NSError)
    {
        print("Failed to subscibe to a topic: \(error)")
        showAlertWithTitle("Error", message: "Failed to unsubscribe from all the topics.")
    }
}

// MARK:- AWSPushTopicDelegate

extension MainViewController: AWSPushTopicDelegate
{
    
    func topicDidSubscribe(topic: AWSPushTopic)
    {
        print("Successfully subscribed to a topic: \(topic.topicName)")
    }
    
    func topic(topic: AWSPushTopic, didFailToSubscribeWithError error: NSError)
    {
        print("Failed to subscribe to topic: \(topic.topicName)")
        showAlertWithTitle("Error", message: "Failed to subscribe to \(topic.topicName)")
    }
    
    func topicDidUnsubscribe(topic: AWSPushTopic)
    {
        print("Successfully unsubscribed from a topic: \(topic)")
    }
    
    func topic(topic: AWSPushTopic, didFailToUnsubscribeWithError error: NSError)
    {
        print("Failed to subscribe to a topic: \(error)")
        showAlertWithTitle("Error", message: "Failed to unsubscribe from : \(topic.topicName)")
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
