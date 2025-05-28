# 📱 دليل استخدام Ionic Appflow لبناء ملف IPA

## ✅ ما أعددته لك:
- ملف `ionic.config.json` جاهز
- إعدادات Capacitor للـ iOS
- مشروع كامل جاهز للرفع

## 🚀 الخطوات في Ionic Appflow:

### 1️⃣ في لوحة التحكم:
- اضغط على **"Import app"**
- اختر **"GitHub"** كمصدر

### 2️⃣ أنشئ مستودع GitHub:
**خيار أ:** من خلال GitHub مباشرة:
1. اذهب إلى github.com
2. أنشئ مستودع جديد باسم "student-services-platform"
3. ارفع جميع ملفات المشروع

**خيار ب:** استخدم Git محلياً:
```bash
git init
git add .
git commit -m "منصة خدمات الطلاب - نسخة أولى"
git remote add origin YOUR_GITHUB_REPO_URL
git push -u origin main
```

### 3️⃣ في Appflow - ربط المستودع:
- الصق رابط مستودع GitHub
- امنح الصلاحيات المطلوبة
- اختر الفرع الأساسي (main/master)

### 4️⃣ إعداد البناء للـ iOS:
1. اذهب إلى **"Builds"**
2. اضغط **"Start build"**
3. اختر **Platform: iOS**
4. اختر **Build type: Release**

### 5️⃣ إعداد الشهادات (مطلوب):
ستحتاج لشهادات Apple Developer:

**أ) Certificate (.p12 file):**
- من Apple Developer Portal
- Certificates → iOS Distribution
- نزل وحول إلى .p12

**ب) Provisioning Profile:**
- من Apple Developer Portal
- Profiles → iOS Distribution
- نزل ملف .mobileprovision

**ج) في Appflow:**
- اذهب إلى Settings → Certificates
- ارفع ملف .p12 وكلمة المرور
- ارفع ملف .mobileprovision

### 6️⃣ بدء البناء:
- اضغط "Start build"
- انتظر 5-10 دقائق
- نزل ملف IPA الجاهز!

## 🔑 شهادات Apple Developer:

### للحصول عليها:
1. **Apple Developer Portal**: developer.apple.com
2. **Certificates, Identifiers & Profiles**
3. **App ID**: com.studentservices.app
4. **Certificate**: iOS Distribution
5. **Provisioning Profile**: Ad Hoc Distribution

## 💡 نصائح:
- احفظ كلمة مرور الشهادة في مكان آمن
- تأكد من إضافة UDID جهازك للProfile
- يمكنك استخدام 50 عملية بناء مجانية شهرياً

هل تحتاج مساعدة في أي من هذه الخطوات؟