import SwiftUI
import SpriteKit

struct SlotsGameView: View {
    
    @Environment(\.presentationMode) var presMode
    @State var slotSceneGame: SlotSceneGame!
    @State var showAlert = false
    @State var alertMessage = ""

    var body: some View {
        VStack {
            if let scene = slotSceneGame {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("home_go_action"))) { _ in
            presMode.wrappedValue.dismiss()
        }
        .onAppear {
            if slotSceneGame == nil {
                slotSceneGame = SlotSceneGame()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("show_alert"))) { notification in
            guard let info = notification.userInfo as? [String: Any],
                let message = info["message"] as? String else { return }
            self.alertMessage = message
            self.showAlert.toggle()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert!"), message: Text(alertMessage))
        }
    }
}

#Preview {
    SlotsGameView()
}
