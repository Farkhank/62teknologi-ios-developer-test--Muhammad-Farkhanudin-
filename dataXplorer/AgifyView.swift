//
//  AgifyView.swift
//  dataXplorer
//
//  Created by Muhammad Farkhanudin on 01/08/23.
//  Copyright © 2023 Muhammad Farkhanudin. All rights reserved.
//

import SwiftUI
import UserNotifications

struct AgifyView: View {
    @State private var name = ""
    @State private var estimatedAge: Int?
    @State private var showResult = false

    var body: some View {
        VStack {
            Image("Umur")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top)

            Text("Age Predictor")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)

            TextField("Enter name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                self.estimateAgeFromName()
                self.showResult = true
            }) {
                Text("Estimate Age")
                    .foregroundColor(.white)
                    .bold()
            }
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .padding()

            // Use a computed property to conditionally show the result
            resultView

            Spacer()
        }
        .padding()
        .navigationBarTitle("Agify", displayMode: .inline)
    }

    private func estimateAgeFromName() {
        guard let url = URL(string: "https://api.agify.io/?name=\(name)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(AgifyResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.estimatedAge = decodedResponse.age
                        self.showAgeNotification()
                    }
                    return
                }
            }

            print("Failed to estimate age")
        }.resume()
    }

    // Computed property to conditionally show the result
    private var resultView: some View {
        Group<AnyView> {
            if showResult {
                if let age = estimatedAge {
                    return AnyView(
                        Text("Estimated age for \(name): \(age)")
                            .font(.headline)
                            .padding()
                    )
                } else {
                    return AnyView(
                        Text("Failed to estimate age for \(name)")
                            .font(.headline)
                            .padding()
                    )
                }
            } else {
                return AnyView(EmptyView())
            }
        }
    }

    private func showAgeNotification() {
        if let age = estimatedAge {
            let content = UNMutableNotificationContent()
            content.title = "Estimated Age"
            content.body = "The estimated age for \(name) is \(age)"
            content.sound = UNNotificationSound.default

            let request = UNNotificationRequest(identifier: "AgeEstimation", content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request)
        }
    }
}

struct AgifyView_Previews: PreviewProvider {
    static var previews: some View {
        AgifyView()
    }
}

struct AgifyResponse: Codable {
    let name: String
    let age: Int
    let count: Int
}
