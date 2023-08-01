//
//  UniversityListView.swift
//  dataXplorer
//
//  Created by Muhammad Farkhanudin on 31/07/23.
//  Copyright © 2023 Muhammad Farkhanudin. All rights reserved.
//

 import SwiftUI

 struct WelcomeElement: Codable {
     let country: Country
     let domains: [String]
     let alphaTwoCode: AlphaTwoCode
     let stateProvince: JSONNull?
     let webPages: [String]
     let name: String

     enum CodingKeys: String, CodingKey {
         case country, domains
         case alphaTwoCode = "alpha_two_code"
         case stateProvince = "state-province"
         case webPages = "web_pages"
         case name
     }
 }

 enum AlphaTwoCode: String, Codable {
     case id = "ID"
 }

 enum Country: String, Codable {
     case indonesia = "Indonesia"
 }

 typealias Welcome = [WelcomeElement]

 class JSONNull: Codable, Hashable {

     public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
         return true
     }

     public var hashValue: Int {
         return 0
     }

     public init() {}

     public required init(from decoder: Decoder) throws {
         let container = try decoder.singleValueContainer()
         if !container.decodeNil() {
             throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
         }
     }

     public func encode(to encoder: Encoder) throws {
         var container = encoder.singleValueContainer()
         try container.encodeNil()
     }
 }

 struct UniversityListView: View {
     @State private var universities: [WelcomeElement] = []
     @State private var searchText = ""

     var body: some View {
         NavigationView {
             VStack {
                 SearchBar(text: $searchText, onSearchButtonClicked: loadData)
                 List(filteredUniversities, id: \.name) { university in
                     VStack(alignment: .leading) {
                         Text(university.name)
                             .font(.headline)
                         Text("Country: \(university.country.rawValue)")
                             .font(.subheadline)
                             .foregroundColor(.gray)
                     }
                 }
             }
             .navigationBarTitle("University List")
             .onAppear(perform: loadData)
         }
     }

     private func loadData() {
         guard let url = URL(string: "http://universities.hipolabs.com/search?country=Indonesia") else {
             return
         }

         URLSession.shared.dataTask(with: url) { data, response, error in
             if let data = data {
                 if let decodedResponse = try? JSONDecoder().decode(Welcome.self, from: data) {
                     DispatchQueue.main.async {
                         self.universities = decodedResponse
                     }
                     return
                 }
             }

             print("Failed to load universities")
         }.resume()
     }

     private var filteredUniversities: [WelcomeElement] {
         if searchText.isEmpty {
             return universities
         } else {
             return universities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
         }
     }
 }

 struct SearchBar: View {
     @Binding var text: String
     var onSearchButtonClicked: () -> Void

     var body: some View {
         HStack {
             TextField("Search", text: $text, onCommit: onSearchButtonClicked)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding(.horizontal)
                 .disableAutocorrection(true)
             Button(action: onSearchButtonClicked) {
                 Text("Search")
             }
             .padding(.trailing, 8)
         }
     }
 }

 struct UniversityListView_Previews: PreviewProvider {
     static var previews: some View {
         UniversityListView()
     }
 }
