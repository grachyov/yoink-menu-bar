// ∅ yoink-menu-bar 2024

import Cocoa
import Sparkle

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let updaterController: SPUStandardUpdaterController
    
    override init() {
        updaterController = SPUStandardUpdaterController(startingUpdater: false, updaterDelegate: nil, userDriverDelegate: nil)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        StatusBarItem.shared.showButton()
        StatusBarItem.shared.showPopover(onLaunch: true)
    }
        
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        StatusBarItem.shared.showPopover(onLaunch: true)
        return true
    }
    
}
