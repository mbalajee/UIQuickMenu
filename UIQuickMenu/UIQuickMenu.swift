//
//  UIQuickMenu.swift
//  UIQuickMenu
//

import UIKit
import GLKit

protocol UIQuickMenuSelectionDelegate {
    func quickMenu(didSelectAtIndex index: Int, menuOption: String)
}

class UIQuickMenu: UIView {
    
    // Delegate the menu click action
    var menuSelectionDelegate: UIQuickMenuSelectionDelegate?
    
    private var arcRadius: CGFloat = 200
    
    private var arcBackgroundPath: UIBezierPath?
    
    // Image file name for menu
    private var menuOptions = [String] ()
    
    // Background shadow
    private var shadow: Shadow!
    
    // Quick menu button
    private var buttonQuickMenu      = UIButton(type: .custom)
    private var buttonQuickImageview = UIImageView()
    
    // Array of menu
    private var menu   = [UIButton]()
    
    // Where menu items should be positioned at the end of animation
    private var endPoints = [CGPoint]()
    
    
    // This class must be instantiated with menu images, it fails otherwise
    convenience init?(withMenuOptions options: [String]) {
        
        guard options.count > 0 else {
            return nil
        }
        
        self.init(frame: UIScreen.main.bounds)
        
        backgroundColor = UIColor.clear
        
        initMenuOptions(options)
        
        setupShadow()
        setupQuickMenuButton()
        setupQuickMenuOptions()
    }
    
    private func initMenuOptions(_ options: [String]) {
        
        // Inserting empty menu at both ends to make menu items regular in size
        // Space is equally divided between menu items, so for two menu items,
        // size of each menu item will be bigger
        if options.count < 3 {
            menuOptions.append("")
            menuOptions.append(contentsOf: options)
            menuOptions.append("")
        } else {
            menuOptions.append(contentsOf: options)
        }
    }
    
    // Background shodow for menu items, for a better distinction of menu items
    private func setupShadow() {
        
        let shadowSize = arcRadius * 2
        
        shadow = Shadow(frame: CGRect(x: 0, y: frame.size.height - shadowSize, width: shadowSize , height: shadowSize))
        shadow.alpha = 0
        addSubview(shadow)
    }
    
    
    // Quick menu button
    private func setupQuickMenuButton() {
        
        if let image  = UIImage(named: "quick_menu") {
            
            let width  = image.size.width * 0.5 // TODO: Remove hard coded value
            let height = image.size.height * 0.5 // TODO: Remove hard coded value
            buttonQuickMenu.frame = CGRect(x: 0, y: frame.size.height - height, width: width, height: width)
            buttonQuickMenu.setImage(image, for: .normal)
            buttonQuickMenu.backgroundColor = .clear
            buttonQuickMenu.addTarget(self, action: #selector(onClickQuickMenu), for: .touchUpInside)
            addSubview(buttonQuickMenu)
        }
    }
    
    
    private func setupQuickMenuOptions()  {
        
        let containerHeight = frame.size.height
        
        let menuCount = CGFloat(menuOptions.count)
        
        let radius = arcRadius
        
        let degree: CGFloat           = 90 / menuCount // Equal spacing for a given menu count in rectangle
        
        let reducedDegree: CGFloat    = degree * 0.5 // Reduce the degree between menu to get equal spacing
        
        let circumference = (2 * CGFloat.pi * radius) / 4 // Circumference of the 1/4th of a Circle
        
        let marginBetweenMenu: CGFloat = 20 * (4 / menuCount)
        
        let circumferenceAfterMargin = circumference - (marginBetweenMenu * (menuCount - 1))
        
        let widthMenu = (circumferenceAfterMargin / menuCount)
        
        var index: CGFloat = 0
        
        for option in menuOptions {
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: widthMenu, height: widthMenu)
            button.center = buttonQuickMenu.center
            button.layer.cornerRadius = widthMenu / 2
            button.backgroundColor = option.isEmpty ? UIColor.clear : UIColor.white
            button.setImage(UIImage(named: option), for: .normal)
            button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
            button.isEnabled = false
            button.alpha = 0
            button.tag = Int(index)
            button.addTarget(self, action: #selector(onClickMenuOption(_:)), for: .touchUpInside)
            addSubview(button)
            
            menu.append(button)
            
            index += 1
            
            let indexDegree             = index * degree // Degree for a menu at this index
            let reducedIndexDegree      = Float(indexDegree - reducedDegree) // To adjust the center position of menu to get equal spacing
            
            let radians = CGFloat(GLKMathDegreesToRadians(reducedIndexDegree)) // Convert degree to radians
            
            let endX = radius * cos((radians))
            let endY = containerHeight - (radius * sin(radians)) // Here origin is (0,90) so reduce the y position by height to get required origin
            
            endPoints.append(CGPoint(x: endX, y: endY))
        }
    }
    
    @objc func onClickQuickMenu() {
        buttonQuickMenu.isSelected = !buttonQuickMenu.isSelected
        animate(show: buttonQuickMenu.isSelected)
    }
    
    @objc func onClickMenuOption(_ menu: UIButton)  {
        
        // Hide menu
        onClickQuickMenu()
        menuSelectionDelegate?.quickMenu(didSelectAtIndex: menu.tag, menuOption: menuOptions[menu.tag])
    }
    
    private func animate(show: Bool) {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            if show {
                
                self.shadow.alpha = 1
                
                for button in self.menu {
                    button.center = self.endPoints[button.tag]
                    button.alpha  = 1
                }
                
            } else {
                
                self.shadow.alpha = 0
                
                for button in self.menu {
                    button.center = self.buttonQuickMenu.center
                    button.alpha  = 0
                }
            }
            
            self.setNeedsDisplay()
            
        }) { (completed) in
            
            if completed {
                for button in self.menu {
                    button.isEnabled = show
                }
            }
        }
    }
    
    
    // To avoid views behind it being unclickable
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        if hitView == self || hitView == shadow
        {
            // Hide quick menu on clicking outside
            if buttonQuickMenu.isSelected {
                onClickQuickMenu()
            }
            return nil
        }
        return hitView
    }
    
    // Shadow behind the quick menu options
    private class Shadow: UIView {
        
        var arcBackgroundPath: UIBezierPath!
        
        override init(frame: CGRect) {
                        
            super.init(frame: frame)
            
            backgroundColor = UIColor.clear
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func draw(_ rect: CGRect) {
            
            UIColor(red: 245, green: 246, blue: 250, alpha: 1.0).set()
            
            arcBackgroundPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: frame.size.height), radius: frame.size.width * 0.8, startAngle: CGFloat.pi/2, endAngle: 0, clockwise: true)
            
            let gradient = CAGradientLayer()
            gradient.frame = bounds
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint   = CGPoint(x: 1, y: 0)
            gradient.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor]
            
            let shapeMask = CAShapeLayer()
            shapeMask.path = arcBackgroundPath.cgPath
            gradient.mask = shapeMask
            
            layer.addSublayer(gradient)
            
        }
        
    }
    
}
