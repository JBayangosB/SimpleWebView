package jbayangosb.simplewebview

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.webkit.CookieManager
import android.webkit.WebChromeClient
import android.webkit.WebViewClient
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    companion object {
        private const val BASE_URL = "https://www.fastmail.com/"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setupView()
    }

    private fun setupView() {
        CookieManager.getInstance().setAcceptCookie(true)
        webView.apply {
            webViewClient = WebViewClient()
            webChromeClient = WebChromeClient()
        }
        webView.settings.apply {
            javaScriptEnabled = true
            allowFileAccess = true
            allowContentAccess = true
            domStorageEnabled = true
            allowFileAccessFromFileURLs = true
            allowUniversalAccessFromFileURLs = true
        }
        webView.loadUrl(BASE_URL)
    }
}
