# Host battery monitor for macOS VMs

![screenshot](screenshot.png)

## Installation Notes

There are two components to this applet

1. The nodejs server, found in `host/`
2. The macOS menu bar applet found in `client/`

You can use the [provided bundle](https://github.com/jechasteen/HostBattery/releases), or clone and build the xcode project on the vm.

*Be aware* that in the current build, the client's router IP is hard-coded to `10.0.2.2`.
Using the client app with a different network configuration is undefined.

- The macOS build process has not been tested on any other machines besides my own, a High Sierra vm created using [macOS-Simple-KVM](https://github.com/foxlet/macOS-Simple-KVM) running Xcode 10.0

## Installation procedure

1. Clone the repo on the host machine
2. Run `node host/index.js` (add this to your xinitrc or equivalent to start on login)
3. Copy HostBattery.app to `Applications` and run it
4. Optionally, click menu item to enable launch on login
