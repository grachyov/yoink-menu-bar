// ∅ yoink-menu-bar 2024

import Cocoa

struct Images {
    
    static var flag: NSImage { systemName("flag") }
    static var ok: NSImage { systemName("hand.thumbsup") }
    
    private static func named(_ name: String) -> NSImage {
        return NSImage(named: name)!
    }
    
    private static func systemName(_ systemName: String) -> NSImage {
        return NSImage(systemSymbolName: systemName, accessibilityDescription: nil)!
    }
    
}


