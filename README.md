# UIQuickMenu


Currently supports only portrait orientation.

Usage:

 // Adding quick menu to view controller
override func viewDidLoad() {
     super.viewDidLoad()

     // Adding quick menu
     if let quickMenu = UIQuickMenu(withMenuOptions: [.QUICK_LAUGH, .QUICK_LOVE, .QUICK_SMILE, .QUICK_THOUGHT]) {
         quickMenu.menuSelectionDelegate = self
         view.addSubview(quickMenu)
     }
 }
    
