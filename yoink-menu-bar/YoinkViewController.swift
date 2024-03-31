// ∅ yoink-menu-bar 2024

import Cocoa
import WebKit

class YoinkViewController: NSViewController {
    
    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var quitButton: NSButton!
    
    private weak var webView: WKWebView?
    
    private let webViewConfiguration: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        let preferences = WKWebpagePreferences()
        preferences.preferredContentMode = .desktop
        config.defaultWebpagePreferences = preferences
        return config
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: "https://warpcast.com/~/channel/yoink")!)
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            webView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 4),
            webView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 4)
        ])
        webView.load(request)
        self.webView = webView
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        let scaleTransform = CGAffineTransform(scaleX: 1 / 4, y: 1 / 4)
        webView?.layer?.setAffineTransform(scaleTransform)
    }
    
    @IBAction func quitButtonClicked(_ sender: Any) {
        NSApp.terminate(nil)
    }
    
}
