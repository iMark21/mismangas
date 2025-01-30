//
//  MangaFilterViewModelTests.swift
//  mismangas
//
//  Created by Michel Marques on 30/1/25.
//

import Foundation
import Testing
@testable import mismangas

@Suite
struct MangaFilterViewModelTests {
    
    // MARK: - Properties
    
    private var sut: MangaFilterViewModel
    
    // MARK: - Initialization
    
    init() {
        let filter = MangaFilter(id: nil, query: "", searchType: .none)
        sut = MangaFilterViewModel(filter: filter)
    }
    
    // MARK: - Tests
    
    @Test
    func testIsFilterValidWhenQueryIsEmpty() {
        // GIVEN
        sut.filter.query = ""
        
        // WHEN
        let isValid = sut.isFilterValid
        
        // THEN
        #expect(isValid == false)
    }
    
    @Test
    func testIsFilterValidWhenQueryIsNotEmpty() {
        // GIVEN
        sut.filter.query = "Naruto"
        
        // WHEN
        let isValid = sut.isFilterValid
        
        // THEN
        #expect(isValid == true)
    }
    
    @Test
    func testInitializeFilterWhenSearchTypeIsNone() {
        // GIVEN
        sut.filter.searchType = .none
        
        // WHEN
        sut.initializeFilter()
        
        // THEN
        #expect(sut.filter.searchType == .beginsWith)
    }
    
    @Test
    func testInitializeFilterWhenSearchTypeIsAlreadySet() {
        // GIVEN
        sut.filter.searchType = .contains
        
        // WHEN
        sut.initializeFilter()
        
        // THEN
        #expect(sut.filter.searchType == .contains)
    }
    
    @Test
    func testResetFilters() {
        // GIVEN
        sut.filter.id = "1"
        sut.filter.query = "Naruto"
        sut.filter.searchType = .beginsWith
        
        // WHEN
        sut.resetFilters()
        
        // THEN
        #expect(sut.filter.id == nil)
        #expect(sut.filter.query == "")
        #expect(sut.filter.searchType == .none)
    }
    
    @Test
    func testResetQueryIfNeededWhenQueryIsNotEmpty() {
        // GIVEN
        sut.filter.query = "Naruto"
        
        // WHEN
        sut.resetQueryIfNeeded()
        
        // THEN
        #expect(sut.filter.query == "")
    }
    
    @Test
    func testResetQueryIfNeededWhenQueryIsEmpty() {
        // GIVEN
        sut.filter.query = ""
        
        // WHEN
        sut.resetQueryIfNeeded()
        
        // THEN
        #expect(sut.filter.query == "")
    }
    
    @Test
    func testUpdateSelectedItem() {
        // GIVEN
        let newType: SearchType = .contains
        let newId = "2"
        let newQuery = "One Piece"
        
        // WHEN
        sut.updateSelectedItem(for: newType, id: newId, query: newQuery)
        
        // THEN
        #expect(sut.filter.id == newId)
        #expect(sut.filter.query == newQuery)
        #expect(sut.filter.searchType == newType)
    }
}
