import SpriteKit
import HLSpriteKit

public class TetrisBoard {
    var tetrisBlocks: [[TetrisBlock?]]
    
    weak var scene: TetrisScene?
    
    var tetriminoSpeed: TimeInterval = 1
    
    init(scene: TetrisScene) {
        self.scene = scene
        let repeating: [TetrisBlock?] = [TetrisBlock?](repeating: nil, count: 20)
        tetrisBlocks = [[TetrisBlock?]](repeating: repeating, count: 10)
    }
    
    func syncModel() {
        func flatten(_ array: [[TetrisBlock?]]) -> [TetrisBlock?] {
            var flat = [TetrisBlock?]()
            for i in 0..<20 {
                for sub in array {
                    flat.append(sub[i])
                }
            }
            return flat
        }

        scene!.tetrisGrid.setContent(flatten(tetrisBlocks).map { $0?.node ?? NSNull() })
    }
}
