import Foundation
import Combine
import SwiftUI

class DetailsViewModel: ObservableObject {
    
    @Published var vehicleDetails: [String: Any]? = nil
    @Published var showingDetails = false
    @Published var alertMessage: String? = nil
    @Published var alertTitle: String = "Error"
    @Published var showingAlert = false
    
}

extension DetailsViewModel {
    
    // VES API Function
    func fetchVehicleDetails(for registrationNumber: String) {
        
        let urlString = "https://driver-vehicle-licensing.api.gov.uk/vehicle-enquiry/v1/vehicles"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL String")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(ContentView.API_KEY, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["registrationNumber": registrationNumber]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            DispatchQueue.main.async {
                self.alertMessage = "Failed to create request body"
                self.showingAlert = true
            }
            return
        }
        request.httpBody = httpBody

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    self?.alertMessage = "Request error: \(error.localizedDescription)"
                    self?.showingAlert = true
                    return
                }

                guard let data = data else {
                    self?.alertMessage = "No data received"
                    self?.showingAlert = true
                    return
                }

                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   let responseJSON = json as? [String: Any] {
                    if let errors = responseJSON["errors"] as? [[String: Any]], let firstError = errors.first,
                       let title = firstError["title"] as? String,
                       let status = firstError["status"] as? String,
                       let detail = firstError["detail"] as? String {
                        self?.alertTitle = "Error \(status) - \(title)"
                        self?.alertMessage = detail
                        self?.showingAlert = true
                    } else {
                        self?.vehicleDetails = responseJSON
                        self?.showingDetails = true
                    }
                } else {
                    self?.alertMessage = "Failed to parse data."
                    self?.showingAlert = true
                }
                
            }
        }
        task.resume()
    }
    
}
