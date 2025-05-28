# دليل إنشاء ملف IPA للآيفون

## المتطلبات:
- جهاز Mac مع Xcode
- حساب Apple Developer (مجاني أو مدفوع)
- شهادة iOS Developer Certificate

## الخطوات:

### 1. إنشاء مشروع iOS جديد
```bash
# إنشاء مجلد المشروع
mkdir StudentServicesApp
cd StudentServicesApp

# إنشاء مشروع Xcode
xcodebuild -project StudentServicesApp.xcodeproj
```

### 2. إعداد WebView في iOS
إنشاء ViewController يحتوي على WebView يشير إلى التطبيق:

```swift
import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // رابط التطبيق المباشر
        let url = URL(string: "https://your-app-url.replit.dev")!
        let request = URLRequest(url: url)
        webView.load(request)
        webView.navigationDelegate = self
    }
    
    // إخفاء شريط التنقل
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.querySelector('meta[name=viewport]').setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0');")
    }
}
```

### 3. إعداد Info.plist
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
<key>UIRequiresFullScreen</key>
<true/>
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>
```

### 4. إنشاء ملف IPA
1. افتح Xcode
2. اختر Product → Archive
3. اختر Distribute App
4. اختر Ad Hoc أو Development
5. اختر Export IPA

## الطريقة الثانية: استخدام PWA (الأسهل)

التطبيق الحالي PWA ويمكن تثبيته مباشرة:

### للآيفون:
1. افتح Safari
2. اذهب إلى رابط التطبيق
3. اضغط على زر المشاركة 📤
4. اختر "Add to Home Screen"
5. اضغط "Add"

### رابط التطبيق:
```
https://fffa7ee9-350a-4a19-993c-e22d58579b9a-00-2yirup69u78r1.kirk.replit.dev
```

## الطريقة الثالثة: استخدام أدوات Online

### Capacitor (موصى به)
```bash
npm install @capacitor/core @capacitor/cli @capacitor/ios
npx cap init StudentServicesApp com.example.studentservices
npx cap add ios
npx cap run ios
```

### PhoneGap Build
1. أرفع الكود إلى GitHub
2. اذهب إلى phonegap.com/build
3. ارفق المشروع
4. احصل على ملف IPA

## ملاحظات مهمة:
- لتثبيت IPA تحتاج UDID الجهاز مسجل في Apple Developer
- للتوزيع العام تحتاج App Store Connect
- PWA أسهل وأسرع للاختبار

هل تريد المتابعة مع أي من هذه الطرق؟