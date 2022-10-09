//
//  HomeViewController.swift
//  NetflixApp
//
//  Created by Roman on 30.09.2022.
//

import UIKit
//import SwiftUI
import EasyPeasy

enum Sections: Int {
    case TrendingMoview = 0
    case TrendingTVs = 1
}

public final class HomeViewController: UIViewController {
    
    private let sectionTitles: [String] = ["Trending Moviews","Popular", "Trending Tv", "Upcoming Movies", "Top Rated"]
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        //table.bounces = false
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
    
    private func getMostPopularTVs() {
        APICaller.shared.getMostPopularTVs { items in
            switch items {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setupLayout()
        
        getMostPopularTVs()
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
        switch indexPath.section {
        case Sections.TrendingMoview.rawValue:
            APICaller.shared.getMostPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(titles: titles)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        case Sections.TrendingTVs.rawValue:
            APICaller.shared.getMostPopularTVs { result in
                switch result {
                case .success(let titles):
                    cell.configure(titles: titles)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    //        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //            return sectionTitles[section]
    //        }
    
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
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
    //        return headerView
    //    }
}
