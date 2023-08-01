//
//  CryptoCurrencyView.swift
//  dataXplorer
//
//  Created by Muhammad Farkhanudin on 01/08/23.
//  Copyright © 2023 Muhammad Farkhanudin. All rights reserved.
//

import SwiftUI

struct CryptoCurrencyView: View {
    @State private var bitcoinPrice: Double = 0.0

    var body: some View {
        NavigationView {
            VStack {
                Text("Bitcoin Price in EUR")
                    .font(.title)
                    .fontWeight(.bold)

                Text("\(bitcoinPrice) EUR")
                    .font(.headline)
                    .padding(.bottom, 20)

                Button(action: {
                    self.loadData()
                }) {
                    Text("Check Price")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
            .navigationBarTitle("Coin Desk", displayMode: .inline)
        }
    }

    private func loadData() {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice/EUR.json") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(BitcoinPriceResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.bitcoinPrice = decodedResponse.bpi.eur.rateFloat
                    }
                    return
                }
            }

            print("Failed to load Bitcoin price")
        }.resume()
    }
}

struct CryptocurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyView()
    }
}

struct BitcoinPriceResponse: Codable {
    let bpi: Bpi
}

struct Bpi: Codable {
    let eur: Eur

    enum CodingKeys: String, CodingKey {
        case eur = "EUR"
    }
}

struct Eur: Codable {
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case rateFloat = "rate_float"
    }
}
