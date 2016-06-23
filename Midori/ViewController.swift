//
//  ViewController.swift
//  Midori
//
//  Created by hanwe on 2016/6/6.
//  Copyright © 2016年 hanwe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSThread.sleepForTimeInterval(7.0)//延長7秒
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

