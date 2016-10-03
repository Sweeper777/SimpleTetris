import SpriteKit
import HLSpriteKit

class TetrisScene: SKScene {
    override func didMove(to view: SKView) {
        let anchorPoint = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
        self.hlSetLayoutManager(HLTableLayoutManager.init(columnCount: 1, columnWidths: [(0.0)], columnAnchorPoints: [anchorPoint], rowHeights: [(0.0)]))
    }
}
