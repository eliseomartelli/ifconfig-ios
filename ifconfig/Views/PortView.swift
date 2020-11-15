//
//  PortView.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import SwiftUI

struct PortView: View {
    @State var text = ""
    @EnvironmentObject var portViewModel: PortViewModel

    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $text)
                Button("Check") {
                    portViewModel.getPort(port: Int(text) ?? 80)
                }
            }.padding()
            Spacer()
            if let data = portViewModel.port {
                Text("Port \(data.port) is " + (data.reachable ? "open" : "closed"))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            Spacer()
        }
    }
}

struct PortView_Previews: PreviewProvider {
    static var previews: some View {
        PortView()
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Port (Example: 80)", text: $text)
            .keyboardType(.numberPad)
            .padding()
            .background(Color(.tertiarySystemFill))
            .cornerRadius(8)
    }
}
