//
//  ViewController.swift
//  AngleSelector
//
//  Created by SpotCam-MBP-01 on 2021/11/15.
//

import UIKit

class ViewController: UIViewController, AngleSelectorDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let selector = AngleSelector(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 100))
//        selector.backgroundColor = UIColor.white
//        self.view.addSubview(selector);
//        selector.initUI(totol_angle: 20, scale_spacing: 10, angle_per_scale: 2)
        if let nib = Bundle.main.loadNibNamed("AngleSelector", owner: self),
               let nibView = nib.first as? AngleSelector {
            nibView.frame = CGRect(x: 0, y: 100, width: self.view.frame.self.width, height: 100)
                 nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                 view.addSubview(nibView)
            nibView.initUI(angle: 0);
            nibView.delegate = self
        }
    }
    func angleSelectorDelegate_scrollto(angle: Int) {
        NSLog("angleSelectorDelegate_scrollto:%d", angle);
    }

}

