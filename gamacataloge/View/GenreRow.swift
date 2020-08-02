//
//  GenreRow.swift
//  gamacataloge
//
//  Created by Hasan Basri on 01/08/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

struct GenreRow: View {
    
    @State var label: String
    @State var active: Bool

    var body: some View {
        
        ZStack {
            if active {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 0.24938100576400757, green: 0.8747169375419617, blue: 0.6220977902412415, alpha: 1)), location: 0),
                            .init(color: Color(#colorLiteral(red: 0.24313725531101227, green: 0.8352941274642944, blue: 0.5960784554481506, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0, y: 0),
                        endPoint: UnitPoint(x: 0, y: 1)))
                    .frame(width: wd(word: label), height: 35)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(#colorLiteral(red: 0.1882352977991104, green: 0.2666666805744171, blue: 0.30588236451148987, alpha: 1)))
                    .frame(width: wd(word: label), height: 35)
            }
            Text(label)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center)
        }
    }
    
}

func wd(word: String) -> CGFloat {
    if word.count < 4 {
        return CGFloat(word.count * 18)
    } else {
        return CGFloat(word.count * 12)
    }
}

struct GenreRow_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .center) {
            GenreRow(label: "hi", active: true)
            GenreRow(label: "ha", active: false)
            GenreRow(label: "hr", active: false)
            
        }
        
    }
}
