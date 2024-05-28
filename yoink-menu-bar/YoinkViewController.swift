// ∅ yoink-menu-bar 2024

import Cocoa
import WebKit

class YoinkViewController: NSViewController {
    
    @IBOutlet weak var moreButton: NSButton!
    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var fluidContainerView: NSView!
    
    weak var containingPopover: NSPopover?
    private weak var webView: WKWebView?
    private weak var fluidWebView: WKWebView?
    
    private let webViewConfiguration: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        let preferences = WKWebpagePreferences()
        preferences.preferredContentMode = .desktop
        config.defaultWebpagePreferences = preferences
        let zoomLevel = 0.58
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
        
        loadFluidYoinkIfNeeded()
        
        if !Defaults.didLaunchBefore {
            Defaults.didLaunchBefore = true
        }
    }
    
    private func loadFluidYoinkIfNeeded() {
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        fluidContainerView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.bottomAnchor.constraint(equalTo: fluidContainerView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: fluidContainerView.leadingAnchor),
            webView.widthAnchor.constraint(equalTo: fluidContainerView.widthAnchor),
            webView.heightAnchor.constraint(equalTo: fluidContainerView.heightAnchor)
        ])
        
        self.fluidWebView = webView
        goToFluidYoink()
    }
    
    private func goToFluidYoink() {
        let request = URLRequest(url: URL(string: "https://warpcast.com/vijay/0x2589bcca")!)
        fluidWebView?.load(request)
    }
    
    private func goToYoink() {
        let request = URLRequest(url: URL(string: "https://warpcast.com/horsefacts.eth/0x7ad8fc42")!)
        webView?.load(request)
    }
    
    @IBAction func fluidButtonClicked(_ sender: Any) {
        let wasFluid = containerView.isHidden
        containerView.isHidden.toggle()
        fluidContainerView.isHidden.toggle()
        containingPopover?.contentSize = NSSize(width: 640, height: wasFluid ? 590 : 640)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        containingPopover?.performClose(nil)
    }
    
    @IBAction func moreButtonClicked(_ sender: Any) {
        moreButton.menu?.popUp(positioning: nil, at: CGPoint(x: 23, y: 23), in: moreButton)
    }
    
    @objc private func reload() {
        goToYoink()
        goToFluidYoink()
    }
    
    @objc private func github() {
        NSWorkspace.shared.open(URL(string: "https://github.com/grachyov/yoink-menu-bar")!)
    }
    
    @objc private func quit() {
        NSApp.terminate(nil)
    }
    
}
