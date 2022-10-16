//
//  UpcomingViewController.swift
//  NetflixApp
//
//  Created by Roman on 30.09.2022.
//

import UIKit

public final class UpcomingViewController: UIViewController {
    
    private var titles = [NewMovieDataDetail]()
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UpcomingMovieCell.self, forCellReuseIdentifier: UpcomingMovieCell.id)
        return table
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcomingMoviews()
    }
    
    private func fetchUpcomingMoviews() {
        APICaller.shared.getNewMoviews { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.upcomingTable.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
}

 
extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
     
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMovieCell.id, for: indexPath) as? UpcomingMovieCell else {
            return UITableViewCell()
        }
        let index = titles[indexPath.row]
        cell.configure(with: NewMovieDataDetail(title: index.title, image: index.image))
        return cell
    }
}
