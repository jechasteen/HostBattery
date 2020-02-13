//
//  StatusMenuController.swift
//  HostBattery
//
//  Created by Jonathan Chasteen on 2/6/20.
//  Copyright © 2020 Jonathan Chasteen. All rights reserved.
//

import Cocoa
import ServiceManagement

class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    var interval: TimeInterval = 1
    var timer: Timer?
    var state: String = "" {
        didSet {
            updateStatusItem()
        }
    }
    var percentage: String = "" {
        didSet {
            updateStatusItem()
        }
    }
    
    @objc private func getUpdatedState() {
        let url = URL(string: "http://10.0.2.2:8080")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil {
                print("ERROR: \(error!)")
                return
            }
            
            do {
                if let info = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, String> {
                    self.state = info["state"]!
                    self.percentage = info["percentage"]!
                    print(self.state)
                    print(self.percentage)
                }
            } catch let error as NSError {
                print("Error serializing response: \(error)")
            }
        }
        
        task.resume()
    }
    
    private func updateStatusItem() {
        DispatchQueue.main.async {
            switch self.state {
            case "fully-charged":
                self.statusItem.title = self.percentage
            case "discharging":
                self.statusItem.title = "-" + self.percentage
            case "charging":
                self.statusItem.title = "+" + self.percentage
            default:
                self.statusItem.title = self.percentage
            }
        }
    }
    
    override func awakeFromNib() {
        getUpdatedState()
        statusItem.menu = statusMenu
    }
    
    override init() {
        super.init()
        getUpdatedState()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(getUpdatedState), userInfo: nil, repeats: true)
    }
}
