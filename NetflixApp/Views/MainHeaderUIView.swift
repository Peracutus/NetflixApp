//
//  MainHeaderUIView.swift
//  NetflixApp
//
//  Created by Roman on 30.09.2022.
//

import UIKit
import EasyPeasy

class MainHeaderUIView: UIView {
    
    //MARK: - properties
    private let stackView: UIStackView = {
       let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 30
        sv.contentMode = .scaleAspectFill
        sv.autoresizingMask = .flexibleWidth
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let downloadButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Download", for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        //UIColor.systemBackground.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    private let playButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Play", for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        //UIColor.systemBackground.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        return btn
    }()

    private let generalImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "wolfWallStreet")
        return image
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(generalImageView)
        
        addGradientLayer()
        
        addSubview(stackView)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(downloadButton)
        stackView.easy.layout(Left(30), Bottom(50), Right(30))
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        generalImageView.frame = bounds
    }
    
    private func addGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
           // UIColor.black.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

