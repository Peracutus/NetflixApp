//
//  HomeViewController.swift
//  NetflixApp
//
//  Created by Roman on 30.09.2022.
//

import UIKit
import EasyPeasy

enum Sections: Int {
    case TrendingMoview = 0
    case TrendingTVs = 1
    case Top250Movies = 2
    case Top250TVs = 3
}

public final class HomeViewController: UIViewController {
    
    private let sectionTitles: [String] = ["Trending Moviews","Trending TVs", "Top 250 Movies", "Top 250 TVs"]
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(HomeCollectionTableViewCell.self, forCellReuseIdentifier: HomeCollectionTableViewCell.identifier)
        return table
    }()
    
    //MARK: - View LifeCycle
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setupLayout()
    }
    
    private func configureNavBar() {
        let image = UIImage(named: "NetflixLogo")?.withRenderingMode(.alwaysOriginal)
        let imageButton = UIButton(type: .custom)
        imageButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        imageButton.setImage(image, for: .normal)
        imageButton.easy.layout(Size(35))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageButton)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupLayout() {
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.showsVerticalScrollIndicator = false
        let headerView = MainHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeTableView.tableHeaderView = headerView
    }
}

//MARK: - TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollectionTableViewCell.identifier, for: indexPath) as? HomeCollectionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMoview.rawValue:
            fetchData(rating: "MostPopularMovies", cell: cell)
        case Sections.TrendingTVs.rawValue:
            fetchData(rating: "MostPopularTVs", cell: cell)
        case Sections.Top250Movies.rawValue:
            fetchData(rating: "Top250Movies", cell: cell)
        case Sections.Top250TVs.rawValue:
            fetchData(rating: "Top250TVs", cell: cell)
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    private func fetchData(rating: String, cell: HomeCollectionTableViewCell) {
        APICaller.shared.getNeedRating(rating: rating) { result in
            switch result {
            case .success(let titles):
                cell.configure(titles: titles)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: .zero)
        let label = UILabel()
        label.text = sectionTitles[section]
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        returnedView.addSubview(label)
        label.easy.layout(Edges(), Left(20))
        return returnedView
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) { ///makes to scrolling nav bar
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: HomeCollectionTableViewCellDelegate {
    func didTappedCell(_ cell: HomeCollectionTableViewCell, vm: TitlePreviewVM) {
        DispatchQueue.main.async { [weak self] in
            let vc = PreviewViewController()
            vc.configure(with: vm)
            self?.navigationController?.pushViewController(vc, animated: true )
        }
    }
}
