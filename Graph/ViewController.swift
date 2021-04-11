//
//  ViewController.swift
//  Graph
//
//  Created by Ahmed Khalaf on 4/11/21.
//

import UIKit

class ViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        setupGraphView()
        setupPointRandomizerButton()
        ranomdizePoints()
    }
    
    private let stackView = UIStackView()
    private let graphView = GraphView()
    private let pointRandomizerButton = UIButton()
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupGraphView() {
        graphView.backgroundColor = .init(white: 0.9, alpha: 1)
        graphView.fillColor = .yellow
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            graphView.widthAnchor.constraint(equalToConstant: 200),
            graphView.heightAnchor.constraint(equalToConstant: 100)
        ])
        stackView.addArrangedSubview(graphView)
    }
    
    private func setupPointRandomizerButton() {
        pointRandomizerButton.setTitle("Randomize", for: .normal)
        pointRandomizerButton.setTitleColor(.blue, for: .normal)
        stackView.addArrangedSubview(pointRandomizerButton)
        pointRandomizerButton.addTarget(self, action: #selector(pointRandomizerButtonTapped), for: .touchUpInside)
    }
    
    @objc func pointRandomizerButtonTapped() {
        ranomdizePoints()
    }
    
    private func ranomdizePoints() {
        graphView.points = (0...100).map { x in
            CGPoint(x: x, y: Int.random(in: 0...100))
        }
    }
}

