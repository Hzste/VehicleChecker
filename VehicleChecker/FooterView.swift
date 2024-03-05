import SwiftUI

struct FooterView: View {
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(red: 229/255, green: 229/255, blue: 229/255))
            
            Text("Copyright @ 2024 - Huseyin Gedes")
                .font(.system(size: 15))
                .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
            
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .edgesIgnoringSafeArea(.bottom)
    }
}
