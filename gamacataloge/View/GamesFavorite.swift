//
//  GamesFavorite.swift
//  gamacataloge
//
//  Created by Hasan Basri on 29/08/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

struct GamesFavorite: View {

    @ObservedObject var api = Api()

    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }

    var body: some View {

        ZStack {
            LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.20392157137393951, blue: 0.23529411852359772, alpha: 1)), location: 0.0007918074261397123),
                        .init(color: Color(#colorLiteral(red: 0.12156862765550613, green: 0.18039216101169586, blue: 0.2078431397676468, alpha: 1)), location: 1)]),
                    startPoint: UnitPoint(x: -0.08938116066092056, y: 0.56955788402664),
                    endPoint: UnitPoint(x: 0.6099469288521624, y: 1.3496640680055174))

            if api.isLoading {
                LoadingIndicator()
                        .frame(width: 50, height: 50)
            } else {
                List {
                    Text("Games Favorite")
                            .font(.custom("Ubuntu-Bold", size: 30))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .padding(.top, 80)
                    ForEach(api.games) { game in
                        NavigationLink(destination: DetailView(id_game: game.id)) {
                            GameRow(game: game)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    self.api.fetchData(genre: "action")
                }

    }

}

class GamesFavorite_Previews: PreviewProvider {
    static var previews: some View {
        GamesFavorite()
    }
/*
    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: GamesFavorite())
    }
    #endif*/
}
