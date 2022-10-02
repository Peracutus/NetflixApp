//
//  HomeViewController.swift
//  NetflixApp
//
//  Created by Roman on 30.09.2022.
//

import UIKit
//import SwiftUI
import EasyPeasy

public final class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trending Moviews","Popular", "Trending Tv", "Upcoming Movies", "Top Rated"]
    
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        //table.bounces = false
        table.register(HomeCollectionTableViewCell.self, forCellReuseIdentifier: HomeCollectionTableViewCell.identifier)
        return table
    }()
    
    private func configureNavBar() {
        
        let image = UIImage(named: "NetflixLogo")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil) // this case is always centered image depicted
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        // navigationItem.leftBarButtonItem?
    }
    
    //MARK: - View LifeCycle
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setupLayout()
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
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
       // label.text = label.text?.uppercased()
        returnedView.addSubview(label)
        label.easy.layout(Edges(), Left(20))
        return returnedView
    }
    
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //        guard let header = view as?  UIListContentConfiguration else { return }
    //        header.font = .systemFont(ofSize: <#T##CGFloat#>)
    //    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
    //        return headerView
    //    }
}
