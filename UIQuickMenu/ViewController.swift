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
        if let quickMenu = UIQuickMenu(withMenuOptions: [.QUICK_LAUGH, .QUICK_LOVE, .QUICK_SMILE, .QUICK_THOUGHT]) {
            quickMenu.menuSelectionDelegate = self
            view.addSubview(quickMenu)
        }
    }
    
    
    func quickMenu(didSelectAtIndex index: Int, menuOption: QuickMenuOptions) {
        print("Menu \(menuOption.name) selected at \(index)")
    }

}

