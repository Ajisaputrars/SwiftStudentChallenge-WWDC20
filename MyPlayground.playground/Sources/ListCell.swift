import UIKit

public class ListCell: UICollectionViewCell {
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 157, height: 170))
        return imageView
    }()
    
    let itemLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 170, width: 157, height: 30))
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupView(){
        self.addSubview(itemImageView)
        self.addSubview(itemLabel)
    }
}
