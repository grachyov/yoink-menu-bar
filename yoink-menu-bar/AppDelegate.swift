// ∅ yoink-menu-bar 2024

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        StatusBarItem.shared.show()
    }
        
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // TODO: show something
        return true
    }
    
}
