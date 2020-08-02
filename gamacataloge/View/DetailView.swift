//
//  DetailView.swift
//  gamacataloge
//
//  Created by Hasan Basri on 16/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    @ObservedObject var api = Api()
    @Environment(\.imageCache) var cache: ImageCache

    let id_game: Int

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
                .frame(width: 50, height: 50)            } else {
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        RemoteImage(
                            url: URL(string: "https://res.cloudinary.com/demo/image/fetch/w_250,h_100,c_fill/\(api.background_imageGame)")!,
                            cache: self.cache,
                            placeholder: LoadingIndicator()
                            .frame(width: 50, height: 50),
                            configuration: {$0.resizable()}
                        )
                            .frame(height: 200)
                            .clipped()

                        Text(String(api.nameGame))
                            .padding(5)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .offset(x: -5, y: -5)

                        Text("Release Date: " + dddd(tgl: api.releasedGame))
                            .foregroundColor(.white)
                            .background(Color.black)
                            .font(.caption)
                            .offset(x: -5, y: -40)
                            .padding(5)

                        HStack {
                            Text(String(api.ratingGame))
                                .foregroundColor(.white)

                            Image(systemName: "star.circle")
                                .foregroundColor(.white)
                        } .padding(4)
                            .background(Color.black)
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(x: -5, y: -60)
                            .padding(5)
                    }

                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(alignment: .leading) {

                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    ForEach(api.genresGame) { index in
                                        GenreRow(label: "\(index.name)", active: true)
                                    }
                                }
                            }

                            Text(api.description_rawGame)
                                .foregroundColor(.white)

                        }
                    }.padding()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear {
            self.api.fetchGameDetail(id: self.id_game)}

    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id_game: 1030)
    }
}
