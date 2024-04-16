//
//
//  Card Game App (1st draft)
//
//  Created by Ify N on 12/01/2024.
//

import SwiftUI

struct ContentView: View {
    
  @State  var playerCard = "card7" // @State is like a modifier
  @State var cpuCard = "card13"
    
  @State  var playerScore = 0
  @State var cpuScore = 0
    
    var body: some View {
        
        ZStack {
            Image("background-plain")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                Image("logo")
                Spacer()
                
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                
                Spacer()
               
             
                .foregroundColor(.white)
                
                Button {
                    deal()
                } label: {
                    Image("button")
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    VStack{
                            Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                            
                            Text(String(playerScore))
                            .font(.largeTitle)
                        }
                    Spacer()
                    VStack {
                        
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                      
                    }
                    
                    Spacer()
                        } .foregroundColor(.white)
                Spacer()
                Spacer()
            }
         
        }
        
    }
    func deal() {
        var playerCardValue = Int.random(in: 2...14)
        playerCard = "card" + String(playerCardValue)
        
        var cpuCardValue = Int.random(in: 2...14)
      // Randomize the players card
       cpuCard = "card" + String(cpuCardValue)
      // Randomize the cpus card
        
      // Update the score
        
        if  playerCardValue > cpuCardValue {
            // Add 1 to player scpore
            playerScore += 1
            
        }
        else if cpuCardValue > playerCardValue {
            cpuScore += 1
        }
 
            
        }
    }

#Preview {
    ContentView()
}


