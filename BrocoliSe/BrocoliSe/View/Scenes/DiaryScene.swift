//
//  Scenes.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//
import Foundation
import FOCalendar
import UIKit

enum CardState {
    case expanded
    case collapsed
}

class DiaryScene: UIView {
    
    private var controller: DiaryViewController?
    private var foods: [FoodOff]? {
        didSet {
            diaryTableView.reloadData()
        }
    }
    private var ingestedFood: [FoodOff] = []
    private var noIngestedFood: [FoodOff] = []
    private var dayActual: Day? {
        didSet {
            diaryTableView.reloadData()
            // print("Test -> ", dayActual)
        }
    }
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    private var cardVisible: Bool = true
    private var nextState: CardState {
        cardVisible ? .collapsed : .expanded
    }
    private var cardViewHeightAnchor: NSLayoutConstraint!
    
    private let collapsedCardHeight: CGFloat = UIScreen.main.bounds.width * 0.75
    private let expandedCardheight: CGFloat = UIScreen.main.bounds.width * 1.2
    
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
        dayActual = controller?.createToday()
        hierarchyView()
        setupConstraints()
        setupCard()
        print(UIScreen.main.bounds)
    }
    
    private func setupCard() {
        diaryCardComponent.calendar.setCalendarDelegate(self)
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
    
    func setValueProgressBar(_ value: Float) {
        diaryCardComponent.progressBarComponent.setProgressValue(value: value)
    }
    
    func setTextLabelProgress(_ text: String) {
        diaryCardComponent.progressBarComponent.setTitleLabelProgress(text)
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
            self.setupCell(cell)
        }
        
        guard let dayActual = self.dayActual,
              let ingesteds = dayActual.ingested as? Set<FoodOff> else {
            return cell
        }
        
        ingesteds.forEach {
            if $0.food == cell.getFoodName() {
                cell.changeSelected(true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "O que você conseguiu cortar hoje?"
        label.font = UIFont.graviolaRegular(size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        headerView.addSubview(label)
        headerView.backgroundColor = .white
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20)
        ])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    private func setupCell(_ cell: DiaryTableViewCellComponent) {
        
            // MARK: o que ta salvo in [carne, ovo] no [lat]
            guard let dayActual = self.dayActual,
                  let ingesteds: Set<FoodOff> = dayActual.ingested as? Set<FoodOff>,
                  let noIngesteds: Set<FoodOff> = dayActual.noIngested as? Set<FoodOff> else { return }
            
            ingesteds.forEach {
                if !self.ingestedFood.contains($0) {
                    self.ingestedFood.append($0)
                }
            }
            noIngesteds.forEach {
                if !self.noIngestedFood.contains($0) {
                    self.noIngestedFood.append($0)
                }
            }
            if let food = self.foods?.first(where: {$0.food == cell.getFoodName()}) {
                // MARK: in local = [carne, lat](in salvo)
                cell.toggleSelected()
                if cell.getIsCheck() {
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
            
            // MARK: [carne, ovo](in salvo) + [](in local) - [ovo](no local) = [carne]
            ingesteds.forEach {
                if !self.ingestedFood.contains($0) {
                    self.ingestedFood.append($0)
                }
            }
            self.noIngestedFood.forEach { noFood in
                if self.ingestedFood.contains(noFood) {
                    self.ingestedFood.removeAll { $0 == noFood }
                }
            }
            
            // MARK: [lat](no Salvo) + [ovo](no local) - [](in local) = [lat, ovo]
            noIngesteds.forEach {
                if !self.noIngestedFood.contains($0) {
                    self.noIngestedFood.append($0)
                }
            }
            
            self.ingestedFood.forEach { food in
                if self.noIngestedFood.contains(food) {
                    self.noIngestedFood.removeAll { $0 == food }
                }
            }
            
            // MARK: o ideal in [carne] no [ovo, lat]
            self.controller?.saveFood(ingestedFood: self.ingestedFood, noIngestedFood: self.noIngestedFood, today: dayActual)
    }
}

extension DiaryScene: DiarySceneDelegate {
    func presenterModal(_ modal: ModalViewController) {
        controller?.present(modal, animated: true, completion: nil)
    }
    
    func setDay(daySelected: Day?) {
        guard let daySelected = daySelected,
              let foodsHelper = daySelected.foods as? Set<FoodOff> else {
            self.foods = []
            return
        }
        self.dayActual = daySelected
        let foodsHelper2: [FoodOff] = foodsHelper.map { return $0 }
        self.foods = foodsHelper2
        diaryTableView.reloadData()
    }
    
    func setDayAll(days: [Day]) {
        // let dates: [Date] = days.map { return ($0.date ?? Date()) }
        // diaryCardComponent.calendar.setDays(Set(dates))
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
        controller?.fetchDayAll()
    }
}

extension DiaryScene: FOCalendarDelegate {
    func captureCell(date: Date?) {
        guard let date = date else { return }
        let calendar = Calendar(identifier: .gregorian)
        let daySelected = calendar.component(.day, from: date)
        let monthSelected = calendar.component(.month, from: date)
        let yearSelected = calendar.component(.year, from: date)
        
        if daySelected == calendar.component(.day, from: Date()) &&
           monthSelected == calendar.component(.month, from: Date()) &&
           yearSelected == calendar.component(.year, from: Date()) {
            controller?.fetchFoodAll()
            // self.dayActual = controller?.createToday()
        } else {
            // controller?.fetchDay(date)
        }
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
