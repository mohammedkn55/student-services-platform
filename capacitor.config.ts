import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.studentservices.app',
  appName: 'منصة خدمات الطلاب',
  webDir: 'client/dist',
  server: {
    androidScheme: 'https'
  },
  ios: {
    scheme: 'Student Services',
    backgroundColor: '#8b5cf6'
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      backgroundColor: "#8b5cf6",
      androidSplashResourceName: "splash",
      androidScaleType: "CENTER_CROP",
      showSpinner: true,
      androidSpinnerStyle: "large",
      iosSpinnerStyle: "small",
      spinnerColor: "#999999",
      splashFullScreen: true,
      splashImmersive: true
    }
  }
};

export default config;