//
//  AppDetails.swift
//  dataXplorer
//
//  Created by Muhammad Farkhanudin on 31/07/23.
//  Copyright © 2023 Muhammad Farkhanudin. All rights reserved.
//

import SwiftUI

struct AppDetail: View {
    var appName: String
    var imageName: String
    var description: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(8)

            Text(appName)
                .font(.headline)
                .foregroundColor(.black)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
        .navigationBarTitle("App Detail", displayMode: .inline)
    }
}

