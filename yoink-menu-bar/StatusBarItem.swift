// ∅ yoink-menu-bar 2024

import Cocoa
import WebKit

class StatusBarItem: NSObject, NSPopoverDelegate {
    
    static let shared = StatusBarItem()
    private override init() { super.init() }
    
    private var statusBarItem: NSStatusItem?
    private var currentTimer: Timer?
    
    private let popover = NSPopover()
    
    func showButton() {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusBarItem?.button?.image = Images.flag
        statusBarItem?.button?.imagePosition = .imageOnly
        statusBarItem?.button?.imageScaling = .scaleProportionallyDown
        statusBarItem?.button?.target = self
        statusBarItem?.button?.action = #selector(statusBarButtonClicked)
    }
    
    func showPopover(onLaunch: Bool) {
        if let button = statusBarItem?.button {
            setupPopover()
            if onLaunch {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(420)) { [weak self] in
                    self?.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
            
        }
    }
    
    private func setupPopover() {
        popover.behavior = .transient
        popover.contentSize = NSSize(width: Defaults.hidesFluid ? 230 : 460, height: 630)
        let viewController = instantiate(YoinkViewController.self)
        viewController.containingPopover = popover
        popover.contentViewController = viewController
        popover.delegate = self
    }
    
    @objc private func statusBarButtonClicked(sender: NSStatusBarButton) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            showPopover(onLaunch: false)
        }
    }
    
    func popoverDidClose(_ notification: Notification) {
        currentTimer?.invalidate()
        currentTimer = nil
        popover.contentViewController = nil
        statusBarItem?.button?.image = Images.ok
        currentTimer = Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(itsTime), userInfo: nil, repeats: false)
    }
    
    @objc private func itsTime() {
        statusBarItem?.button?.image = Images.flag
        currentTimer = nil
    }
    
}
