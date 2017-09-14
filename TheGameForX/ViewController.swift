//
//  ViewController.swift
//  TheGameForX
//
//  Created by Tatsuya Tobioka on 2017/09/14.
//  Copyright © 2017 tnantoka. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let skView = SKView(frame: view.bounds)
        view.addSubview(skView)

        skView.showsFPS = true
        skView.showsDrawCount = true
        skView.showsNodeCount = true
        skView.showsQuadCount = true
        skView.showsPhysics = true

        let scene = GameScene(size: view.bounds.size)
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

