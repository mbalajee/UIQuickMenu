# UIQuickMenu


Currently supports only portrait orientation.

Usage:

 // Adding quick menu
if let quickMenu = UIQuickMenu(withMenuOptions: ["text 1", "text 2"]) {
    quickMenu.menuSelectionDelegate = self
    view.addSubview(quickMenu)
}
