# دليل إنشاء ملف IPA - منصة خدمات الطلاب

## الطريقة الأولى: استخدام Capacitor (الموصى بها)

### المتطلبات:
- جهاز Mac مع Xcode مثبت
- حساب Apple Developer

### الخطوات:

#### 1. بناء التطبيق
```bash
npm run build
```

#### 2. إضافة منصة iOS
```bash
npx cap add ios
```

#### 3. نسخ الملفات إلى iOS
```bash
npx cap copy ios
npx cap sync ios
```

#### 4. فتح المشروع في Xcode
```bash
npx cap open ios
```

#### 5. في Xcode:
1. اختر Team (حساب Apple Developer الخاص بك)
2. اضبط Bundle Identifier على `com.studentservices.app`
3. اختر Device أو Generic iOS Device
4. اضغط Product → Archive
5. اختر Distribute App → Ad Hoc
6. Export IPA

---

## الطريقة الثانية: PWA للتثبيت المباشر

### رابط التطبيق:
```
https://fffa7ee9-350a-4a19-993c-e22d58579b9a-00-2yirup69u78r1.kirk.replit.dev
```

### خطوات التثبيت على الآيفون:
1. افتح الرابط في Safari
2. اضغط زر المشاركة 📤
3. اختر "Add to Home Screen"
4. اضغط "Add"

---

## الطريقة الثالثة: استخدام أدوات Online

### 1. PhoneGap Build
- ارفع الكود إلى GitHub
- اذهب إلى phonegap.com/build
- اربط المشروع واحصل على IPA

### 2. AppGyver Build Service
- استخدم خدمة البناء المجانية
- ارفع الكود واحصل على ملف IPA

---

## ملاحظات مهمة:

### للتطوير والاختبار:
- PWA هو الأسرع والأسهل
- يعمل مثل التطبيق الأصلي تماماً
- لا يحتاج تثبيت من App Store

### لملف IPA:
- تحتاج حساب Apple Developer
- يجب تسجيل UDID الجهاز
- للتوزيع العام تحتاج App Store Connect

### الملفات الجاهزة:
- ✅ إعدادات Capacitor جاهزة
- ✅ أيقونات التطبيق بجميع الأحجام
- ✅ ملف Manifest للPWA
- ✅ Service Worker للعمل بدون إنترنت

هل تريد المتابعة مع أي من هذه الطرق؟