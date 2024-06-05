import SwiftUI
import WebKit

// UIViewRepresentable component to integrate WKWebView into SwiftUI
struct WebView: UIViewRepresentable {
    var requestURL: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.navigationDelegate = context.coordinator
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: requestURL)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            // Handle the error
            print(error.localizedDescription)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Starting to load the page
            print("Started to load")
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Page loading finished
            print("Finished loading")
        }
    }
}

// SwiftUI view that hosts the WebView
struct RequestFormView: View {
    var body: some View {
        WebView(requestURL: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSeVmwRXS_aQw_FjUUI4xt2MiKEsAOhSo1vjH0AYA-3HGb7I6w/viewform?usp=sf_link")!)
            .edgesIgnoringSafeArea(.all)
        taskBar(selectedTab: 3)
    }
}

// Preview provider for SwiftUI canvas
struct RequestFormView_Previews: PreviewProvider {
    static var previews: some View {
        RequestFormView()
    }
}

// App main entry point

struct RequestFormApp: App {
    var body: some Scene {
        WindowGroup {
            RequestFormView()
        }
    }
}
