////
////
////  Card Game App (1st draft)
////
////  Created by Ify N on 12/01/2024.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    
//  @State  var playerCard = "card7" // @State is like a modifier
//  @State var cpuCard = "card13"
//    
//  @State  var playerScore = 0
//  @State var cpuScore = 0
//    
//    var body: some View {
//        
//        ZStack {
//            Image("background-plain")
//                .ignoresSafeArea()
//            
//            VStack {
//                Spacer()
//                Spacer()
//                Image("logo")
//                Spacer()
//                
//                HStack {
//                    Spacer()
//                    Image(playerCard)
//                    Spacer()
//                    Image(cpuCard)
//                    Spacer()
//                }
//                
//                Spacer()
//               
//             
//                .foregroundColor(.white)
//                
//                Button {
//                    deal()
//                } label: {
//                    Image("button")
//                }
//                
//                Spacer()
//                
//                HStack{
//                    Spacer()
//                    VStack{
//                            Text("Player")
//                            .font(.headline)
//                            .padding(.bottom, 10.0)
//                            
//                            Text(String(playerScore))
//                            .font(.largeTitle)
//                        }
//                    Spacer()
//                    VStack {
//                        
//                        Text("CPU")
//                            .font(.headline)
//                            .padding(.bottom, 10.0)
//                        Text(String(cpuScore))
//                            .font(.largeTitle)
//                      
//                    }
//                    
//                    Spacer()
//                        } .foregroundColor(.white)
//                Spacer()
//                Spacer()
//            }
//         
//        }
//        
//    }
//    func deal() {
//        let playerCardValue = Int.random(in: 2...14)
//        playerCard = "card" + String(playerCardValue)
//        
//        let cpuCardValue = Int.random(in: 2...14)
//      // Randomize the players card
//       cpuCard = "card" + String(cpuCardValue)
//      // Randomize the cpus card
//        
//      // Update the score
//        
//        if  playerCardValue > cpuCardValue {
//            // Add 1 to player scpore
//            playerScore += 1
//            
//        }
//        else if cpuCardValue > playerCardValue {
//            cpuScore += 1
//        }
// 
//            
//        }
//    }
//
//#Preview {
//    ContentView()
//}
//

import Foundation

// Creating a function to draw cards from API
// completion - for when player is done drawing cards
//       deck cards - amount of decks (players)
//       numberofCards - number of cards for each player
//       escaping -  escaping the function when the card is Void (when there are no more cards to be drawn)

func drawCards(deckCount: Int, numberOfCards: Int, completion: @escaping ([Card]) -> Void) {
    
    // Variable for API link
    let apiURL = "https://deckofcardsapi.com/api/deck/new/shuffle/"
    
    // Variable for urlString - appends parameters apiURL and deckCount for creating a new deck
    //    and deckCount will draw cards from an existing deck
    // ?deck_count=\(deckCount) - parameter so that the deck count = deck count in URL
    
    //  note to me - "/()" is similar to python's f-string {}
  
    let urlString = "\(apiURL)?deck_count=\(deckCount)"
    
    // URL(string: urlString) - Creating a URL object using the string stored in urlString
    // if the attempt to create the URL object is successful,
    if let url = URL(string: urlString) {
        
        // Perform the request
        
        // URLSession - Swift class that provides an API to perform a network task
        // .shared - creates a single instance of the URLSession, it can be shared/ is accessible from anywhere in application
        // .dataTask(with: url) - function to in URLSession class for fetching data from url provided
        
        // data - parameter for data receieved from network
        // _, - a placeholder for particular values that are intentionally being ignored
        // error - for any error that occurs during the request
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            // Handling the response
            // if let data = data - checks if network request was successful
            
            if let data = data {
                do {
                   
                    //Decode the JSON response
                    // JSONDecoder - a class provided by Swift's Foundation framework to decode the JavaScript Object Notation
                    
                    let decoder = JSONDecoder()
                    // try decoder.decode - attempts to decode the JSON response data
                    // DrawResponse.self - decode should conform to structure desfined by DrawResponse type
                    
                    let result = try decoder.decode(DrawResponse.self, from: data)
                
                    // Process the drawn cards
                    // results.cards - array of cards from the decoded JSON response
                    // map {} - function to transform each element of an array
                    // Card(rank:...suit)} - creates a new Card object for each card in array using
                    //   'value' and 'suit' properties of each card in the JSON
                    //       drawnCards array is the result of this and contains Card objects, representing cards drawn from deck
                    
                    let drawnCards = result.cards.map { Card(rank: $0.value, suit: $0.suit)}
                    
                    // Call the completion handler with the drawn cards, now it can be handled where drawCards function is called.
                    completion(drawnCards)
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error making request: \(error)")
            }
            
        // .resume() - function actually initiates the network request
        }.resume()
    }
    
}
    
import SwiftUI

// 1. Creating functions of the basic rules of Switch (Black Jack)

// Defining the rank and suits for card game
// Using enum offers benefits for code organisation, type safety, autocompletion and pattern macthing
enum Suit: String {
    case hearts, diamonds, clubs, spades
}

enum Rank: String {
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace, joker
}
// Encapsulation - Define Card struct at a global scope
// Abstraction - Abstracts away the details of the card. With this structure we'll be able to create instances e.g Card(rank: .queen, suit: .hearts)
// Great for code Resusability

struct Card {
    let rank: Rank
    let suit: Suit
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        // Your card view implementation with an image
        Image("\(card.rank.rawValue)_of_\(card.suit.rawValue)") // Follows the naming convention                                                         of "two_of_hearts"
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 150) // Adjust size as needed
    }
}

// In Swift UI, ContentView defines the user interface
struct ContentView: View {
    // Using representations of the 'Card' struct instances we're creating properties for three cards - considering there are two players for now (playerCard, cpuCard and the previously placed card)
    
    // For now we've placed example cards:
    let playerCard = Card(rank: .two, suit: .hearts)
    let cpuCard = Card(rank: .three, suit: .spades)
    var previousCard = Card(rank: .ace, suit: .diamonds)
    
    // Body is a property required by the view to return thr hierarchy that Swift UI will render
    
    var body: some View {
        VStack { // Vertically stacking the cards
            CardView(card: playerCard)
            CardView(card: cpuCard)
            
            Button("Play Next Card") {
                // Call your playCard function and update UI or game state accordingly
            }
        }
    }

    // The rest of your game logic goes here...
}
