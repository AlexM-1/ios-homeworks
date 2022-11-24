import UIKit

class CustomButton: UIButton {
    
    private var buttonTappedAction: (() -> Void)?
    
    init(systemName: String, titleColor: UIColor, buttonTappedAction: (() -> Void)?) {
        super.init(frame: .zero)
        
        self.buttonTappedAction = buttonTappedAction
        
        var configuration = UIButton.Configuration.filled()
        configuration.background.image = UIImage(named: "blue_pixel")
        self.configuration = configuration
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.setImage(UIImage(systemName: systemName), for: .normal)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        configurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.alpha = 1.0
            case .selected, .highlighted, .disabled:
                button.alpha = 0.8
            default:
                button.alpha = 0.8
            }
        }
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        buttonTappedAction?()
    }
    
}
