import SpriteKit
import HLSpriteKit

public class TetrisBoard {
    var tetrisBlocks: [[TetrisBlock?]]
    
    weak var scene: TetrisScene?
    
    init(scene: TetrisScene) {
        self.scene = scene
        let repeating: [TetrisBlock?] = [TetrisBlock?](repeating: nil, count: 20)
        tetrisBlocks = [[TetrisBlock?]](repeating: repeating, count: 10)
    }
    
    func syncModel() {
        scene!.tetrisGrid.setContent(tetrisBlocks.flatMap { $0 }.map { $0?.node ?? SKSpriteNode(color: UIColor.black, size: CGSize.zero) })
    }
}
