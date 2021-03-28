import UIKit

class CountryTableViewCell: UITableViewCell {
    let view = CountryView()
    
    var country: Country? {
        didSet {
            view.name.text = country?.name
            view.flag.image = country?.flag
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(view)
        
        view.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
