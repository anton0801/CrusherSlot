import SpriteKit
import SwiftUI

class SlotSceneGame: SKScene {
    
    private func centerPoint() -> CGPoint {
        CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    private var homeButton: SKSpriteNode!
    private var spinButton: SKSpriteNode!
    private var betPlus: SKSpriteNode!
    private var betMinus: SKSpriteNode!
    
    private var slotItemFirst: SlotItemNode!
    private var slotItemSecond: SlotItemNode!
    private var slotItemThird: SlotItemNode!
    private var slotItemFourt: SlotItemNode!
    
    private var bet: Int = 100 {
        didSet {
            betLabel.text = "\(bet)"
        }
    }
    private var betLabel: SKLabelNode!
    
    private var win: Int = 0 {
        didSet {
            winLabel.text = "\(win)"
        }
    }
    private var winLabel: SKLabelNode!
    
    private var userCredits: Int = UserDefaults.standard.integer(forKey: "user_credits") {
        didSet {
            userCreditsLabel.text = "\(userCredits)"
            UserDefaults.standard.set(userCredits, forKey: "user_credits")
        }
    }
    private var userCreditsLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 1500, height: 2700)
        
        let backgroundSlots = SKSpriteNode(imageNamed: "slot_game_background")
        backgroundSlots.position = centerPoint()
        backgroundSlots.size = size
        backgroundSlots.zPosition = -1
        addChild(backgroundSlots)
        
        createHomeButton()
        createWinNode()
        createBalance()
        createBet()
        createSlots()
        
        spinButton = SKSpriteNode(imageNamed: "spin_btn")
        spinButton.position = CGPoint(x: size.width / 2, y: 150)
        spinButton.size = CGSize(width: spinButton.size.width * 1.5, height: spinButton.size.height * 1.1)
        addChild(spinButton)
    }
    
    private func createHomeButton() {
        let homeButton = SKSpriteNode(imageNamed: "home_btn")
        homeButton.position = CGPoint(x: 120, y: size.height - 120)
        addChild(homeButton)
    }
    
    private func createWinNode() {
        let winBackgroundNode = SKSpriteNode(imageNamed: "win_back")
        winBackgroundNode.position = CGPoint(x: size.width / 2, y: size.height - 350)
        addChild(winBackgroundNode)
        
        winLabel = SKLabelNode(text: "0")
        winLabel.fontColor = .white
        winLabel.fontSize = 72
        winLabel.fontName = "LilitaOne"
        winLabel.position = CGPoint(x: size.width / 2 - 40, y: size.height - 400)
        addChild(winLabel)
    }
    
    private func createBalance() {
        let balanceBackgroundNode = SKSpriteNode(imageNamed: "balance_bg")
        balanceBackgroundNode.position = CGPoint(x: size.width - 200, y: size.height - 120)
        addChild(balanceBackgroundNode)
        
        userCreditsLabel = SKLabelNode(text: "\(userCredits)")
        userCreditsLabel.fontColor = .white
        userCreditsLabel.fontSize = 52
        userCreditsLabel.fontName = "LilitaOne"
        userCreditsLabel.position = CGPoint(x: size.width - 220, y: size.height - 135)
        addChild(userCreditsLabel)
    }
    
    private func createBet() {
        let betBackgroundNode = SKSpriteNode(imageNamed: "bet_back")
        betBackgroundNode.position = CGPoint(x: size.width / 2, y: 500)
        addChild(betBackgroundNode)
        
        betLabel = SKLabelNode(text: "\(bet)")
        betLabel.fontColor = .white
        betLabel.fontSize = 52
        betLabel.fontName = "LilitaOne"
        betLabel.position = CGPoint(x: size.width / 2 + 50, y: 480)
        addChild(betLabel)
        
        betPlus = SKSpriteNode(imageNamed: "plus_bet")
        betPlus.position = CGPoint(x: size.width / 2 + 250, y: 500)
        addChild(betPlus)
        
        betMinus = SKSpriteNode(imageNamed: "minus_bet")
        betMinus.position = CGPoint(x: size.width / 2 - 250, y: 500)
        addChild(betMinus)
    }
    
    private func createSlots() {
        let slotBackground = SKSpriteNode(imageNamed: "slot_back")
        slotBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        slotBackground.size = CGSize(width: size.width - 150, height: slotBackground.size.height + 25)
        addChild(slotBackground)
        
        slotItemFirst = SlotItemNode(symbolIds: getSymbolIds(), size: CGSize(width: 200, height: 1250))
        slotItemFirst.position = CGPoint(x: size.width / 2 - 400, y: size.height / 2)
        addChild(slotItemFirst)
        
        slotItemSecond = SlotItemNode(symbolIds: getSymbolIds(), size: CGSize(width: 200, height: 1250))
        slotItemSecond.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        addChild(slotItemSecond)
        
        slotItemThird = SlotItemNode(symbolIds: getSymbolIds(), size: CGSize(width: 200, height: 1250))
        slotItemThird.position = CGPoint(x: size.width / 2 + 180, y: size.height / 2)
        addChild(slotItemThird)
        
        slotItemFourt = SlotItemNode(symbolIds: getSymbolIds(), size: CGSize(width: 200, height: 1250))
        slotItemFourt.position = CGPoint(x: size.width / 2 + 450, y: size.height / 2)
        addChild(slotItemFourt)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touche = touches.first {
            let location = touche.location(in: self)
            let nodesAtPoint = self.nodes(at: location)
            
            for node in nodesAtPoint {
                if node == betPlus {
                    if bet < 5000 {
                        bet += 100
                    }
                } else if node == betMinus {
                    if bet > 100 {
                        bet -= 100
                    }
                } else if node == homeButton {
                    NotificationCenter.default.post(name: Notification.Name("home_go_action"), object: nil)
                } else if node == spinButton {
                    spinSlots()
                }
            }
        }
    }
    
    private func spinSlots() {
        if userCredits >= bet {
            userCredits -= bet
            slotItemFirst.startSpinningBaraban()
            slotItemSecond.startSpinningBaraban()
            slotItemThird.startSpinningBaraban()
            slotItemFourt.startSpinningBaraban()
        } else {
            NotificationCenter.default.post(name: Notification.Name("show_alert"), object: nil, userInfo: ["message": "You don't have enough credits on your balance to play at that rate! Reduce your bet to continue playing!"])
        }
    }
    
    private func getSymbolIds() -> [String] {
        return [
            "slot_1",
            "slot_2",
            "slot_3",
            "slot_4",
            "slot_5",
            "slot_7",
            "slot_8",
            "slot_9",
            "slot_10",
            "slot_11",
            "slot_12",
            "slot_wild"
        ]
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: SlotSceneGame())
            .ignoresSafeArea()
    }
}
