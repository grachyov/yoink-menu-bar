// ∅ yoink-menu-bar 2024

import Foundation

struct Defaults {
    
    private static let defaults = UserDefaults.standard
    
    static var isShrinked: Bool {
        get {
            defaults.bool(forKey: #function)
        }
        set {
            defaults.setValue(newValue, forKey: #function)
        }
    }
    
    static var preferredSize: CGSize {
        return isShrinked ? CGSize(width: 230, height: 453) : CGSize(width: 640, height: 530)
    }
    
}
