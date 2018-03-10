//
//  ViewController.swift
//  UIQuickMenu
//
//  Created by Balaji M on 3/1/18.
//  Copyright © 2018 Balaji M. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIQuickMenuSelectionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Adding quick menu
        if let quickMenu = UIQuickMenu(withMenuOptions: ["quick_home_address", "quick_camera"]) {
            quickMenu.menuSelectionDelegate = self
            view.addSubview(quickMenu)
        }
    }
    
    
    func quickMenu(didSelectAtIndex index: Int, menuOption: String) {
        print("Menu \(menuOption) selected at \(index)")
    }

}

