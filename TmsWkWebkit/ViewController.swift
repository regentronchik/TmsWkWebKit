import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate{
    var webView: WKWebView!
    var backButton: UIBarButtonItem!
    var forwardButton: UIBarButtonItem!
    var refreshButton: UIBarButtonItem!
    var addressBar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        addressBar = UITextField()
        addressBar.translatesAutoresizingMaskIntoConstraints = false
        addressBar.borderStyle = .roundedRect
        addressBar.placeholder = "Введите URL"
        addressBar.delegate = self
        
        backButton = UIBarButtonItem(title: "👈", style: .plain, target: self, action: #selector(goBack))
        forwardButton = UIBarButtonItem(title: "👉", style: .plain, target: self, action: #selector(goForward))
        refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.items = [backButton, forwardButton, UIBarButtonItem(customView: addressBar), refreshButton]
        view.addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: toolbar.topAnchor)
        ])
        
        let url = URL(string: "https://www.google.com")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         addressBar.text = webView.url?.absoluteString
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let urlText = textField.text, let url = URL(string: urlText) {
            webView.load(URLRequest(url: url))
        }
        textField.resignFirstResponder()
        return true
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func refresh() {
        webView.reload()
    }
}
