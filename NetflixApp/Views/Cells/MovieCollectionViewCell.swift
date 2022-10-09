//
//  MovieCollectionViewCell.swift
//  NetflixApp
//
//  Created by Roman on 09.10.2022.
//

import UIKit
import SDWebImage

public final class MovieCollectionViewCell: UICollectionViewCell  {
    
    static let id = "MovieCollectionViewCell"
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: model) else { return }
        posterImage.sd_setImage(with: url, completed: nil)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        posterImage.frame = contentView.bounds
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
