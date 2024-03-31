// ∅ yoink-menu-bar 2024

import Cocoa

class StatusBarItem: NSObject {
    
    static let shared = StatusBarItem()
    private override init() { super.init() }
    
    private var statusBarItem: NSStatusItem?
    
    func show() {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusBarItem?.button?.image = Images.icon
        statusBarItem?.button?.imagePosition = .imageOnly
        statusBarItem?.button?.imageScaling = .scaleProportionallyDown
        statusBarItem?.button?.target = self
        statusBarItem?.button?.action = #selector(statusBarButtonClicked(sender:))
    }
    
    private func createMenu() -> NSMenu {
        let menu = NSMenu(title: "yoink")
        // TODO: add yoink frame
        menu.delegate = self
        let quitItem = NSMenuItem(title: "quit", action: #selector(warnBeforeQuitting), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)
        return menu
    }
    
    @objc private func statusBarButtonClicked(sender: NSStatusBarButton) {
        guard let event = NSApp.currentEvent, event.type == .rightMouseUp || event.type == .leftMouseUp else { return }
        statusBarItem?.menu = createMenu()
        statusBarItem?.button?.performClick(nil)
    }
    
    @objc private func warnBeforeQuitting() {
        let alert = NSAlert()
        alert.messageText = "quit yoink?"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "ok")
        alert.addButton(withTitle: "cancel")
        alert.buttons.last?.keyEquivalent = "\u{1b}"
        let response = alert.runModal()
        switch response {
        case .alertFirstButtonReturn:
            NSApp.terminate(nil)
        default:
            break
        }
    }
    
}

extension StatusBarItem: NSMenuDelegate {
    
    func menuDidClose(_ menu: NSMenu) {
        statusBarItem?.menu = nil
    }
    
}
