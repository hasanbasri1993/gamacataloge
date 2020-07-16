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
    @State private var isFinish: Bool = false
    @State private var searchText : String = ""
    
    var body: some View {
        
        NavigationView{
            VStack{
                SearchBar(text: $searchText, placeholder: "Search games ...")

                List(api.games){ post in
                    GameRow(game: post)
                    NavigationLink(destination: DetailView(discipline: post.id)) {
                        EmptyView()
                    }
                }
            }
            .navigationBarTitle("Games List")
            .navigationBarItems(trailing:
                NavigationLink(destination: AboutView()) {
                    Image(systemName: "person.crop.circle").imageScale(.large)
                }.buttonStyle(PlainButtonStyle())
            )
        }
            
        .onAppear{
            self.api.fetchData()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

