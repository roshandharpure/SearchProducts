//
//  ViewController.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Variables
    
    // Initialize view model
    lazy var searchViewModel: SearchViewModel = {
        let viewModel = SearchViewModel()
        return viewModel
    }()
    
    private var searchText = "" {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Add products data observer
        observeProductsData()
        
        // Setup view components
        setupUIComponents()
    }
    
    func setupUIComponents() {
        /// Setup tableview delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // Hide tableview initially
        self.tableView.isHidden = true
        
        /// Register custom table view cell to show data
        tableView.register(UINib(nibName: String(describing: ProductCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProductCell.self))
    }
    
    func observeProductsData() {
        searchViewModel.completion = { [weak self] (products, error) in
            if let products = products, !products.isEmpty {
                /// API Success
                /// Reload the tableview to load the data
                DispatchQueue.main.async {
                    self?.updateUIForResults()
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                }
            } else {
                /// API Failure
                /// If no data found after API call.
                DispatchQueue.main.async {
                    self?.updateUIForResults()
                    self?.tableView.isHidden = true
    
                   // self?.emptyDataLabel.text = error.message
                }
            }
        }
    }
    
    func searchTextDidEntered() {
        // When initiate API call show activity indicator
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // Hide table view while calling an API
        tableView.isHidden = true
        
        // API Call method
        getProducts()
    }
    
    // call get Product API from view model
    func getProducts() {
        searchViewModel.getProducts(searchText: searchText)
    }
    
    func updateUIForResults() {
        /// Hide activity indicator
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
}

//MARK: - Search bar delegates
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print(searchBar.text ?? "")
        searchText = searchBar.text ?? ""
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

//MARK: - Search tableview data source and delegates
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Get the acromine  data count from view model acromine model
        return searchViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        
        /// Render data on tableview cell
        cell.setUpCellWith(product: searchViewModel.products[indexPath.row])
        
        return cell
    }
}
