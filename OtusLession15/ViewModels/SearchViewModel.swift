//
//  SearchViewModel.swift
//  OtusLession14
//
//  Created by Олег Иванов on 03/09/2019.
//  Copyright © 2019 Otus. All rights reserved.
//

import Foundation

enum SearchViewModelState {
    case unknown
    case result
}

class SearchViewModel {
    var repositories: [Repository]
    var binder: ((SearchViewModelState) -> ())?

    private let githubService: GithubService

    init(githubService: GithubService = GithubService()) {
        self.githubService = githubService
        self.repositories = []
    }
    
    func bind(_ block: @escaping (SearchViewModelState) -> ()) {
        binder = block
    }
 
    func search(with query: String) {
       githubService.searchRepositories(with: query) { [weak self] repositories in
            self?.repositories = repositories.sorted(by: { $0.name < $1.name }).map{ Repository(name: "👑  \($0.name)") }
            self?.binder?(.result)
        }
    }
}
