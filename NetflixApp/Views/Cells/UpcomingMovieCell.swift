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
    
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let image = UILabel()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var stackH: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [posterImage, titleLabel, playButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(stackH)
        stackH.easy.layout(Edges(10))
        posterImage.easy.layout(Size(100))
    }
    
    //MARK: - Configure
    func configure(with model: NewMovieDataDetail ) {
        titleLabel.text = model.title
        guard let image = model.image else { return }
        guard let url = URL(string: image) else { return }
        posterImage.sd_setImage(with: url, completed: nil)
    }
    
    func configure(with model:  SearchResult) {
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
