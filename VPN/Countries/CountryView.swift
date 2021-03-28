import UIKit

class CountryView: UIView {
    let flag: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(flag)
        addSubview(name)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupConstraints() {
        flag.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
        }
        
        name.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.leading.equalTo(flag.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.height.equalTo(50).priority(.medium)
        }
    }
}
