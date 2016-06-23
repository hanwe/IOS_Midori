//
//  PartnerWebViewController.swift
//  Emiir
//
//  Created by hanwe on 2016/4/28.
//  Copyright © 2016年 hanwe. All rights reserved.
//

import UIKit

class PartnerWebViewController: UIViewController {

    @IBOutlet var partnerWeb: UIWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //載入
        let url = NSURL(string: "https://docs.google.com/forms/d/14P4MGqvYCRH8ZFgyNp0cpkgKecFmX6mtbupKnfHAvEQ/viewform?c=0&w=1")
        let request = NSURLRequest(URL: url!)
        partnerWeb.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
