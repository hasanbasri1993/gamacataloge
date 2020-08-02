//
//  Api.swift
//  gamacataloge
//
//  Created by Hasan Basri on 15/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import Foundation

class Api: ObservableObject {
    
    @Published var games = [Games]()
    @Published var isLoading = true
    @Published var nameGame = String()
    @Published var description_rawGame = String()
    @Published var background_imageGame = String()
    @Published var ratingsGame = [Ratings]()
    @Published var genresGame = [Genres]()
    @Published var releasedGame = String()
    @Published var ratingGame = Float()
    
    func fetchData(genre: String) {
        self.isLoading = true
        if let url = URL(string: "https://api.rawg.io/api/games?genres=\(genre)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, _, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(GamesResults.self, from: safeData)
                            DispatchQueue.main.async {
                                self.games = results.results
                                self.isLoading = false
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func fetchGenres() {
        self.genresGame = []
        if let url = URL(string: "https://api.rawg.io/api/genres") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, _, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(GenresResults.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                self.genresGame = results.results
                            }
                        } catch {
                            print(error)
                        }
                        
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    
    func searchGame(query: String) {
        self.isLoading = true
        if let url = URL(string: "https://api.rawg.io/api/games?search=\(query)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, _, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(GamesResults.self, from: safeData)
                            DispatchQueue.main.async {
                                self.games = results.results
                                self.isLoading = false
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchGameDetail(id: Int) {
        if let url = URL(string: "https://api.rawg.io/api/games/\(id)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, _, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Game.self, from: safeData)
                            DispatchQueue.main.async {
                                self.background_imageGame = results.background_image
                                self.nameGame = results.name
                                self.description_rawGame = results.description_raw
                                self.releasedGame = results.released
                                self.ratingGame = results.rating
                                self.ratingsGame = results.ratings
                                self.genresGame = results.genres
                                self.isLoading = false
                                
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
}
