//
//  ContentView.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import SwiftUI

struct ContentView: View {
    @State var selection: String = "ifconfig"

    var body: some View {
        TabView(selection: $selection) {
            IfconfigView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("Summary")
                    }
                }
                .tag("ifconfig")
            PortView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Ports")
                    }
                }
                .tag("ports")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
