import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DetailsViewModel()
    @State public static var API_KEY = "Lz2VOyBWom9TTe1BWOTLg7fODkLlBJDG1nxMRiGz"
    @State private var vehicleRegInput = ""
    
    var body: some View {
        
        ZStack {
            
            // Set background color
            Color(red: 22/255, green: 22/255, blue: 22/255)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.dismissKeyboard()
                }

            VStack {
                
                Spacer()
                
                // Create content background
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 325, height: 500)
                    .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                
                // Add Logo
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding(.top, -500)
                
                // Add Title
                Text("Vehicle Checker")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top, -275)
                
                // Add Text Field
                TextField("", text: $vehicleRegInput, prompt: Text("Enter Reg")
                    .foregroundColor(.gray)
                )
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(20)
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 60)
                .frame(height: 50)
                .multilineTextAlignment(.center)
                .textInputAutocapitalization(.characters)
                .padding(.top, -220)
                
                // Add Submit Button
                Button(action: {
                    viewModel.fetchVehicleDetails(for: vehicleRegInput)
                }) {
                    Text("Submit")
                        .padding(.horizontal, 110)
                        .padding(.vertical, 17)
                        .foregroundColor(.white)
                        .background(Color(red: 24/255, green: 184/255, blue: 51/255))
                        .cornerRadius(20)
                        .font(.headline)
                }
                .padding(.top, -140)
                
                Spacer()
                
                // Apply the footer
                FooterView()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $viewModel.showingDetails) {
            if let vehicleDetails = viewModel.vehicleDetails {
                DetailsView(vehicleDetails: vehicleDetails)
            }
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage ?? ""), dismissButton: .default(Text("OK")))
        }

    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

#Preview {
    ContentView()
}
