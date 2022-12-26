//
//  OnboardView.swift
//  ChatAI
//
//  Created by Manoj kumar on 23/12/22.
//

import SwiftUI

struct OnboardView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Ask Code")
                .foregroundColor(.blue)
                .font(.system(.largeTitle))
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.top, 50)
            
            Text("Lets find the any solutions just for you.")
                .font(.system(.callout))
                .fontWeight(.bold)
                .lineLimit(2)
                .frame(width: 250)
                .multilineTextAlignment(.center)
            
            Image("chatBot")
                .resizable()
                .scaledToFit()
                
            Spacer()
            
            Button {
                //Action
            } label: {
                Text("Get Started")
                    .font(.system(.subheadline))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.all)
            }
            .padding(.horizontal)
            .background(
                Capsule()
                    .foregroundColor(.blue)
            )
            .padding(.all)

            
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
    }
}
