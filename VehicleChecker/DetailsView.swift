import SwiftUI

struct DetailsView: View {
    
    var vehicleDetails: [String: Any]
    
    let keys: [String] = [
        "Registration Number",
        "Make",
        "Year of Manufacture",
        "Colour",
        "Engine Capacity",
        "Fuel Type",
        "Wheelplan",
        "Revenue Weight",
        "Month of First Registration",
        "Tax Status",
        "Tax Due Date",
        "MOT Status",
        "MOT Expiry Date",
        "Date of Last V5C Issued",
        "Type Approval"
    ]

    var body: some View {
        NavigationView {
            // If statement to check if the API Key is valid
            if shouldDisplayErrorMessage() {
                VStack {
                    Text("No Data Found - Check API Key")
                        .foregroundColor(.white)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .navigationTitle("Vehicle Details")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                List {
                    ForEach(keys, id: \.self) { key in
                        if let formattedKey = formatKeyJSON(key: key),
                           let detailValue = vehicleDetails[formattedKey] {
                            DetailRow(key: formatKeyForDisplay(key: key), value: "\(detailValue)")
                        }
                    }
                }
                .navigationTitle("Vehicle Details")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    // Check if the error message should be displayed
    private func shouldDisplayErrorMessage() -> Bool {
        if let message = vehicleDetails["message"] as? String, !message.isEmpty {
            return true
        } else {
            // Additionally, check if the details are meaningful
            for key in keys {
                if let formattedKey = formatKeyJSON(key: key),
                   vehicleDetails[formattedKey] != nil {
                    return false // Found at least one meaningful detail
                }
            }
            return true // No meaningful details found
        }
    }

    // Convert the display key name into the format used in the JSON
    private func formatKeyJSON(key: String) -> String? {
        let words = key.split(separator: " ").map(String.init)
        guard !words.isEmpty else { return nil }
        
        return words.enumerated().map { index, word in
            index == 0 ? word.lowercased() : word.capitalizingFirstLetter()
        }.joined()
    }

    // Format the key for display by capitalizing the first letter of each word
    private func formatKeyForDisplay(key: String) -> String {
        key.components(separatedBy: " ").map { $0.capitalizingFirstLetter() }.joined(separator: " ")
    }
}

struct DetailRow: View {
    
    var key: String
    var value: String

    var body: some View {
        HStack {
            Text(key)
                .fontWeight(.bold)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + lowercased().dropFirst()
    }
}
