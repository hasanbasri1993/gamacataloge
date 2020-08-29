//
//  SearchBar.swift
//  gamacataloge
//
//  Created by Hasan Basri on 16/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var api = Api()

    @State private var searchText: String = ""
    @State var show = false
    @State var txt = ""
    @State var data = ""

    var body: some View {

        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.20392157137393951, blue: 0.23529411852359772, alpha: 1)), location: 0.0007918074261397123),
                    .init(color: Color(#colorLiteral(red: 0.12156862765550613, green: 0.18039216101169586, blue: 0.2078431397676468, alpha: 1)), location: 1)]),
                startPoint: UnitPoint(x: -0.08938116066092056, y: 0.56955788402664),
                endPoint: UnitPoint(x: 0.6099469288521624, y: 1.3496640680055174))

            VStack(alignment: .leading) {

                Text("Search Games")
                .font(.custom("Ubuntu-Bold", size: 30))
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .padding(.top, 80)
                .padding(.leading, 15)
                HStack {
                    TextField("Start typing",
                              text: $searchText,
                              onCommit: { self.performSearch() })
                        .font(.custom("Ubuntu-Reguler", size: 15))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding(.horizontal)

                if api.isLoading {
                    LoadingIndicator()
                    .frame(width: 50, height: 50)                }

                if api.games.isEmpty != true {
                    List {
                        ForEach(api.games) { game in
                            NavigationLink(destination: DetailView(id_game: game.id)) {
                                GameRow(game: game)
                            }
                        }

                    }
                }
                Spacer()

            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.api.isLoading  = false
        }
    }

    func performSearch() {
        api.isLoading = true
        if searchText.count > 2 {
            api.searchGame(query: searchText)
            print(api.games)
        }
    }

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
       SearchView()
    }
}
