import SwiftUI
import WebKit

struct WebViewStruct: UIViewRepresentable {
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
        var parent: WebViewStruct
        
        init(_ parent: WebViewStruct) {
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
struct BookFinderView: View {
    var body: some View {
        WebView(requestURL: URL(string: "https://edenpr.follettdestiny.com/common/welcome.jsp?context=saas087_2222558")!)
            .edgesIgnoringSafeArea(.all)
        taskBar(selectedTab: 2)
    }
}

struct BookFinderView_Previews: PreviewProvider {
    static var previews: some View {
        BookFinderView()
    }
}
