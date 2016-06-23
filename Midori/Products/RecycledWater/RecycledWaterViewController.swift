//
//  RecycledWaterViewController.swift
//  Emiir
//
//  Created by hanwe on 2016/5/4.
//  Copyright © 2016年 hanwe. All rights reserved.
//

import UIKit

class RecycledWaterViewController: UIPageViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate
{

    var index = 0

    private(set) lazy var orderedViewControllers: [UIViewController] =
    {
        return [self.newColoredViewController("Display_product_Image", strImageName: "recycled_water_1")]
    }()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first
        {
            setViewControllers([firstViewController],
                                direction: .Forward,
                                animated: true,
                                completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func newColoredViewController(strname: String, strImageName: String) -> UIViewController
    {
        let ImageZoomView  = UIStoryboard(name: "Main", bundle: nil) .instantiateViewControllerWithIdentifier("\(strname)") as! ImageZoomViewController
        ImageZoomView.strImageName = strImageName
        
        return ImageZoomView
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else
        {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else
        {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else
        {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else
        {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else
        {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else
        {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func viewControllerAtIndex(index: Int) -> RecycledWaterViewController?
    {
        if index == NSNotFound || index < 0 || index >= orderedViewControllers.count
        {
            return nil
        }

        return nil
    }
    
}
