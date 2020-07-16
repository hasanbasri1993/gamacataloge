//
//  Api.swift
//  gamacataloge
//
//  Created by Hasan Basri on 15/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import Foundation

class Api: ObservableObject{
    
    @Published var games = [Games]()
    
    @Published var name_game = String()
    @Published var description_raw_game = String()
    @Published var background_image_game = String()
    @Published var ratings_game = [Ratings]()
    @Published var genres_game = [Genres]()
    @Published var released_game = String()
    @Published var rating_game = Float()
    
    func fetchData(){
        if let url = URL(string: "https://api.rawg.io/api/games"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(GamesResults.self, from: safeData)
                            DispatchQueue.main.async {
                                self.games = results.results
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
    
    func searchGame(query: String){
        if let url = URL(string: "https://api.rawg.io/api/games?search=\(query)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(GamesResults.self, from: safeData)
                            DispatchQueue.main.async {
                                print(results)
                                self.games = results.results
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
    
    
    func fetchGameDetail(id: Int){
        if let url = URL(string: "https://api.rawg.io/api/games/\(id)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Game.self, from: safeData)
                            DispatchQueue.main.async {
                                self.name_game = results.name
                                self.description_raw_game = results.description_raw
                                self.released_game = results.released
                                self.rating_game = results.rating
                                self.ratings_game = results.ratings
                                self.genres_game = results.genres
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
