// ∅ yoink-menu-bar 2024

import Cocoa

struct Images {
    
    static var icon: NSImage { systemName("flag") } // TODO: add custom icon
    
    private static func named(_ name: String) -> NSImage {
        return NSImage(named: name)!
    }
    
    private static func systemName(_ systemName: String) -> NSImage {
        return NSImage(systemSymbolName: systemName, accessibilityDescription: nil)!
    }
    
}


