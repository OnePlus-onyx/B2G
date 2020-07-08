# Boot to Gecko (B2G)

Boot to Gecko aims to create a complete, standalone operating system for the open web.

You can read more about B2G here:

  http://wiki.mozilla.org/B2G
  
  https://developer.mozilla.org/en-US/docs/Mozilla/B2G_OS

Follow us on twitter: @Boot2Gecko

  http://twitter.com/Boot2Gecko

Join the Mozilla Platform mailing list:

  http://groups.google.com/group/mozilla.dev.platform

and talk to us on Matrix:

  https://chat.mozilla.org/#/room/#b2g:mozilla.org

Discuss with Developers:

  Discourse: https://discourse.mozilla-community.org/c/b2g-os-participation

# Building and running the android-10 emulator x86_64

1. Fetch the code: `REPO_INIT_FLAGS="--depth=1" ./config.sh emulator-10-x86_64`
2. Setup your environment to fetch the custom NDK: `export LOCAL_NDK_BASE_URL='ftp://ftp.kaiostech.com/ndk/android-ndk'`
3. Install Gecko dependencies: `cd gecko && ./mach bootstrap`, choose option 4 (Android Geckoview).
4. Build: `./build.sh`
5. Run the emulator: `source build/envsetup.sh && lunch aosp_arm-userdebug && emulator -writable-system -selinux permissive`

# Buiding for devices

## Google Pixel 3a (sargo)

1. Fetch the code: `REPO_INIT_FLAGS="--depth=1" ./config.sh sargo`
2. Download and extract Google and Qualcomm blobs QQ2A.200501.001.B2 from https://developers.google.com/android/drivers#bonitoqq2a.200501.001.b2 
3. Download, extract and flash Android Factory image QQ2A.200501.001.B2 from https://dl.google.com/dl/android/aosp/sargo-qq2a.200501.001.b2-factory-cc3250a0.zip
4. Setup your environment to fetch the custom NDK: `export LOCAL_NDK_BASE_URL='ftp://ftp.kaiostech.com/ndk/android-ndk'`
5. Install Gecko dependencies: `cd gecko && ./mach bootstrap`, choose option 4 (Android Geckoview).
6. Build: `./build.sh`
7. Boot the Android system, go to settings, enable developer mode and enable OEM Unlock
8. Reboot into fastboot mode and issue
   - `fastboot flashing unlock`
   - `fastboot flashing unlock_critical`
9. Flash: `./flash_sargo.sh`

At boot time, you might need `adb shell setenforce 0` for B2G to boot (flash_sargo.sh does it).

## OnePlus X (onyx)

1. Fetch the code: `REPO_INIT_FLAGS="--depth=1" ./config.sh onyx`
2. Setup your environment to fetch the custom NDK: `export LOCAL_NDK_BASE_URL='ftp://ftp.kaiostech.com/ndk/android-ndk'`
3. Install Gecko dependencies: `cd gecko && ./mach bootstrap`, choose option 4 (Android Geckoview).
4. Build: `./build.sh`
7. Boot the Android system, go to settings, enable developer mode and enable OEM Unlock
8. Reboot into fastboot mode
9. Flash: `./flash_onyx.sh`

If need to output a zip ROM file, you can use `./build.sh dist DIST_DIR=dist_output` instead of `./build.sh` in step 4.

# Re-building your own NDK

Because it's using a different c++ namespace than the AOSP base, we can't use the prebuilt NDK from Google. If you can't use the one built by KaiOS, here are the steps to build your own:
1. Download the ndk source:
`repo init -u https://android.googlesource.com/platform/manifest -b ndk-release-r20`
2. change `__ndk` to `__` in `external/libcxx/include/__config`:
```diff
-#define _LIBCPP_NAMESPACE _LIBCPP_CONCAT(__ndk,_LIBCPP_ABI_VERSION)
+#define _LIBCPP_NAMESPACE _LIBCPP_CONCAT(__,_LIBCPP_ABI_VERSION)
```
3. Build the ndk:
`python ndk/checkbuild.py --no-build-tests`
