//
//  ifconfigApp.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import SwiftUI

@main
struct ifconfigApp: App {
    
    @StateObject var ifconfig = IfconfigViewModel()
    @StateObject var port = PortViewModel()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ifconfig)
                .environmentObject(port)
                .onAppear {
                    ifconfig.getIfconfig()
                }
        }
    }
}
