//
//  CustomTextField.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 20.03.2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        textAlignment = .center
        layer.cornerRadius = 15
        backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        font = .init(name: "Montserrat-Regular", size: 12)
        heightAnchor.constraint(equalToConstant: 29).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
