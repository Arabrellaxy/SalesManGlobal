//
//  ViewController.swift
//  SalesManGlobal
//
//  Created by Arabrellaxy on 10/30/2018.
//  Copyright (c) 2018 Arabrellaxy. All rights reserved.
//

import UIKit
import SalesManGlobal
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.backgroundColor = UIColor.black
        let classBundle = Bundle.init(for: SWSegmentDropDown.classForCoder())
        let path = classBundle.path(forResource:"SalesManGlobal" , ofType: "bundle")
        let bundle = Bundle.init(path: path!)
        let segment:SWSegmentDropDown = bundle?.loadNibNamed("SWSegmentDropDown", owner: nil, options: nil)?.first as! SWSegmentDropDown
        segment.segmentWithTitles(defaultTitles: ["test","test"], dataSource: [[["0","1"]],[["2","3"],[["4","5","000"],["5","6"]],[[["a"]]]]], allowMultipleSelect: false)
        segment.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.view.frame.size.width, height: 44))
        self.view.addSubview(segment)
//        let bundle1 = Bundle.init(for: ViewController.classForCoder())
//        let path = bundle1.path(forResource: "XYModuleLogin", ofType: "bundle")!
//
//        let bundle:Bundle = Bundle.init(path:path)!
//        let vc:ViewController = UIStoryboard.init(name: "Main", bundle: bundle).instantiateViewController(withIdentifier: "Login") as! ViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

