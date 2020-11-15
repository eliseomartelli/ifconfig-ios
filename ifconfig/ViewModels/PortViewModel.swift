//
//  IfconfigViewModel.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import SwiftUI

class PortViewModel: NSObject, ObservableObject {
    @Published var port: Port?
    @Published var isLoading = false
    @Published var error: Error?

    let service: IfconfigRepositoryService
    
    init (service: IfconfigRepositoryService = IfconfigAPIService.shared) {
        self.service = service
    }
    
    func getPort(port: Int) {
        self.isLoading = true
        self.error = nil

        service.getPort(port: port) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
                case .success(let port):
                    self.port = port
                case .failure(let error):
                    self.error = error
            }
        }
    }
}
