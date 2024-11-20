import SwiftUI

struct ContentView: View {
    
    @State var soundState: Bool = UserDefaults.standard.bool(forKey: "sound")
    @State var bonusAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("title")
                    .resizable()
                    .frame(width: 300, height: 150)
                
                Spacer()
                
                NavigationLink(destination: SlotsGameView()
                    .navigationBarBackButtonHidden()) {
                    ZStack {
                        Image("bonus_button_bg")
                            .resizable()
                            .frame(width: 250, height: 100)
                        
                        Text("PLAY")
                            .font(.custom("LilitaOne", size: 32))
                            .foregroundColor(.white)
                    }
                }
                
//                NavigationLink(destination: EmptyView()) {
//                    ZStack {
//                        Image("bonus_button_bg")
//                            .resizable()
//                            .frame(width: 250, height: 100)
//                        
//                        Text("BONUS GAME")
//                            .font(.custom("LilitaOne", size: 28))
//                            .foregroundColor(.white)
//                    }
//                }
                Button {
                    bonusAlert.toggle()
                } label: {
                    ZStack {
                        Image("bonus_button_bg")
                            .resizable()
                            .frame(width: 250, height: 100)
                        
                        Text("BONUS GAME")
                            .font(.custom("LilitaOne", size: 28))
                            .foregroundColor(.white)
                    }
                }
                
                
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        soundState.toggle()
                    }
                } label: {
                    ZStack {
                        Image("bonus_button_bg")
                            .resizable()
                            .frame(width: 250, height: 100)
                        
                        HStack {
                            Text("SOUND")
                               .font(.custom("LilitaOne", size: 24))
                               .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(soundState ? "ON" : "OFF")
                                .font(.custom("LilitaOne", size: 24))
                                .foregroundColor(Color.init(red: 1, green: 184/255, blue: 0))
                        }
                        .padding(.horizontal, 42)
                    }
                }
                .frame(width: 250, height: 100)
            }
            .alert(isPresented: $bonusAlert, content: {
                Alert(title: Text("Alert!"), message: Text("Bonus game will be available soon, preparing a cool and very interesting bonus game that will be available 1 time a day! Wait! In the meantime, play slots."))
            })
            .background(
                Image("lobby_background")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    ContentView()
}
