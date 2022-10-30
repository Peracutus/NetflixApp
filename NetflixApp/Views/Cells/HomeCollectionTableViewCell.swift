//
//  HomeCollectionTableViewCell.swift
//  NetflixApp
//
//  Created by Roman on 30.09.2022.
//

import UIKit

protocol HomeCollectionTableViewCellDelegate: AnyObject {
    func didTappedCell(_ cell: HomeCollectionTableViewCell, vm: TitlePreviewVM)
}

public final class HomeCollectionTableViewCell: UITableViewCell {
    
    static let identifier = "HomeCollectionCell"
    private var titles = [MovieDetail]()
    weak var delegate: HomeCollectionTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupLayout()
    }
    
    public func configure(titles: [MovieDetail]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
        
    }
    
    //MARK: - Layout
    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - extension collectionView
extension HomeCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = titles[indexPath.row] 
        cell.configure(with: model)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.title ?? title.fullTitle else { return }
        
        APICaller.shared.getMovie(from: titleName + " trailer", complition: { [weak self] result in
            switch result {
            case .success(let video):
                guard let self = self else { return}
                self.delegate?.didTappedCell(self, vm: TitlePreviewVM(title: titleName,
                                                                 youtubeVideo: video,
                                                                 titleOvierview: title.crew ?? ""))
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
}
