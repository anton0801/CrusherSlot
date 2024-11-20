import SwiftUI

struct WelcomeBonusView: View {
    
    var anglePerReward: Double {
        360 / Double(16)
    }
    
    @State private var win = 0
    @State private var spinAngle: Double = 0
    @State private var isSpinning: Bool = false
    @State private var spinPressed: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ZStack {
                        Image("bonus_roulette")
                            .resizable()
                            .frame(width: 370, height: 370)
                            .rotationEffect(.degrees(spinAngle))
                            .animation(.easeInOut(duration: 3.0), value: spinAngle)
                        
                        VStack {
                            Spacer()
                            
                            Image("roulette_indicator")
                                .resizable()
                                .frame(width: 60, height: 70)
                        }
                    }
                    .frame(width: 370, height: 370)
                }
                VStack {
                    ZStack {
                        Image("bonus_title")
                            .resizable()
                            .frame(width: 350, height: 290)
                        if win > 0 {
                            Text("\(win)")
                                .font(.custom("LilitaOne", size: 52))
                                .foregroundColor(Color.init(red: 1, green: 184/255, blue: 0))
                                .rotationEffect(.degrees(15))
                                .offset(x: 5, y: 20)
                        }
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    if !spinPressed {
                        Button {
                            spinWheel(forReward: 11)
                        } label: {
                            ZStack {
                                Image("bonus_button_bg")
                                    .resizable()
                                    .frame(width: 250, height: 100)
                                
                                Text("SPIN")
                                    .font(.custom("LilitaOne", size: 24))
                                    .foregroundColor(.white)
                            }
                        }
                    } else {
                        NavigationLink(destination: ContentView()
                            .navigationBarBackButtonHidden()) {
                                ZStack {
                                    Image("bonus_button_bg")
                                        .resizable()
                                        .frame(width: 250, height: 100)
                                    
                                    Text("COLLECT")
                                        .font(.custom("LilitaOne", size: 24))
                                        .foregroundColor(.white)
                                }
                            }
                    }
                }
            }
            .background(
                Image("welcome_bonus_bg")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func spinWheel(forReward rewardIndex: Int) {
        isSpinning = true
        let fullSpins = 5
        let angleForReward = Double(rewardIndex) * anglePerReward

        let targetAngle = 360 * Double(fullSpins) - angleForReward

        spinAngle = targetAngle

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isSpinning = false
            withAnimation(.linear) {
                self.win = 10000
                self.spinPressed = true
            }
        }
        UserDefaults.standard.set(10000, forKey: "user_credits")
    }
    
}

#Preview {
    WelcomeBonusView()
}
