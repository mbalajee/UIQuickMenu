# UIQuickMenu


Currently supports only portrait orientation.

### Usage

Copy the UIQuickMenu class to your project

```
// Adding quick menu to view controller

override func viewDidLoad() {
     super.viewDidLoad()

     // Adding quick menu
     if let quickMenu = UIQuickMenu(withMenuOptions: [.QUICK_LAUGH, .QUICK_LOVE, .QUICK_SMILE, .QUICK_THOUGHT]) {
         quickMenu.menuSelectionDelegate = self
         view.addSubview(quickMenu)
     }
 }
 ```
 
 #### Menu Items
UIQuickMenu class contains an Enum, "QuickMenuOptions".  

```
enum QuickMenuOptions {
    
    case QUICK_SMILE
    case QUICK_LAUGH
    case QUICK_LOVE
    case QUICK_THOUGHT
    case QUICK_NONE
    
    var name: String  {
        
        switch self {
        case .QUICK_SMILE:
            return "😀"
            
        case .QUICK_LAUGH:
            return "😂"
            
        case .QUICK_LOVE:
            return "😍"
            
        case .QUICK_THOUGHT:
            return "🤔"
            
        case .QUICK_NONE:
            return ""
        }
    }
}
```


#### Adding images
To add image for a menu item, simply give the image name in QuickMenuOptions.
```
In  "func setupQuickMenuOptions()" replace, setTitle with setImage for a UIButton.
```

#### QuickMenu in action

![alt text](https://github.com/mbalajee/UIQuickMenu/blob/master/quick_menu_demo.gif)

    
