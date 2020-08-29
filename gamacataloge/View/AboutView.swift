//
//  AboutView.swift
//  gamacataloge
//
//  Created by Hasan Basri on 16/07/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.20392157137393951, blue: 0.23529411852359772, alpha: 1)), location: 0.0007918074261397123),
                    .init(color: Color(#colorLiteral(red: 0.12156862765550613, green: 0.18039216101169586, blue: 0.2078431397676468, alpha: 1)), location: 1)]),
                startPoint: UnitPoint(x: -0.08938116066092056, y: 0.56955788402664),
                endPoint: UnitPoint(x: 0.6099469288521624, y: 1.3496640680055174))
            
            VStack(alignment: .leading) {
                HStack {
                    EmptyView()
                    Spacer()
                }
                Text("About Me")
                    .font(.custom("Ubuntu-Bold", size: 30))
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .padding(.top, 80)
                    .padding(.leading, 15)
                
                VStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("")
                        Spacer()
                    }
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(#colorLiteral(red: 0.1882352977991104, green: 0.2666666805744171, blue: 0.30588236451148987, alpha: 1)))
                            .frame(width: 317, height: 350)
                            .shadow(color: Color(#colorLiteral(red: 0.09803921729326248, green: 0.1568627506494522, blue: 0.18431372940540314, alpha: 1)), radius: 14, x: 0, y: 1)
                        
                        VStack(alignment: .center, spacing: 10) {
                            
                            Image("hasan")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250.0, height: 250.0, alignment: .top)
                                .clipShape(Circle())
                            
                            Text("Hasan Basri")
                                .font(.custom("Ubuntu-Bold", size: 28))
                                .foregroundColor(Color.white)
                            Text("Web Developer")
                                .font(.custom("Ubuntu-Bold", size: 12))
                                .font(.caption)
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .padding()
                .padding(.top, 50)
                Spacer()
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
