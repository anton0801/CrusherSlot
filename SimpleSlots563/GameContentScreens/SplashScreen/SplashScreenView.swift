import SwiftUI

class LoadingViewModel: ObservableObject {
    
    @Published var loadingProgress: Int = 0 {
        didSet {
            loadedItems = loadingProgress / 6
        }
    }
    @Published var loadedItems: Int = 0
    
    var timer: Timer = Timer()
    
    init() {
        timer = .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timeEraser), userInfo: nil, repeats: true)
    }
    
    @objc private func timeEraser() {
        loadingProgress += 2
        if loadingProgress == 100 {
            timer.invalidate()
        }
    }
    
}

struct SplashScreenView: View {
    
    @StateObject var loadingViewModel: LoadingViewModel = LoadingViewModel()
    @State var gameLoaded = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Loading...")
                    .font(.custom("LilitaOne", size: 20))
                    .foregroundColor(.white)
                ZStack {
                    Image("loading_background")
                        .resizable()
                        .frame(width: 300, height: 50)
                    
                    HStack {
                        ForEach(0..<17, id: \.self) { index in
                            if index >= loadingViewModel.loadedItems {
                                Image("loading_item_inactive")
                                    .resizable()
                                    .frame(width: 8, height: 40)
                            } else {
                                Image("loading_item_active")
                                    .resizable()
                                    .frame(width: 8, height: 40)
                            }
                        }
                    }
                }
                
                if loadingViewModel.loadingProgress == 100 {
                    Text("").onAppear {
                        gameLoaded = true
                    }
                }
                
                NavigationLink(destination: SpalashRedirecterView()
                    .navigationBarBackButtonHidden(), isActive: $gameLoaded) {
                    
                }
            }
            .background(
                Image("splash_background")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SplashScreenView()
}
