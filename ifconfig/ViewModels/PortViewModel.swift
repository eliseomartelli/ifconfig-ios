//
//  IfconfigViewModel.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import SwiftUI

class IfconfigViewModel: NSObject, ObservableObject {
    @Published var ifconfig: Ifconfig?
    @Published var isLoading = false
    @Published var error: Error?

    let service: IfconfigRepositoryService
    
    init (service: IfconfigRepositoryService = IfconfigAPIService.shared) {
        self.service = service
    }
    
    func getIfconfig() {
        self.isLoading = true
        self.error = nil

        service.getIfconfig { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
                case .success(let ifconfig):
                    self.ifconfig = ifconfig
                case .failure(let error):
                    self.error = error
            }
        }
    }
}
