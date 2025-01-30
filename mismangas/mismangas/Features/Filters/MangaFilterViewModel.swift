//
//  MangaFilterViewModel.swift
//  mismangas
//
//  Created by Michel Marques on 22/1/25.
//


import SwiftUI

@Observable
final class MangaFilterViewModel {
    var filter: MangaFilter
    var showPicker: SearchType? = nil

    init(filter: MangaFilter) {
        self.filter = filter
        initializeFilter()
    }

    var isFilterValid: Bool {
        !filter.query.isEmpty
    }

    func initializeFilter() {
        if filter.searchType == .none {
            filter.searchType = .beginsWith
        }
    }

    func resetFilters() {
        filter.id = nil
        filter.query = ""
        filter.searchType = .none
    }

    func resetQueryIfNeeded() {
        if !filter.query.isEmpty {
            withAnimation(.none) {
                filter.query = ""
            }
        }
    }

    func updateSelectedItem(for type: SearchType, id: String, query: String) {
        filter.id = id
        filter.query = query
        filter.searchType = type
    }
}
