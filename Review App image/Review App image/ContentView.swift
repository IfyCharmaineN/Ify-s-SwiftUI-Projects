//
//  ContentView.swift
//  Review App image
//
//  Created by admin on 11/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            Color(.systemMint)
          .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20.0) {
                Image("commission1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                HStack {
                    
                    Text("A commission")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    VStack {
                        
                        HStack{
                            Image(systemName:"star.fill")
                            Image(systemName:"star.fill")
                            Image(systemName:"star.fill")
                            Image(systemName:"star.fill")
                            Image(systemName:"star.leadinghalf.filled")
                        }
                       
                            Text("(Reviews 361)")
                    }
                    .foregroundColor(.orange)
                    .font(.caption)
                    
               }
                Text("Beautiful couple who purchased from America.")
                HStack{
                    Spacer()
                    Image(systemName: "binoculars.fill")
                    Image(systemName: "pencil.line")
                }
                .foregroundColor(.gray)
                .font(.caption)
            }
            .padding()
            .background(Rectangle().foregroundColor(.white))
            .cornerRadius(15)
            .shadow(radius: 15)
            .padding()
        }
        
        
    }
}

    #Preview {
        ContentView()
    }
    

