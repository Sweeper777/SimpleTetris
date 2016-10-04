import SpriteKit
import HLSpriteKit

class TetrisScene: SKScene {
    var background: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        background = self.childNode(withName: "bg") as! SKSpriteNode
        let anchorPoint = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
        background.hlSetLayoutManager(HLTableLayoutManager.init(columnCount: 1, columnWidths: [(0.0)], columnAnchorPoints: [anchorPoint], rowHeights: [(0.0)]))
    }
}
