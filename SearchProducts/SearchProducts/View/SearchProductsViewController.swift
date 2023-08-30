//
//  ViewController.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import UIKit

class SearchProductsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelError: UILabel!
    
    
    // MARK: - Variables
    
    // Initialize view model
    lazy var searchViewModel: SearchViewModel = {
        let viewModel = SearchViewModel()
        return viewModel
    }()
    
    private var searchText = "" {
        didSet {
            searchTextDidEntered()
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
        
        //Set searchbar delegate
        searchBar.delegate = self
        
        // hide activity indicator
        hideActivityIndicator(hide: true)
        
        //hide error messag label
        labelError.isHidden = true
        
        // Hide tableview initially
        tableView.isHidden = true
        
        /// Register custom table view cell to show data
        tableView.register(UINib(nibName: String(describing: ProductCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProductCell.self))
    }
    
    func observeProductsData() {
        searchViewModel.completion = { [weak self] (products, error) in
            if let products = products, !products.isEmpty {
                /// API Success
                /// Reload the tableview to load the data
                DispatchQueue.main.async {
                    self?.updateUIForResults(isSuccess: true)
                }
            } else {
                /// API Failure
                /// If no data found after API call.
                DispatchQueue.main.async {
                    self?.updateUIForResults(isSuccess: false, errorMessage: error.message)
                }
            }
        }
    }
    
    func searchTextDidEntered() {
        // When initiate API call show activity indicator
        hideActivityIndicator(hide: false)
        
        // Hide table view while calling an API
        tableView.isHidden = true
        
        //hide error messag label
        labelError.isHidden = true
    
        // Call getProducts api
        getProducts()
    }
    
    // call get Product API from view model
    func getProducts() {
        searchViewModel.getProducts(searchText: searchText)
    }
    
    
    func updateUIForResults(isSuccess: Bool, errorMessage: String = "") {
        self.hideActivityIndicator(hide: true)
        tableView.isHidden = !isSuccess
        labelError.isHidden = isSuccess
        self.labelError.text = errorMessage
        
        //reload tableView
        tableView.reloadData()
    }
    
    func hideActivityIndicator(hide: Bool) {
        activityIndicator.isHidden = hide
        hide ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
    }
}

//MARK: - Search bar delegates
extension SearchProductsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchText = searchBar.text ?? ""
    }
}

//MARK: - Search tableview data source and delegates
extension SearchProductsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Get the products  data count from view model 
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
