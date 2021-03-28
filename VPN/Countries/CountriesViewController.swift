import UIKit
import RxSwift
import RxCocoa

typealias Country = (flag: UIImage, name: String)

class CountriesViewController: UIViewController, UITableViewDelegate {
    let countries: BehaviorRelay<[Country]> = .init(value: [(flag: #imageLiteral(resourceName: "Canada"), name: "Canada"),
                                                        (flag: #imageLiteral(resourceName: "USA"), name: "USA"),
                                                        (flag: #imageLiteral(resourceName: "UK"), name: "UK"),
                                                        (flag: #imageLiteral(resourceName: "China"), name: "China"),
                                                        (flag: #imageLiteral(resourceName: "Canada"), name: "Mexico"),
                                                        (flag: #imageLiteral(resourceName: "Brazil"), name: "Brazil"),
                                                        (flag: #imageLiteral(resourceName: "KG"), name: "Kyrgyz Republic"),
                                                        (flag: #imageLiteral(resourceName: "Russia"), name: "Russia"),
                                                        (flag: #imageLiteral(resourceName: "France"), name: "France"),
                                                        (flag: #imageLiteral(resourceName: "Canada"), name: "Some Country"),
                                                        (flag: #imageLiteral(resourceName: "Canada"), name: "Anoother"),
                                                        (flag: #imageLiteral(resourceName: "Brazil"), name: "AnAnother"),
                                                        (flag: #imageLiteral(resourceName: "Canada"), name: "Some other"),
                                                        (flag: #imageLiteral(resourceName: "Germany"), name: "Germany")])
    
    let tableView = UITableView()
    let selectedCountry: PublishSubject<Country> = .init()
    let disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select a country"
        setupView()
        setDelegate()
        bindToTableView()
        subscribeToSelectedModel()
    }
    
    internal func setupView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    
        tableView.tableFooterView = UIView()
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "Country")
    }
    
    internal func setDelegate() {
        tableView.rx.setDelegate(self).disposed(by: disposableBag)
    }
    
    internal func bindToTableView() {
        countries.bind(to: tableView.rx.items(cellIdentifier: "Country", cellType: CountryTableViewCell.self)) { row, country, cell in
            cell.country = country
        }.disposed(by: disposableBag)
    }
    
    internal func subscribeToSelectedModel() {
        tableView.rx.modelSelected(Country.self)
            .bind(to: selectedCountry)
            .disposed(by: disposableBag)
    }
}
