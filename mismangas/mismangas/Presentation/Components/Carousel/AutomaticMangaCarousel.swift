//
//  AutomaticMangaCarousel.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//


import SwiftUI

struct AutomaticMangaCarousel: View {
    let mangas: [Manga]
    let isLoading: Bool
    var height: CGFloat
    let onSelect: (Manga) -> Void

    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(height: height)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(mangas.indices, id: \.self) { index in
                        MangaCarouselItem(manga: mangas[index], height: height)
                            .tag(index)
                            .onTapGesture {
                                onSelect(mangas[index])
                            }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onReceive(timer) { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if currentIndex == mangas.count - 1 {
                            currentIndex = 0
                        } else {
                            currentIndex += 1
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    AutomaticMangaCarousel(mangas: Manga.previewData,
                           isLoading: false,
                           height: 300,
                           onSelect: { _ in })
}
