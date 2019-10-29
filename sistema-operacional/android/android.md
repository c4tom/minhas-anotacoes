#Desenvolvimento

- [How to Speed up the Android Emulator by up to 400%](https://doc.nuxeo.com/blog/speeding-up-the-android-emulator/)


## Emulador


```sh
#https://fosspost.org/tutorials/install-android-8-1-oreo-on-linux

qemu-img create -f qcow2 android-oreo.img 32G

qemu-system-x86_64 -m 2048 -boot d -enable-kvm -smp 3 -net nic -net user -hda android-oreo.img -cdrom /downloads/iso/android-x86-8.1-r2.iso

# Booting com HD
qemu-system-x86_64 -m 2048 -boot d -enable-kvm -smp 3 -net nic -net user -hda android-oreo.img



```

** Emulador AVD **
https://developer.android.com/studio/run/emulator-commandline.html#startup-options