//
//  Shop.swift
//  dataXplorer
//
//  Created by Muhammad Farkhanudin on 31/07/23.
//  Copyright © 2023 Muhammad Farkhanudin. All rights reserved.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HomeAppRow(appName: "University List", imageName: "University", description: "University List App Description", destination: AnyView(UniversityListView()))
                HomeAppRow(appName: "Coin Desk", imageName: "Bitcoinlogo", description: "CoinDesk Description", destination: AnyView(CryptoCurrencyView()))
                HomeAppRow(appName: "Agify", imageName: "Age", description: "Agify App Description", destination: AnyView(AgifyView()))
                HomeAppRow(appName: "Dog Image", imageName: "Dog Image", description: "Random Dog Image Description", destination: AnyView(RandomDogImagesView()))
                HomeAppRow(appName: "Gender Detection", imageName: "MaleFemale", description: "Gender Detection App Description", destination: AnyView(GenderDetectionView()))
                HomeAppRow(appName: "Jokes", imageName: "Funny Emoji", description: "Jokes App Description", destination: AnyView(JokesView()))
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("Home", displayMode: .inline)
    }
}

struct HomeAppRow: View {
    var appName: String
    var imageName: String
    var description: String
    var destination: AnyView // Use AnyView type for destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(2)

                VStack(alignment: .leading) {
                    Text(appName)
                        .font(.headline)
                        .foregroundColor(.black)

                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}


struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

