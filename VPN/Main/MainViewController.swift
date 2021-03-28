import SnapKit
import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    var view_ = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VPN"
        
        setupView()
        subscribeToConnect()
        subscribeToAbout()
    }
    
    internal func subscribeToAbout() {
        view_.aboutButton.rx.tap
            .map(presentCountries)
            .flatMap(subscribeToCountry)
            .subscribe(onNext: updateCountryWithDismiss)
            .disposed(by: disposeBag)
    }
    
    internal func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view_.aboutButton)
        
        view.addSubview(view_)
        view_.snp.makeConstraints {
            $0.bottom.top.leading.trailing.equalToSuperview()
        }
    }
    
    internal func subscribeToCountry(_ controller: CountriesViewController) -> Observable<Country> {
        return controller.selectedCountry.skip(while: { $0.name.isEmpty }).asObservable()
    }
    
    internal func updateCountryWithDismiss(_ country: Country) {
        view_.countryView.name.text = country.name
        view_.countryView.flag.image = country.flag
        
        dismiss(animated: true, completion: nil)
    }
    
    internal func presentCountries() -> CountriesViewController {
        let vc = CountriesViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
        return vc
    }
    
    internal func subscribeToConnect() {
        var timer = 3
        view_.connectButton.rx.tap
            .do(onNext: { [weak self] in
                self?.view_.loader.startAnimating()
            })
            .flatMapLatest({ _ -> Observable<Int> in
                return Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            })
            .subscribe(onNext: { [weak self] _ in
                timer -= 1
                if timer == 0 {
                    self?.stopAnimating()
                    timer = 3
                }
            }).disposed(by: disposeBag)
    }
    
    internal func stopAnimating() {
        DispatchQueue.main.async { [weak self] in
            if self?.view_.loader.isAnimating ?? false {
                self?.view_.loader.stopAnimating()
            }
        }
    }
}

