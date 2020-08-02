//
//  GameRow.swift
//  gamacataloge
//
//  Created by Hasan Basri on 16/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

func dddd (tgl: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    let showDate = inputFormatter.date(from: tgl)
    inputFormatter.dateFormat = "d MMMM yyyy"
    let resultString = inputFormatter.string(from: showDate!)
    return resultString
}

struct GameRow: View {
    @Environment(\.imageCache) var cache: ImageCache
    var game: Games
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            GeometryReader { geo in
                RemoteImage(
                    url: URL(string: "https://res.cloudinary.com/demo/image/fetch/w_250,h_100,c_fill/\(self.game.background_image ?? "https://media.rawg.io/media/games/b11/b115b2bc6a5957a917bc7601f4abdda2.jpg")")!,
                    cache: self.cache,
                    placeholder: HStack {
                        LoadingIndicator()
                            .frame(width: 50, height: 50)
                        
                    }.padding(),
                    configuration: {$0.resizable()}
                )
                    .frame(width: geo.size.width, height: 150)
                    
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(self.game.name)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .padding(.top )
                    
                    Text("Release Date: "  + dddd(tgl: self.game.released))
                    .font(.caption)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(self.game.genres) { genre in
                                GenresRow(label: genre.name) .font(.caption)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                
                            }
                        }
                        
                    }
                }
                
                Spacer()
                Text(String(self.game.rating))
                    .foregroundColor(Color(#colorLiteral(red: 0.59, green: 0.65, blue: 0.69, alpha: 1)))
                
                Image(systemName: "star.circle")
                    .foregroundColor(Color(#colorLiteral(red: 0.59, green: 0.65, blue: 0.69, alpha: 1)))
                
            }.padding(.horizontal)
            
        }
        .padding(.bottom)
        .background(Color(#colorLiteral(red: 0.1882352977991104, green: 0.2666666805744171, blue: 0.30588236451148987, alpha: 1)))
        .cornerRadius(7)
        .shadow(radius: 5)
        .frame(height: 250)
        
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
