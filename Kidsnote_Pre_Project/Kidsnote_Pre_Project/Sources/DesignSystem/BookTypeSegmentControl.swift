//
//  BookTypeSegmentControl.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/04.
//

import UIKit

final class BookTypeSegmentControl: UIControl {
    
    private var buttons: [UIButton] = []
    private lazy var backgroundButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var selectedSegmentView: UIView = {
        let view = UIView()
        view.backgroundColor = selectedTitleColor
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private var titleLabels: [UILabel] = []
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: titleLabels)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private var titles: [String] = []
    private let deselectedTitleColor = UIColor.systemGray
    private let selectedTitleColor = UIColor(red: 25 / 255, green: 115 / 255, blue: 230 / 255, alpha: 1.0)
    private let animatingDuration: Double = 0.3
    
    private(set) var selectedSegmentIndex: Int?
    
    private var selectableSegmentCount: Int {
        return titles.count
    }
    
    func setTitles(_ titles: [String]) {
        self.titles = titles
        configureUI(with: titles)
        layoutUI()
    }
    
    func selectSegment(at targetIndex: Int) {
        guard 0..<selectableSegmentCount ~= targetIndex else { return }
        let latestSelectedSegmentIndex = selectedSegmentIndex
        selectedSegmentIndex = targetIndex
        
        changeTitleColor(selectAt: targetIndex, deselectAt: latestSelectedSegmentIndex)
        
        if latestSelectedSegmentIndex != nil {
            moveSelectedSegmentView(to: targetIndex)
        } else {
            layoutSelectedSegmentView(to: targetIndex)
        }
        
        sendActions(for: .valueChanged)
    }
}

// MARK: - Animating Methods

private extension BookTypeSegmentControl {
    func moveSelectedSegmentView(to index: Int) {
        guard index < buttons.count else { return }
        
        let button = buttons[index]
        let buttonWidth = button.frame.width
        let selectedViewWidth = selectedSegmentView.frame.width
        let xOffset = (buttonWidth - selectedViewWidth) / 2
        let xPosition = button.frame.minX + xOffset
        
        UIView.animate(withDuration: animatingDuration) {
            self.selectedSegmentView.frame.origin.x = xPosition
        }
    }

    
    func changeTitleColor(selectAt selectedIndex: Int, deselectAt deselectedIndex: Int?) {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.duration = animatingDuration
        
        if let deselectedIndex {
            self.titleLabels[deselectedIndex].layer.add(transition, forKey: CATransitionType.fade.rawValue)
            self.titleLabels[deselectedIndex].textColor = self.deselectedTitleColor
        }
        self.titleLabels[selectedIndex].layer.add(transition, forKey: CATransitionType.fade.rawValue)
        self.titleLabels[selectedIndex].textColor = self.selectedTitleColor
    }
}

// MARK: - Supporting Methods

private extension BookTypeSegmentControl {
    func appendLabel(with text: String?) {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = deselectedTitleColor
        titleLabels.append(label)
    }
    
    func appendButton() {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        buttons.append(button)
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        for (index, selectedButton) in buttons.enumerated() where selectedButton == sender {
            selectSegment(at: index)
        }
    }
}

// MARK: - UI Configuration

private extension BookTypeSegmentControl {
    func configureUI(with titles: [String]) {
        titles.forEach { title in
            appendButton()
            appendLabel(with: title)
        }
    }
    
    func layoutUI() {
        addSubview(backgroundButtonStackView)
        addSubview(selectedSegmentView)
        addSubview(titleStackView)
        
        backgroundButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundButtonStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundButtonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundButtonStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundButtonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func layoutSelectedSegmentView(to index: Int) {
        selectedSegmentView.translatesAutoresizingMaskIntoConstraints = false
        selectedSegmentView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        selectedSegmentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectedSegmentView.centerXAnchor.constraint(equalTo: buttons[index].centerXAnchor).isActive = true
        let widthMultiplier = 1 / CGFloat(selectableSegmentCount) * 0.25
        selectedSegmentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthMultiplier).isActive = true
    }
}
