import SwiftUI

struct RoundedButton: ViewModifier {
    func body(content: Content) -> some View {
         content
            .font(.system(size: 19).bold())
            .foregroundColor(Color("TextColor"))
            .padding()
            .background(Color("YourColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct BackGround: ViewModifier {
    func body(content: Content) -> some View {
         content
            .frame(maxWidth: 400, maxHeight: 300)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func backgroundItems() -> some View {
        modifier(BackGround())
    }
}

extension View {
    func roundedButton() -> some View {
        modifier(RoundedButton())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var yourScore = 0
    @State private var opponentScore = 0
    @State private var gamesAmmount = 0
        
    @State private var answers = ["Rock", "Paper", "Scissors"].shuffled()
    
    @State private var opponentAnswer = Int.random(in: 0...2)
        
    var body: some View {
        ZStack {
            RadialGradient(stops: [

                .init(color: Color("BgColor1"), location: 0.2),
                .init(color: Color("BgColor2"), location: 0.6),
            ], center: .topLeading, startRadius: 400, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("RockPaperScissors")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color("TitleColor"))
                
                Spacer()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("Your score: \(yourScore)")
                            .foregroundColor(Color("YourColor"))
                            .font(.title.bold())
                        
                        Text("🤖 score: \(opponentScore)")
                            .foregroundColor(Color("OpponentColor"))
                            .font(.title.bold())
                        
                        Spacer()
                    }
            
                    HStack(spacing: 25) {
                    Text("✊🏻")
                            .font(.system(size: 65))
                    Text("✌🏻")
                            .font(.system(size: 65))
                    Text("🤚🏻")
                            .font(.system(size: 65))
                    }
                    .backgroundItems()
                    
                    Spacer()
                    Spacer()
                    
                    VStack(spacing: 20) {
                        VStack {
                            Text("Choose your item: ")
                                .font(.title.weight(.bold))
                                .foregroundColor(Color("YourColor"))
                        }
                        
                        HStack {
                            ForEach(0..<3) { item in
                                Button {
                                    yourChoise(item)
                                } label: {
                                    Text(answers[item])
                                }
                                .roundedButton()
                            }
                        }
                        Spacer()
                        Spacer()
                        
                    }
                    Spacer()
                }
            }
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            if gamesAmmount == 10 {
                Button("Restart", action: resetScore)
            } else {
            Button("Continue", action: askQuestion)
            }
                
        } message: {
            if gamesAmmount == 10 && yourScore > opponentScore {
                Text("Score \(yourScore) : \(opponentScore). Let's play again?")
            } else if gamesAmmount == 10 && yourScore < opponentScore {
                Text("Score \(yourScore) : \(opponentScore). Will you try again?")
            } else if gamesAmmount == 10 && yourScore == opponentScore {
                Text("Will you take revenge?")
            } else {
                Text("Opponent chose: \(answers[opponentAnswer])")
            }
        }
    }
    
    func yourChoise(_ item: Int) {
        if answers[item] == answers[opponentAnswer] {
            scoreTitle = "Draw!"
        } else {
            if (answers[item] == "Rock" && answers[opponentAnswer] == "Scissors") || (answers[item] == "Paper" && answers[opponentAnswer] == "Rock") || (answers[item] == "Scissors" && answers[opponentAnswer] == "Paper") {
                scoreTitle = "You get a point!"
                yourScore += 1
            } else {
                scoreTitle = "Your opponent get's a point!"
                opponentScore += 1
            }
        }

        
        gamesAmmount += 1
        showingScore = true
        
        if gamesAmmount == 10 {
            if yourScore > opponentScore {
                scoreTitle = "You win!"
            } else if yourScore < opponentScore {
                scoreTitle = "You lost."
            } else {
                scoreTitle = "Draw!"
            }
        }
    }
    
    func opponentChoise() {
        opponentAnswer = Int.random(in: 0...2)
    }
    
    func askQuestion() {
        answers.shuffle()
        opponentAnswer = Int.random(in: 0...2)
    }
    
    func resetScore() {
        if gamesAmmount == 10 {
            gamesAmmount = 0
            yourScore = 0
            opponentScore = 0
            answers.shuffle()
            opponentAnswer = Int.random(in: 0...2)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
