//
//  MovieCollectionViewCell.swift
//  NetflixApp
//
//  Created by Roman on 09.10.2022.
//

import UIKit
import SDWebImage
import EasyPeasy

public final class MovieCollectionViewCell: UICollectionViewCell  {
    
    static let id = "MovieCollectionViewCell"
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    private let imdbIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "imdbIcon")?.withRenderingMode(.alwaysOriginal)
        return image
    }()
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 12, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.addArrangedSubview(imdbIcon)
        stack.addArrangedSubview(titleLabel)
        stack.backgroundColor = .yellow
        stack.layer.cornerRadius = 5
        stack.clipsToBounds = true
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
        contentView.addSubview(stackView)
        
        posterImage.easy.layout(Edges())
        stackView.easy.layout(Right(5), Bottom(5), Width(40), Height(20))
    }
    
    public func configure(with model: MovieDetail) {
        titleLabel.text = model.imDbRating
        guard let url = URL(string: model.image ?? "") else { return }
        posterImage.sd_setImage(with: url, completed: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
