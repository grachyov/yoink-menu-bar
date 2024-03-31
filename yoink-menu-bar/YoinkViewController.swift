// ∅ yoink-menu-bar 2024

import Cocoa
import WebKit

class YoinkViewController: NSViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var quitButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: "https://google.com")!)
        webView.load(request)
    }
    
    @objc private func warnBeforeQuitting() {
        let alert = NSAlert()
        alert.messageText = "quit yoink?"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "ok")
        alert.addButton(withTitle: "cancel")
        alert.buttons.last?.keyEquivalent = "\u{1b}"
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            NSApp.terminate(nil)
        }
    }
    
    @IBAction func quitButtonClicked(_ sender: Any) {
        warnBeforeQuitting()
    }
    
}
