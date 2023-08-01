import SwiftUI

struct ContentView: View {
    @State private var showHome = false

    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Image("Logoawal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text("dataXplorer")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text("Berisi Data")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                // Use NavigationLink instead of sheet
                NavigationLink(destination: Home(), isActive: $showHome) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                        Text("Get Started")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .frame(width: 200, height: 70)
                .background(Color.purple)
                .onTapGesture {
                    self.showHome = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


