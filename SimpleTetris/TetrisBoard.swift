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
    
    func addTetrimino() {
        let tetrimino: Tetrimino
        let randomNumber = Int(arc4random_uniform(140))
        if randomNumber < 20 {
            tetrimino = OShapedTetrimino(tetrisBoard: self)
        } else if randomNumber < 40 {
            tetrimino = IShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(2)))
        } else if randomNumber < 60 {
            tetrimino = ZShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(2)))
        } else if randomNumber < 80 {
            tetrimino = SShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(2)))
        } else if randomNumber < 100 {
            tetrimino = TShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(4)))
        } else if randomNumber < 120 {
            tetrimino = JShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(4)))
        } else {
            tetrimino = LShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(4)))
        }
        
        tetrimino.onLanded = addTetrimino
        scene?.fallingTetrimino = tetrimino
    }
}
