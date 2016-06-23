//
//  ImageZoomViewController.swift
//  Emiir
//
//  Created by hanwe on 2016/5/10.
//  Copyright © 2016年 hanwe. All rights reserved.
//

import UIKit

class ImageZoomViewController: UIViewController, UIScrollViewDelegate
{

    @IBOutlet weak var zoomScrollView: UIScrollView!
    @IBOutlet weak var zoomImageView: UIImageView!
    
    var strImageName: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.zoomScrollView.minimumZoomScale = 1.0
        self.zoomScrollView.maximumZoomScale = 4.0
        
        let pdImage = UIImage(named: strImageName)
        zoomImageView.image = pdImage
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return self.zoomImageView
    }

    
}
