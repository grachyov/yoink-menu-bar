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
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            webView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            webView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        self.webView = webView
        goToYoink()
        let menu = NSMenu(title: "")
        let reloadItem = NSMenuItem(title: "reload", action: #selector(reload), keyEquivalent: "")
        let githubItem = NSMenuItem(title: "github", action: #selector(github), keyEquivalent: "")
        let quitItem = NSMenuItem(title: "quit", action: #selector(quit), keyEquivalent: "q")
        reloadItem.target = self
        githubItem.target = self
        quitItem.target = self
        menu.addItem(reloadItem)
        menu.addItem(githubItem)
        menu.addItem(quitItem)
        moreButton.menu = menu
    }
    
    private func goToYoink() {
        let request = URLRequest(url: URL(string: "https://warpcast.com/horsefacts.eth/0x68f8d903")!)
        webView?.load(request)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        containingPopover?.performClose(nil)
    }
    
    @IBAction func moreButtonClicked(_ sender: Any) {
        moreButton.menu?.popUp(positioning: nil, at: CGPoint(x: 23, y: 23), in: moreButton)
    }
    
    @IBAction func resizeButtonClicked(_ sender: Any) {
        if isIncreased {
            containingPopover?.contentSize = NSSize(width: 230, height: 540)
        } else {
            containingPopover?.contentSize = NSSize(width: 1024, height: 800)
        }
        isIncreased.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(42)) { [weak self] in
            self?.goToYoink()
        }
    }
    
    @objc private func reload() {
        goToYoink()
    }
    
    @objc private func github() {
        NSWorkspace.shared.open(URL(string: "https://github.com/grachyov/yoink-menu-bar")!)
    }
    
    @objc private func quit() {
        NSApp.terminate(nil)
    }
    
}
