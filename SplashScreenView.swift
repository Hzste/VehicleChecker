import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            if isActive {
                ContentView()
            } else {
                Color(red: 22/255, green: 22/255, blue: 22/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                    
                    // Create content background
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 325, height: 410)
                        .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                        .offset(y: 110)
                    
                    // Add Logo
                    Image("AppLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .offset(y: -225)
                        .scaleEffect(CGSize(width: 1.08, height: 1.1))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
