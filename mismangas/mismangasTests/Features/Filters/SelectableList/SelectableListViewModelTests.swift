//
//  SelectableListViewModelTests.swift
//  mismangasTests
//
//  Created by Michel Marques on 30/1/25.
//

import Testing
@testable import mismangas

@Suite
struct SelectableListViewModelTests {
    
    // MARK: - Properties
    
    private var sut: SelectableListViewModel<MockItem>
    private var mockFetchItemsUseCase: MockFetchItemsUseCase<MockItem>
    
    // MARK: - Initialization
    
    init() {
        mockFetchItemsUseCase = MockFetchItemsUseCase<MockItem>()
        sut = SelectableListViewModel<MockItem>(
            title: "Test List",
            fetchItemsUseCase: mockFetchItemsUseCase
        )
    }
    
    // MARK: - Tests
    
    @Test @MainActor
    func testFetchItemsWhenLoadingThenSetsStateToContent() async throws {
        // GIVEN
        let items = [MockItem(id: "1", name: "Item 1"),
                     MockItem(id: "2", name: "Item 2")]
        
        await mockFetchItemsUseCase.setMockItems(items)
        
        // WHEN
        await sut.fetch()
        
        // THEN
        #expect(sut.state == .content(items: items))
    }
    
    @Test @MainActor
    func testFetchItemsWhenErrorOccursThenSetsStateToError() async throws {
        // GIVEN
        await mockFetchItemsUseCase.setMockError(APIError.custom(message: "Fetch error"))
        
        // WHEN
        await sut.fetch()
        
        // THEN
        #expect(sut.state == .error(message: "Error: Fetch error", items: []))
    }
    
    @Test @MainActor
    func testApplyQueryWhenQueryIsNotEmptyThenFiltersItems() async {
        // GIVEN
        let items = [
            MockItem(id: "1", name: "Naruto"),
            MockItem(id: "2", name: "One Piece"),
            MockItem(id: "3", name: "Dragon Ball")
        ]
        await mockFetchItemsUseCase.setMockItems(items)
        await sut.fetch()
        
        // WHEN
        sut.searchQuery = "Naruto"
        sut.applyQuery()
        
        // THEN
        #expect(sut.state == .content(items: [items[0]]))
    }
    
    @Test @MainActor
    func testApplyQueryWhenQueryIsEmptyThenShowsAllItems() async {
        // GIVEN
        let items = [
            MockItem(id: "1", name: "Naruto"),
            MockItem(id: "2", name: "One Piece"),
            MockItem(id: "3", name: "Dragon Ball")
        ]
        await mockFetchItemsUseCase.setMockItems(items)
        await sut.fetch()
        
        // WHEN
        sut.searchQuery = ""
        sut.applyQuery()
        
        // THEN
        #expect(sut.state == .content(items: items))
    }
    
    @Test @MainActor
    func testSelectItemUpdatesSelectedItem() async {
        // GIVEN
        let item = MockItem(id: "1", name: "Naruto")
        var selectedItem: MockItem?
        sut.onSelectItem = { selectedItem = $0 }
        
        // WHEN
        sut.selectItem(item)
        
        // THEN
        #expect(selectedItem == item)
    }
}
