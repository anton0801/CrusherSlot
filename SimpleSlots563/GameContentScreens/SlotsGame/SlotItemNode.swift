import Foundation
import SpriteKit

class SlotItemNode: SKSpriteNode {
    
    var reversedSpinState = false
    
    init(symbolIds: [String], size: CGSize) {
        self.symbolIds = symbolIds
        self.endspincallback = nil
        super.init(texture: nil, color: .clear, size: size)
        setUpSymbolsAndInitializeNodes()
    }
    
    init(symbolIds: [String], size: CGSize, endspincallback: (() -> Void)?) {
        self.symbolIds = symbolIds
        self.endspincallback = endspincallback
        super.init(texture: nil, color: .clear, size: size)
        setUpSymbolsAndInitializeNodes()
    }
    
    
    private func reversedScroll() {
        reversedSpinState = false
        let actionMove = SKAction.moveBy(x: 0, y: -(217.5 * CGFloat(Int.random(in: 4...6))), duration: 0.3)
        slotItemContent.run(actionMove) {
            self.endspincallback?()
        }
    }
    var endspincallback: (() -> Void)?
    
    func startSpinningBaraban() {
        if reversedSpinState {
            reversedScroll()
        } else {
            unreversedScroll()
        }
    }
    
    
    private func unreversedScroll() {
        let actionMove = SKAction.moveBy(x: 0, y: 217.5 * CGFloat(Int.random(in: 4...6)), duration: 0.3)
        slotItemContent.run(actionMove) {
            self.endspincallback?()
        }
        reversedSpinState = true
    }
    private var slotItemContent: SKNode!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cropepSlotItemNode: SKCropNode!
    
    private func setUpSymbolsAndInitializeNodes() {
        self.cropepSlotItemNode = SKCropNode()
        self.slotItemContent = SKNode()
        
        cropepSlotItemNode.position = CGPoint(x: 0, y: 0)
        let maskedNodeWithOutOtherUnusedSymbols = SKSpriteNode(color: .black, size: size)
        maskedNodeWithOutOtherUnusedSymbols.position = CGPoint(x: 0, y: 0)
        cropepSlotItemNode.maskNode = maskedNodeWithOutOtherUnusedSymbols
        addChild(cropepSlotItemNode)
        cropepSlotItemNode.addChild(slotItemContent)

        let symbolsRangedAndShuffled = symbolIds.shuffled()
        
        for i in 0..<symbolIds.count * 8 {
            let nodeSymbols = SKSpriteNode(imageNamed: symbolsRangedAndShuffled[i % symbolIds.count])
            nodeSymbols.size = CGSize(width: 160, height: 160)
            nodeSymbols.name = symbolsRangedAndShuffled[i % symbolIds.count]
            nodeSymbols.position = CGPoint(x: 0, y: size.height - CGFloat(i) * 217.5)
            nodeSymbols.zPosition = 1
            slotItemContent.addChild(nodeSymbols)
        }
        
        slotItemContent.run(SKAction.moveBy(x: 0, y: 215.5 * CGFloat(symbolIds.count * 3), duration: 0.0))
    }
    
    var symbolIds: [String]
    
    
}
