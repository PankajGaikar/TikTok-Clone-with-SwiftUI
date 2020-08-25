//
//  CategoryViewModel.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

/*
 * Custom error class
 * Error triggered will either be network error or parsing error.
 */
enum DataError: Error {
    case parsing
}

/*
 * This protocol will be utilised to inform View classes regarding network activities,
 * such as success in data retrieval and failures
 */
protocol CategoryViewModelDelegate {
    func dataLoadSuccess()
    func dataLoadError(error: DataError)
}


class CategoryViewModel {
    
    var categories: [Category] = []
    
    //Data updation protocol instance
    var categoryViewModelDelegate: CategoryViewModelDelegate?
    
    /*
     * This API fetches the local JSON file data.
     * This API converts the data to Category models array.
     */
    func getCategoriesData() -> Void {
        
        if let path = Bundle.main.path(forResource: Constants.LocalJSONFile.NAME, ofType: Constants.LocalJSONFile.EXTENSION) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let decoder = JSONDecoder()
                self.categories = try decoder.decode([Category].self, from: data)
                self.categoryViewModelDelegate?.dataLoadSuccess()
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                self.categoryViewModelDelegate?.dataLoadError(error: DataError.parsing)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
}
