//
//  Scenes.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//
import Foundation
import FOCalendar

enum CardState {
    case expanded
    case collapsed
}

class DiaryScene: UIView {
    
    private var controller: DiaryViewController?
    private var foods: [FoodOff]? {
        didSet {
            diaryTableView.reloadData()
            noIngestedFood = foods ?? []
        }
    }
    private var ingestedFood: [FoodOff] = []
    private var noIngestedFood: [FoodOff] = []
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    private var cardVisible: Bool = false
    private var nextState: CardState {
        cardVisible ? .collapsed : .expanded
    }
    private var cardViewHeightAnchor: NSLayoutConstraint!
    
    private let collapsedCardHeight: CGFloat = UIScreen.main.bounds.width * 0.95
    private let expandedCardheight: CGFloat = UIScreen.main.bounds.width * 1.3
    
    private let diaryCardComponent = DiaryCardComponent()
    
    lazy var diaryTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.register(DiaryTableViewCellComponent.self, forCellReuseIdentifier: DiaryTableViewCellComponent.reuseIdentifier)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.backgroundColor
        hierarchyView()
        setupConstraints()
        setupCard()
    }
    
    private func setupCard() {
        diaryCardComponent.translatesAutoresizingMaskIntoConstraints = false
        cardViewHeightAnchor = diaryCardComponent.heightAnchor.constraint(equalToConstant: collapsedCardHeight)

        NSLayoutConstraint.activate([
            cardViewHeightAnchor
        ])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        
        diaryCardComponent.handleArea.addGestureRecognizer(tapGestureRecognizer)
        diaryCardComponent.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    private func hierarchyView() {
        addSubview(diaryCardComponent)
        addSubview(diaryTableView)
    }
    
    private func setupConstraints() {
        diaryCardComponentSetupConstraints()
        diaryTableViewSetupConstraints()
    }
    
    private func diaryCardComponentSetupConstraints() {
        diaryCardComponent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            diaryCardComponent.topAnchor.constraint(equalTo: topAnchor),
            diaryCardComponent.leadingAnchor.constraint(equalTo: leadingAnchor),
            diaryCardComponent.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func diaryTableViewSetupConstraints() {
        NSLayoutConstraint.activate([
            diaryTableView.topAnchor.constraint(equalTo: diaryCardComponent.bottomAnchor),
            diaryTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            diaryTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            diaryTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DiaryScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCellComponent.reuseIdentifier, for: indexPath) as? DiaryTableViewCellComponent,
              let food = foods?[indexPath.row] else { fatalError() }

        let foodName = food.food ?? ""
        cell.setData(iconName: foodName.iconTable(), foodName:  foodName)
        cell.checkButtonCallBack = {
            if let food = self.foods?.first(where: {$0.food == cell.getFoodName()}) {
                if cell.isSelected() {
                    if !self.ingestedFood.contains(food) {
                        self.ingestedFood.append(food)
                        self.noIngestedFood.removeAll { $0 == food }
                    }
                } else {
                    if !self.noIngestedFood.contains(food) {
                        self.noIngestedFood.append(food)
                        self.ingestedFood.removeAll { $0 == food }
                    }
                }
            }
            
           // MARK: chamar a função de salvar aqui
            self.controller?.saveFood(ingestedFood: self.ingestedFood, noIngestedFood: self.noIngestedFood)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension DiaryScene: DiarySceneDelegate {
    func setDayAll(days: [Day]) {
        
    }
    
    func setFoodAll(foods: [FoodOff]) {
        self.foods = foods
    }
    
    func setController(controller: DiaryViewController) {
        self.controller = controller
    }
    
    func setUser(user: User?) {
        diaryCardComponent.setUser(user: user)
    }
    
    func setupDatas() {
        controller?.fetchFoodAll()
        controller?.fetchUser()
    }
}

extension DiaryScene {
    @objc
    func handleCardTap(recognzier: UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.diaryCardComponent.handleArea)
            var fractionComplete = translation.y / (324)
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }

    }
    
    private func animateTransitionIfNeeded (state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewHeightAnchor.constant = self.collapsedCardHeight
                    self.diaryCardComponent.setModeCalendar(.collapsed)
                case .collapsed:
                    self.cardViewHeightAnchor.constant = self.expandedCardheight
                    self.diaryCardComponent.setModeCalendar(.expanded)
                }
                self.layoutIfNeeded()
                self.diaryCardComponent.layoutSubviews()
                self.diaryCardComponent.layoutIfNeeded()
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }
    
    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
