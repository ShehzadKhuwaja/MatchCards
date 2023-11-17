//
//  ViewController.swift
//  MatchCards
//
//  Created by MindMingle on 13/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOfRows = 3
    var cardsPerRow = 4
    
    var numberOfPairOfCards: Int {
        return (numberOfRows * cardsPerRow) / 2
    }
    
    private lazy var game = MatchCard(numberOfPairsOfCards: self.numberOfPairOfCards)
    
    private var cardEmoji = [Card: String]()
    private var emojiChoices = "🐶🐱🐭🐹🦁🐔🙊🦇🦊"
    
    let flipCountLabel = UILabel()
    
    let scoreLabel = UILabel()
    
    private var cardButtons = [UIButton]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createCardUI(numberOfRows: self.numberOfRows, cardsPerRow: self.cardsPerRow)
        updateViewFromModel()
    }
    
    func createCardUI(numberOfRows: Int, cardsPerRow: Int) {
        // Create a stack view for the top section
        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.alignment = .fill
        topStackView.distribution = .fillProportionally
        topStackView.spacing = 10
        
        // Create the score label and flip count label
        //let scoreLabel = UILabel()
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .left
        //let flipCountLabel = UILabel()
        flipCountLabel.text = "Flips: 0"
        flipCountLabel.textAlignment = .right
        
        // Add the labels to the top stack view
        topStackView.addArrangedSubview(scoreLabel)
        topStackView.addArrangedSubview(flipCountLabel)
        
        // Create a stack view for the bottom section
        let bottomStackView = UIStackView()
        bottomStackView.axis = .vertical
        bottomStackView.alignment = .fill
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 10
        
        // Create the grid of card buttons as in the previous example
        for _ in 0..<numberOfRows {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 10
            
            for _ in 0..<cardsPerRow {
                let cardButton = UIButton()
                cardButton.setTitle("", for: .normal)
                //cardButton.backgroundColor = .red
                
                // add the card button to card buttons array
                cardButtons.append(cardButton)
                
                // add the target-action pair
                cardButton.addTarget(self, action: #selector(cardButtonTapped(_:)), for: .touchUpInside)
                
                rowStackView.addArrangedSubview(cardButton)
            }
            
            bottomStackView.addArrangedSubview(rowStackView)
        }
        
        // Create a parent stack view to arrange the top and bottom sections vertically
        let parentStackView = UIStackView()
        parentStackView.axis = .vertical
        parentStackView.alignment = .fill
        parentStackView.distribution = .fill
        parentStackView.spacing = 20
        
        // Add the top and bottom stack views to the parent stack view
        parentStackView.addArrangedSubview(topStackView)
        parentStackView.addArrangedSubview(bottomStackView)
        
        // Add the parent stack view to the main view
        view.addSubview(parentStackView)
        
        let restartButton = UIButton()
        restartButton.setTitle("Restart", for: .normal)
        restartButton.backgroundColor = .blue
        restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(restartButton)
        
        // Add constraints to define the position and size of the parent stack view
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            parentStackView.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -20)
        ])
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: parentStackView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: parentStackView.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: parentStackView.bottomAnchor)
        ])
        
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restartButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            restartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            restartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            restartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
    }
    
    @objc func cardButtonTapped(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Card chosen was not in cardbuttons array")
        }
    }
    
    private func updateViewFromModel() {
        // Update the flip count
        flipCountLabel.text = "Flips: \(game.flipCount)"
        
        // Update the Score
        scoreLabel.text = "Score: \(game.score)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .white : .red
            }
        }
    }
    
    private func getEmoji(for card: Card) -> String {
        if cardEmoji[card] == nil, emojiChoices.count > 0 {
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            cardEmoji[card] = String(emojiChoices.remove(at: stringIndex))
            
            //let randomIndex = getRandomIndex(for: emojiChoices.count)
            //cardEmoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return cardEmoji[card] ?? "?"
    }
    
    func getRandomIndex(for arrayCount: Int) -> Int {
        return Int(arc4random_uniform(UInt32(arrayCount)))
    }
    
    
    @objc func restartButtonTapped(_ sender: UIButton) {
        
    }


}

extension Int {
    var arc4Random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
    }
}

