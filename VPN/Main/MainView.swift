import UIKit

class MainView: UIView {
    let connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let aboutButton = UIButton(type: .infoDark)
    let countryView = CountryView()
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addPulseAnimationToConnectButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupView() {
        addSubview(connectButton)
        addSubview(countryView)
        addSubview(loader)
        
        backgroundColor = .white

        connectButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-40)
            $0.width.equalTo(200)
            $0.height.equalTo(30)
        }
        
        countryView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        loader.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
    
    internal func addPulseAnimationToConnectButton() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 1.0
        pulse.toValue = 1.1
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        
        connectButton.layer.add(pulse, forKey: nil)
    }
    
}
