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
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10
        
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
                
                cardButton.addTarget(self, action: #selector(cardButtonTapped(_:)), for: .touchUpInside)
                
                rowStackView.addArrangedSubview(cardButton)
            }
            
            mainStackView.addArrangedSubview(rowStackView)
        }
        
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            
        ])
        
    }
    
    @objc func cardButtonTapped(_ sender: UIButton) {
        
    }


}

