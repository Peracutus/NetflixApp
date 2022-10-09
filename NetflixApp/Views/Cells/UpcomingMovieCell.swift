//
//  UpcomingMovieCell.swift
//  NetflixApp
//
//  Created by Roman on 09.10.2022.
//

import UIKit
import EasyPeasy
import SDWebImage

public final class UpcomingMovieCell: UITableViewCell  {
    
    static let id = "UpcomingMovieCell"
    
    private let titleLabel: UILabel = {
        let image = UILabel()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let playButton: UIButton = {
        let image = UIButton()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        [titleLabel, playButton, posterImage].forEach { contentView.addSubview($0) }
        posterImage.easy.layout(Left(), Top(10), Bottom(15), Width(100))
        titleLabel.easy.layout(CenterY(), Left(20).to(posterImage, .right))
    }
    
    func configure(with model: NewMovieDataDetail) {
        titleLabel.text = model.title
        guard let image = model.image else { return }
        guard let url = URL(string: image) else { return }
        posterImage.sd_setImage(with: url, completed: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
