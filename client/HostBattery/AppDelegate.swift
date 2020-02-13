//
//  AppDelegate.swift
//  HostBattery
//
//  Created by Jonathan Chasteen on 2/6/20.
//  Copyright © 2020 Jonathan Chasteen. All rights reserved.
//

import Cocoa
import ServiceManagement

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var autoLaunchMenuItem: NSMenuItem!
    
    private let helperIdentifier = "com.jechasteen.HostBatteryHelper" as CFString
    
    @IBAction func toggleAutoLaunch(_ sender: NSMenuItem) {
        if UserDefaults.standard.bool(forKey: "AutoLaunch") {
            if SMLoginItemSetEnabled(self.helperIdentifier, false) {
                UserDefaults.standard.set(false, forKey: "AutoLaunch")
                autoLaunchMenuItem.state = .off
            }
        } else {
            if SMLoginItemSetEnabled(self.helperIdentifier, true) {
                UserDefaults.standard.set(true, forKey: "AutoLaunch")
                autoLaunchMenuItem.state = .on
            }
        }
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if UserDefaults.standard.bool(forKey: "AutoLaunch") {
            autoLaunchMenuItem.state = .on
        }
        DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

