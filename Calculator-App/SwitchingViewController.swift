//
//  SwitchingViewController.swift
//  Calculator-App
//
//  Created by Tirthrajsinh Chauhan on 2018-10-11.
//  Copyright © 2018 Tirthrajsinh Chauhan. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {



   
    private var blueViewController: ViewController!
    private var yellowViewController: SecondViewController!
    
    private func switchViewController(from fromVC:UIViewController?,
                                      to toVC:UIViewController? ){
        if fromVC != nil{
            fromVC!.willMove(toParentViewController: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParentViewController()
        }
        if toVC != nil {
            self.addChildViewController(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParentViewController: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueViewController = storyboard?.instantiateViewController(withIdentifier: "Blue")as!
        ViewController
        
        blueViewController.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController)
        // helper method
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        if yellowViewController?.view.superview == nil{
            if yellowViewController == nil{
                yellowViewController = storyboard?.instantiateViewController(withIdentifier: "Yellow") as! SecondViewController
            }
        }
        else if blueViewController?.view.superview == nil{
            if blueViewController == nil{
                blueViewController = storyboard?.instantiateViewController(withIdentifier: "Blue") as! ViewController
            }
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        if blueViewController != nil
            && blueViewController!.view.superview != nil {
            yellowViewController.view.frame = view.frame
            switchViewController(from:blueViewController, to: yellowViewController)
            
        }
        else{
            blueViewController.view.frame = view.frame
            switchViewController(from:yellowViewController, to:blueViewController)
            
        }
        UIView.commitAnimations()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if blueViewController != nil
            && blueViewController!.view.superview == nil {
            blueViewController = nil
        }
        if yellowViewController != nil
            && yellowViewController!.view.superview == nil{
            yellowViewController = nil
        }
    }
    

 

}
