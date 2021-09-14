//
//  ViewController.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    let progress = ProgressBarComponent(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = progress
        view.backgroundColor = UIColor.blueDark
        title = "Poc"
   
        // Do any additional setup after loading the view.
    }

}
