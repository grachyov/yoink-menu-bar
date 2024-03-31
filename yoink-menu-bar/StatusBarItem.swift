// ∅ yoink-menu-bar 2024

import Cocoa
import WebKit

class StatusBarItem: NSObject, NSPopoverDelegate {
    
    static let shared = StatusBarItem()
    private override init() { super.init() }
    
    private var statusBarItem: NSStatusItem?
    private let popover = NSPopover()
    
    func show() {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusBarItem?.button?.image = Images.flag
        statusBarItem?.button?.imagePosition = .imageOnly
        statusBarItem?.button?.imageScaling = .scaleProportionallyDown
        statusBarItem?.button?.target = self
        statusBarItem?.button?.action = #selector(statusBarButtonClicked)
    }
    
    private func setupPopover() {
        popover.behavior = .transient
        popover.contentSize = NSSize(width: 230, height: 500)
        popover.contentViewController = instantiate(YoinkViewController.self)
        popover.delegate = self
    }
    
    @objc private func statusBarButtonClicked(sender: NSStatusBarButton) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            if let button = statusBarItem?.button {
                setupPopover()
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    func popoverDidClose(_ notification: Notification) {
        popover.contentViewController = nil
        statusBarItem?.button?.image = Images.ok
        Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(itsTime), userInfo: nil, repeats: false)
    }
    
    @objc private func itsTime() {
        statusBarItem?.button?.image = Images.flag
    }
    
}
