import SpriteKit
import HLSpriteKit

public class TetrisBoard {
    var tetrisBlocks: [[TetrisBlock?]]
    
    weak var scene: TetrisScene?
    
    var tetriminoSpeed: TimeInterval = 1
    var score: Int = 0 {
        didSet {
            scene?.scoreLabel.text = "SCORE:\(String(score).padLeft(length: 12))"
        }
    }
    
    var bestScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "bestScore")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "bestScore")
            scene?.bestScoreLabel.text = "BEST:\(String(newValue).padLeft(length: 13))"
        }
    }
    
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
        let tetrimino: Tetrimino!
        let randomNumber = Int(arc4random_uniform(140))
        do {
            if randomNumber < 20 {
                tetrimino = try OShapedTetrimino(tetrisBoard: self)
            } else if randomNumber < 40 {
                tetrimino = try IShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(2)))
            } else if randomNumber < 60 {
                tetrimino = try ZShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(2)))
            } else if randomNumber < 80 {
                tetrimino = try SShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(2)))
            } else if randomNumber < 100 {
                tetrimino = try TShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(4)))
            } else if randomNumber < 120 {
                tetrimino = try JShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(4)))
            } else {
                tetrimino = try LShapedTetrimino(tetrisBoard: self, rotationIndex: Int(arc4random_uniform(4)))
            }
        } catch {
            scene?.gameOver()
            return
        }
        
        tetrimino.onLanded = { [weak self] in self?.removeRows(); self?.addTetrimino() }
        scene?.fallingTetrimino = tetrimino
    }
    
    func removeRows() {
        var yCoordsToRemove = [Int]()
        for y in 0..<20 {
            var shouldRemoveThisRow = true
            for x in 0..<10 {
                if tetrisBlocks[x][y] == nil {
                    shouldRemoveThisRow = false
                }
            }
            if shouldRemoveThisRow {
                yCoordsToRemove.append(y)
            }
        }
        
        for y in yCoordsToRemove {
            for x in 0..<10 {
                tetrisBlocks[x][y]!.node.removeFromParent()
                tetrisBlocks[x][y] = nil
            }
            
            for temp in 0..<20 {
                let y2 = 19 - temp
                for x2 in 0..<10 {
                    if y2 < y {
                        if let block = tetrisBlocks[x2][y2] {
                            block.moveDown()
                            block.updatePosition()
                        }
                    }
                }
            }
        }
        
        score += 20 * yCoordsToRemove.count * yCoordsToRemove.count
        
        if yCoordsToRemove.count > 0 {
            tetriminoSpeed *= 0.95
        }
    }
}

extension String {
    func padLeft(length: Int) -> String {
        if self.characters.count >= length {
            return self
        }
        var result = self
        while result.characters.count < length {
            result = " " + result
        }
        return result
    }
    
    mutating func paddedLeft(length: Int) {
        self = self.padLeft(length: length)
    }
}
