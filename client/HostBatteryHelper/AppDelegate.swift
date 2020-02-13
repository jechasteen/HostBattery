//
//  AppDelegate.swift
//  HostBatteryHelper
//
//  Created by Jonathan Chasteen on 2/13/20.
//  Copyright © 2020 Jonathan Chasteen. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private let mainIdentifier = "com.jechasteen.HostBattery"

    @objc func terminate() {
        NSApp.terminate(nil)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killLauncher, object: self.mainIdentifier)
        
        let path = Bundle.main.bundlePath as NSString
        var components = path.pathComponents
        components.removeLast()
        components.removeLast()
        components.removeLast()
        components.append("MacOS")
        components.append("HostBattery") //main app name
        
        let newPath = NSString.path(withComponents: components)
        
        NSWorkspace.shared.launchApplication(newPath)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

