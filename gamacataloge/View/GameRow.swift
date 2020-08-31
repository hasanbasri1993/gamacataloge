//
//  GameRow.swift
//  gamacataloge
//
//  Created by Hasan Basri on 16/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI
import RemoteImage

func dddd (tgl: String) -> String {
    var tgl1 = ""
    if tgl == "" {
        tgl1 = "2000-01-01"
    } else {
        tgl1 = tgl
    }
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    let showDate = inputFormatter.date(from: tgl1)
    inputFormatter.dateFormat = "d MMMM yyyy"
    let resultString = inputFormatter.string(from: showDate!)
    return resultString
}

struct GameRow: View {
    var game: Games
    let base_url_cloudnary = "https://res.cloudinary.com/demo/image/fetch/w_250,h_100,c_fill/"
    let base_url_backup_img = "https://upload.wikimedia.org/wikipedia/commons/7/75/No_image_available.png"

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            GeometryReader { geo in

                RemoteImage(
                    type: .url(URL(string: "\(self.base_url_cloudnary)\(self.game.background_image ?? self.base_url_backup_img)")!), errorView: { error in
                        Text(error.localizedDescription)
                    }, imageView: { image in
                        image
                            .resizable()
                    }, loadingView: {
                        LoadingIndicator()
                            .frame(width: 50, height: 50)
                    })
                    .frame(width: geo.size.width, height: 150)

                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
            HStack {
                VStack(alignment: .leading, spacing: 6) {

                    Text(self.game.name)
                        .font(.custom("Ubuntu-Bold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .padding(.top)

                    Text("Release Date: " + dddd(tgl: self.game.released ?? "2000-01-01"))
                        .font(.custom("Ubuntu-Bold", size: 12))
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
                Text(String(self.game.rating ?? 0.0))
                    .foregroundColor(Color(#colorLiteral(red: 0.59, green: 0.65, blue: 0.69, alpha: 1)))
                    .font(.custom("Ubuntu-Bold", size: 18))

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

        GameRow(game: Games(
            id: 1030,
            name: "Naruto",
            background_image: "https://upload.wikimedia.org/wikipedia/commons/7/75/No_image_available.png",
            released: "2020-05-05",
            rating: 4.5,
            genres: [Genres(
                    id: 6,
                    name: "RPG",
                    slug: "sds")]
        )
        )

    }
}
