//
//  PlatformModalPresentationModifier.swift
//  mismangas
//
//  Created by Michel Marques on 26/1/25.
//

import SwiftUI

struct PlatformModalPresentationModifier<Item: Identifiable, ModalContent: View>: ViewModifier {
    @Binding var item: Item?
    var modalContent: (Item) -> ModalContent

    func body(content: Content) -> some View {
        ZStack {
            content

            #if os(macOS)
            if let item = item {
                ZStack {
                    VStack {
                        modalContent(item)

                        Divider()

                        HStack {
                            Spacer()
                            Button("OK") {
                                self.item = nil
                            }
                            .padding()
                        }
                    }
                }
                .background(.black)
                .onTapGesture {
                    self.item = nil
                }
            }
            #else
            content
                .sheet(item: $item) { item in
                    modalContent(item)
                }
            #endif
        }
    }
}

extension View {
    func platformModalPresentation<Item: Identifiable, ModalContent: View>(
        item: Binding<Item?>,
        @ViewBuilder modalContent: @escaping (Item) -> ModalContent
    ) -> some View {
        self.modifier(PlatformModalPresentationModifier(item: item, modalContent: modalContent))
    }
}
