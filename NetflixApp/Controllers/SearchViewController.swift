//
//  SearchViewController.swift
//  NetflixApp
//
//  Created by Roman on 30.09.2022.
//

import UIKit
import EasyPeasy

public final class SearchViewController: UIViewController {
    
    //MARK: - Properties
    private let searchTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UpcomingMovieCell.self, forCellReuseIdentifier: UpcomingMovieCell.id)
        return table
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var movies = [SearchResult]()
    private var timer: Timer?
    
    //MARK: - ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .green
        setupLayout()
        setupSearchController()
    }
    
    //MARK: - private methods
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Enter your movie"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupLayout() {
        view.addSubview(searchTable)
        searchTable.easy.layout(Edges())
        searchTable.delegate = self
        searchTable.dataSource = self
        searchController.searchBar.delegate = self
    }
    
    private func fetchSearchingMoviews(expression: String) {
        APICaller.shared.getSearchMovies(expression: expression) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.searchTable.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}

//MARK: - Extensions: TableView delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMovieCell.id, for: indexPath) as? UpcomingMovieCell else {
            return UITableViewCell()
        }
        let index = movies[indexPath.row]
        cell.configure(with: SearchResult(image: index.image, title: index.title))
        return cell
    }
    
}

//MARK: - SerchViewDelegate
extension SearchViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // allows to search moview
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchSearchingMoviews(expression: text!)
            })
        }
    }
}
