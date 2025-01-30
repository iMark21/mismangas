//
//  URLTests.swift
//  mismangas
//
//  Created by Michel Marques on 29/1/25.
//


import Testing
import Foundation
@testable import mismangas

@Suite
struct URLTests {
    
    // MARK: - Base URL
    
    @Test
    func testGivenBaseURLWhenConstructingThenReturnsCorrectURL() {
        #expect(URL.baseURL == "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")
    }
    
    // MARK: - Static Endpoints
    
    @Test
    func testGivenMangasEndpointWhenConstructingThenReturnsCorrectURL() {
        #expect(URL.mangas.absoluteString == "\(URL.baseURL)/list/mangas")
    }
    
    @Test
    func testGivenBestMangasEndpointWhenConstructingThenReturnsCorrectURL() {
        #expect(URL.bestMangas.absoluteString == "\(URL.baseURL)/list/bestMangas")
    }
    
    // MARK: - Dynamic Endpoints
    
    @Test
    func testGivenPrefixWhenSearchingMangasBeginsWithThenReturnsCorrectURL() {
        let url = URL.searchMangasBeginsWith("dragon")
        #expect(url.absoluteString == "\(URL.baseURL)/search/mangasBeginsWith/dragon")
    }
    
    @Test
    func testGivenTextWhenSearchingMangasContainsThenReturnsCorrectURL() {
        let url = URL.searchMangasContains("ball")
        #expect(url.absoluteString == "\(URL.baseURL)/search/mangasContains/ball")
    }

    @Test
    func testGivenMangaIDWhenFetchingDetailThenReturnsCorrectURL() {
        let url = URL.mangaDetail(for: 42)
        #expect(url.absoluteString == "\(URL.baseURL)/search/manga/42")
    }
    
    // MARK: - User Endpoints
    
    @Test
    func testGivenUserEndpointsWhenConstructingThenReturnCorrectURLs() {
        #expect(URL.registerUser.absoluteString == "\(URL.baseURL)/users")
        #expect(URL.loginUser.absoluteString == "\(URL.baseURL)/users/login")
        #expect(URL.renewToken.absoluteString == "\(URL.baseURL)/users/renew")
    }
    
    // MARK: - User Collection Endpoints
    
    @Test
    func testGivenMangaIDWhenFetchingUserCollectionThenReturnsCorrectURL() {
        let url = URL.userCollectionManga(99)
        #expect(url.absoluteString == "\(URL.baseURL)/collection/manga/99")
    }
    
    // MARK: - Query Parameters
    
    @Test
    func testGivenPageQueryWhenConstructingThenReturnsCorrectQueryItem() {
        let query = URLQueryItem.page(2)
        #expect(query.name == "page")
        #expect(query.value == "2")
    }
    
    @Test
    func testGivenPerQueryWhenConstructingThenReturnsCorrectQueryItem() {
        let query = URLQueryItem.per(50)
        #expect(query.name == "per")
        #expect(query.value == "50")
    }
}
