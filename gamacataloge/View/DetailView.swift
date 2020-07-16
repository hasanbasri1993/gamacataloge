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
    
    let discipline: Int
    
    var body: some View {
        VStack{
            Text(api.name_game)
            Text(api.description_raw_game)
        }
            .onAppear{
                self.api.fetchGameDetail(id: self.discipline)
        }
    }
    
}
