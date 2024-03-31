// ∅ yoink-menu-bar 2024

import Cocoa
import WebKit

class YoinkViewController: NSViewController {
    
    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var quitButton: NSButton!
    
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
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: containerView.topAnchor),
            webView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
        webView.load(request)
    }
    
    @IBAction func quitButtonClicked(_ sender: Any) {
        NSApp.terminate(nil)
    }
    
}

extension YoinkViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let zoomLevel = 0.42
        let widthPercentage = 100 / zoomLevel
        let script = """
            var scale = \(zoomLevel);
            document.body.style.transform = 'scale(' + scale + ')';
            document.body.style.transformOrigin = 'top left';
            document.body.style.width = '\(widthPercentage)%';
        """
        webView.evaluateJavaScript(script, completionHandler: nil)
    }
    
}
