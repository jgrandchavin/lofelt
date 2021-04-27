# 📳 Lofelt

![test image size](lofelt_logo.png)

🔗 [Official Lofelt website](https://lofelt.com)

**Unlock the Power of Haptics in Mobile Devices on Flutter**

**Lofelt** builds state-of-the-art **haptic technologies** for iOS and Android developers and creatives.

## ⚠️ Disclaimer

🖥 This package is NOT developed by Lofelt

🍏 The haptics works only for iOS for the moment

📃 Lofelt is busy moving their iOS framework and Android library to a permissive license so you can safely use this package without a Lofelt license.

## ⛏ Getting started

### 🎙 Create .haptic files

To create `.haptic` file from sound, download [Lofelt Studio](https://lofelt.com/downloads) and see [Lofelt Studio documentation](https://developer.lofelt.com)

### 💼 Add .haptic files in your pubspec.yaml

***Example:***
```
 assets:
    - assets/haptics/
``` 

### ⚡️ Init Lofelt in a Widget

```
 await Lofelt.init();
``` 

### ➕️ Load a .haptic file in Lofelt

```
  await Lofelt.load('assets/haptics/test.haptic');
``` 

### ▶️ Play the file !

```
  await Lofelt.play();
``` 

### ⏹ Stop

```
  await Lofelt.stop();
``` 

**To see Lofelt integration with sound, see example**

## 🗺 RoadMap


| Feature | Status |
| ------------- |:-------------:|
| Play .haptic on iOS 🍏 | ✅ |
| Play .haptic on Android 🤖 | ❌ |     










