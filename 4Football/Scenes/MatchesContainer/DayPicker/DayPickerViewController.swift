import UIKit

class DayPickerViewController: UICollectionViewController {
    
    // MARK: - Data
    private var loadedDays: [Date] = []
    private let updateHandler: (Date, AnyObject) -> Void
    private let firstDay: Date
    
    //MARK: - Interface
    func updateView(with newDay: Date) {
        guard let index = loadedDays.firstIndex(of: newDay) else {
            return
        }
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    // MARK: - Functions
    private func loadDays(count: Int, from start: Date = .now) {
        loadedDays = start.getPreviousDays(count: count).reversed()
        loadedDays += [start]
        loadedDays += start.getNextDays(count: count)
    }
    
    // MARK: - Init
    init(firstDay: Date, update handler: @escaping (Date, AnyObject) -> Void) {
        self.updateHandler = handler
        self.firstDay = firstDay
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        // TODO: - Extract count constant to config file
        loadDays(count: 30, from: firstDay)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    private var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(
            DayPickerCollectionViewCell.self,
            forCellWithReuseIdentifier: DayPickerCollectionViewCell.identifier
        )
        
        // View configuration
        (collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection = .horizontal
        collectionView.backgroundColor = nil
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Update height of collectionView to its content height
        heightConstraint.constant = collectionViewLayout.collectionViewContentSize.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateView(with: firstDay)
    }
}

// MARK: - Data Source Delegate
extension DayPickerViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedDays.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayPickerCollectionViewCell.identifier, for: indexPath) as! DayPickerCollectionViewCell
        cell.day = loadedDays[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDay = loadedDays[indexPath.row]
        updateView(with: selectedDay)
        updateHandler(selectedDay, self)
    }
}

// MARK: - Layout
extension DayPickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width / 7, height: heightConstraint.constant)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
