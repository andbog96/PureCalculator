//
//  ViewController.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 21.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onButtonTouchUpInside(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "nil")
    }
    
}

