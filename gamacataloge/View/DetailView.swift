//
//  DetailView.swift
//  gamacataloge
//
//  Created by Hasan Basri on 16/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI
import RemoteImage

struct DetailView: View {

    @ObservedObject var api = Api()
    @Environment(\.imageCache) var cache: ImageCache
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isFavorite = false

    let id_game: Int
    let base_url_cloudnary = "https://res.cloudinary.com/demo/image/fetch/w_250,h_100,c_fill/"
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
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        RemoteImage(type: .url(URL(string: base_url_cloudnary + api.background_imageGame)!), errorView: { error in
                            Text(error.localizedDescription)
                        }, imageView: { image in
                            image
                                .resizable()
                        }, loadingView: {
                            LoadingIndicator()
                                .frame(width: 50, height: 50)
                        })
                            .frame(height: 200)
                            .clipped()

                        Text(String(api.nameGame))
                            .font(.custom("Ubuntu-Bold", size: 20))
                            .padding(5)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3)
                            .offset(x: -5, y: -5)

                        Text("Release Date: " + dddd(tgl: api.releasedGame))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3)
                            .font(.custom("Ubuntu-Bold", size: 15))
                            .offset(x: -5, y: -34)
                            .padding(5)

                        HStack {
                            Text(String(api.ratingGame))
                                .foregroundColor(.white)

                            Image(systemName: "star.circle")
                                .foregroundColor(.white)
                        }.padding(4)
                            .shadow(color: .black, radius: 3)
                            .font(.custom("Ubuntu-Bold", size: 15))
                            .foregroundColor(.white)
                            .offset(x: -5, y: -52)
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
                                .padding(5)

                            Text(api.description_rawGame)
                                .lineSpacing(5)
                                .foregroundColor(.white)
                                .font(.custom("Ubuntu-Regular", size: 15))

                        }
                    }.padding()
                }
            }
        }
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .shadow(color: .black, radius: 3)

                }), trailing: Button(action: {
                    self.performFavorite(id: self.api.idGame)
                }, label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 3)
                })
            )

            .onAppear {
                self.api.fetchGameDetail(id: self.id_game)
        }
    }

    func performFavorite(id: Int) {
        isFavorite = isFavorite ? false : true
    }

}

class DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id_game: 1035)
    }
    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: DetailView(id_game: 1035))
        }
    #endif
}
