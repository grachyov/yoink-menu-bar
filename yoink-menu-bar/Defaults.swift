// ∅ yoink-menu-bar 2024

import Foundation

struct Defaults {
    
    private static let defaults = UserDefaults.standard
    
    static var didLaunchBefore: Bool {
        get {
            defaults.bool(forKey: #function)
        }
        set {
            defaults.setValue(newValue, forKey: #function)
        }
    }
    
}
