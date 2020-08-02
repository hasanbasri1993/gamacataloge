//
//  GenresRow.swift
//  gamacataloge
//
//  Created by Hasan Basri on 03/08/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

struct GenresRow: View {
    
    @State var label: String
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.24938100576400757, green: 0.8747169375419617, blue: 0.6220977902412415, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.24313725531101227, green: 0.8352941274642944, blue: 0.5960784554481506, alpha: 1)), location: 1)]),
                    startPoint: UnitPoint(x: 0, y: 0),
                    endPoint: UnitPoint(x: 0, y: 1)))
                .frame(width: wdh(word: label), height: 15)
            Text(label)
            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center)
        }
        
    }
}

func wdh(word: String) -> CGFloat {
    if word.count < 4 {
        return CGFloat(word.count * 15)
    } else {
        return CGFloat(word.count * 8)
    }
}

struct GenresRow_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .center) {
            GenresRow(label: "hi")
            GenresRow(label: "ha")
            GenresRow(label: "hr")
            
        }
        
    }
}


