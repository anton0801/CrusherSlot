import SwiftUI

struct SpalashRedirecterView: View {
    var body: some View {
        VStack {
            if !UserDefaults.standard.bool(forKey: "welcome_bonus_claimed") {
                WelcomeBonusView()
            } else {
                ContentView()
            }
        }
    }
}

#Preview {
    SpalashRedirecterView()
}
