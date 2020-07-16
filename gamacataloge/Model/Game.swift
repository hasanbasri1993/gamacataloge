//
//  Game.swift
//  gamacataloge
//
//  Created by Hasan Basri on 15/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import Foundation

struct  GamesResults: Decodable {
    let results: [Games]
}

struct Games: Decodable, Identifiable{
    let id: Int
    let name: String
    let background_image: String!
    let released: String!
    let rating: Float!
    let genres: [Genres]!
}

struct Game: Decodable, Identifiable{
    let id: Int
    let name: String
    let background_image: String
    let released: String
    let rating: Float
    let description_raw: String
    let genres: [Genres]
    let ratings: [Ratings]
}

struct Ratings: Decodable, Identifiable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

struct Genres: Decodable, Identifiable{
    let id: Int
    let name: String
}
