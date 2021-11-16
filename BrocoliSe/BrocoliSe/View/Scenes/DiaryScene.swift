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
            foods = foods?.sorted(by: { $0.food ?? "" > $1.food ?? ""})
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
        backgroundColor = UIColor.white
        dayActual = controller?.createToday()
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
            diaryTableView.topAnchor.constraint(equalTo: diaryCardComponent.bottomAnchor, constant: 20),
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
    
    func setupSiri() {
        guard let dayActual = self.dayActual,
              let noIngesteds = dayActual.noIngested as? Set<FoodOff> else {
            return
        }
        
        if !noIngesteds.isEmpty {
            self.foods?.forEach { food in
                var validate = false
                noIngesteds.forEach { noIngested in
                    if food == noIngested {
                        validate = true
                    }
                }
                if validate {
                    controller?.saveFood(today: dayActual, food: food, isCheck: true)
                }
            }
            diaryTableView.reloadData()
        }
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
              let food = foods?[indexPath.row] else { fatalError("ERROR: Array(foods) Index indisponível") }
        cell.changeSelected(false)
        
        let foodName = food.food ?? ""
        
        cell.setData(iconName: foodName.iconTable(), foodName:  foodName)
        cell.checkButtonCallBack = {
            cell.toggleSelected()
            self.cellActionSave(food: food, isCheck: cell.getIsCheck())
            self.controller?.fetchDayAll()
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
    
    private func cellActionSave(food: FoodOff, isCheck: Bool) {
        if let dayActual = self.dayActual {
            self.controller?.saveFood(today: dayActual, food: food, isCheck: isCheck)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.day, .month], from: dayActual?.date ?? Date())
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let today = dateComponents.day,
           let month = dateComponents.month {
            
            let dateComponentsToday = calendar.dateComponents([.day, .month], from: Date())
            
            label.text = dateComponentsToday == dateComponents ? "O que você conseguiu cortar hoje?" : "O que você conseguiu cortar em \(today)/\(month)?"
        } else {
            label.text = "Nenhum registro nessa data!"
        }
        label.font = UIFont.graviolaRegular(size: 20)
        label.textColor = .blueDark
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        headerView.addSubview(label)
        headerView.backgroundColor = .white
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
        ])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension DiaryScene: DiarySceneDelegate {
    func presenterModal(_ modal: ModalViewController) {
        controller?.present(modal, animated: true, completion: nil)
    }
    
    func setDay(daySelected: Day?) {
        guard let daySelected = daySelected,
              let foods = daySelected.foods as? Set<FoodOff> else {
            self.foods = []
            return
        }
        self.dayActual = daySelected
        let foodsArray: [FoodOff] = foods.map { return $0 }
        self.foods = foodsArray
        diaryTableView.reloadData()
    }
    
    func setDayAll(days: [Day]) {
        var daysConcluded = [Day]()
        days.forEach {
            if $0.concluded {
                daysConcluded.append($0)
            }
        }
        let dates: [Date] = daysConcluded.map { return ($0.date ?? Date()) }
        diaryCardComponent.calendar.setDays(Set(dates))
    }
    
    func setFoodAll(foods: [FoodOff]) {
        self.foods = foods
    }
    
    func setController(controller: DiaryViewController) {
        self.controller = controller
        diaryCardComponent.controller = controller
    }
    
    func setUser(user: User?) {
        diaryCardComponent.setUser(user: user)
    }
    
    func setupDatas() {
        controller?.fetchFoodAll()
        controller?.fetchUser()
        controller?.fetchDayAll()
    }

    func reloadTable() {
        self.diaryTableView.reloadData()
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
