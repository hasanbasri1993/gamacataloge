//
//  ContentView.swift
//  gamacataloge
//
//  Created by Hasan Basri on 05/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.imageCache) var cache: ImageCache
    @ObservedObject var api = Api()
    @State var genreN = "Action"
    @State var genreS = "action"
    @State var genreA = false
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        NavigationView {
            
            Group {
                VStack(alignment: .center, spacing: 0) {
                    List {
                        Text("Games \(genreN)")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .padding(.top, 30)
                        
                        ScrollView(.horizontal) {
                            VStack(alignment: .leading) {
                                Text("Genres")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .bold))
                                
                                HStack(spacing: 10) {
                                    
                                    if api.genresGame.isEmpty {
                                        LoadingIndicator()
                                            .frame(width: 50, height: 50)
                                    } else {
                                        ForEach(api.genresGame) { index in
                                            GenreRow(label: "\(index.name)", active: self.checkGA(genre: index.name))
                                                .onTapGesture {
                                                    self.performGenre(genre: index)
                                            }
                                        }
                                    }
                                }
                            }.frame(height: 100)
                        }
                        
                        if api.isLoading {
                            LoadingIndicator()
                                .frame(width: 50, height: 50)
                        } else {
                            ForEach(api.games) { game in
                                NavigationLink(destination: DetailView(id_game: game.id)) {
                                    GameRow(game: game)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                    }
                    
                    HStack(alignment: .lastTextBaseline) {
                        NavigationLink(destination: AboutView()) {
                            HStack {
                                Image(systemName: "person.crop.circle").imageScale(.large)
                                Text("About")
                            }
                        }
                        .padding(.leading)
                        .padding( 25)
                        Spacer()
                        NavigationLink(destination: SearchView()) {
                            HStack {
                                Image("search").imageScale(.large)
                                Text("Search")
                            }
                        }
                        .padding(.trailing)
                        .padding(25)
                    }
                    .foregroundColor(Color.white)
                    .background(Color(#colorLiteral(red: 0.1882352977991104, green: 0.2666666805744171, blue: 0.30588236451148987, alpha: 1)))
                    .cornerRadius(10)
                    
                }
                
            }
                
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.20392157137393951, blue: 0.23529411852359772, alpha: 1)), location: 0.0007918074261397123),
                        .init(color: Color(#colorLiteral(red: 0.12156862765550613, green: 0.18039216101169586, blue: 0.2078431397676468, alpha: 1)), location: 1)]),
                    startPoint: UnitPoint(x: -0.08938116066092056, y: 0.56955788402664),
                    endPoint: UnitPoint(x: 0.6099469288521624, y: 1.3496640680055174)))
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
        }
            
        .onAppear {
            self.api.fetchData(genre: self.genreS)
            self.api.fetchGenres()
            
        }
        .accentColor( .white)
        
    }
    
    func performGenre(genre: Genres) {
        self.api.fetchGenres()
        self.api.fetchData(genre: genre.slug)
        self.genreN = genre.name
        
    }
    
    func checkGA(genre: String) -> Bool {
        if genre == self.genreN {
            return true
        } else {
            return false
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
