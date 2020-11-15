//
//  IfconfigView.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import SwiftUI

struct IfconfigView: View {
    
    @EnvironmentObject var ifconfig: IfconfigViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if let data = ifconfig.ifconfig {
                    ScrollView {
                        VStack {
                            Info(description: "IP", data: "\(data.ip)")
                            Info(description: "Country", data: "\(data.country)")
                            Info(description: "Region", data: "\(data.region_name)")
                            Info(description: "ZIP Code", data: "\(data.zip_code)")
                            Info(description: "City", data: "\(data.city)")
                            Info(description: "Time Zone", data: "\(data.time_zone)")
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationBarTitle("Ifconfig")
        }
    }
}

struct IfconfigView_Previews: PreviewProvider {
    static var previews: some View {
        IfconfigView()
    }
}

struct Info: View {
    let description: String
    let data: String
    var body: some View {
        HStack {
            Text("\(description)")
            Spacer()
            Text("\(data)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}
