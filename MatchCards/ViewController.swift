//
//  ViewController.swift
//  MatchCards
//
//  Created by MindMingle on 13/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let cardSymbols = ["🐶", "🐱", "🐭", "🦊", "🐼", "🐯"]
    
    var cards = [Card]()
    var flippedCards = [Card]()
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createCardUI(numberOfRows: 6, cardsPerRow: 6)
    }
    
    func createCardUI(numberOfRows: Int, cardsPerRow: Int) {
        // Create a stack view for the top section
        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.alignment = .fill
        topStackView.distribution = .fillProportionally
        topStackView.spacing = 10
        
        // Create the score label and flip count label
        let scoreLabel = UILabel()
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .left
        let flipCountLabel = UILabel()
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
                cardButton.backgroundColor = .red
                
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
        
        // Add constraints to define the position and size of the parent stack view
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            parentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
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
        
    }
    
    @objc func cardButtonTapped(_ sender: UIButton) {
        
    }


}

