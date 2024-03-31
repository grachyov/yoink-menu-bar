// ∅ yoink-menu-bar 2024

import Cocoa
import WebKit

class YoinkViewController: NSViewController {
    
    private var isIncreased = false
    
    @IBOutlet weak var resizeButton: NSButton!
    @IBOutlet weak var moreButton: NSButton!
    @IBOutlet weak var containerView: NSView!
    
    weak var containingPopover: NSPopover?
    private weak var webView: WKWebView?
    
    private let webViewConfiguration: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        let preferences = WKWebpagePreferences()
        preferences.preferredContentMode = .desktop
        config.defaultWebpagePreferences = preferences
        let zoomLevel = 0.69
        let scriptSource = "document.body.style.zoom = '\(zoomLevel)';"
        let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(userScript)
        return config
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: "https://warpcast.com/horsefacts.eth/0x68f8d903")!)
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            webView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            webView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        webView.load(request)
        self.webView = webView
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        containingPopover?.performClose(nil)
    }
    
    @IBAction func moreButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func resizeButtonClicked(_ sender: Any) {
        if isIncreased {
            containingPopover?.contentSize = NSSize(width: 230, height: 540)
        } else {
            containingPopover?.contentSize = NSSize(width: 1024, height: 800)
        }
        isIncreased.toggle()
    }
    
    private func quit() {
        NSApp.terminate(nil)
    }
    
}
