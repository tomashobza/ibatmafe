//
//  test.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("this!").font(.largeTitle)
                Text("this!").font(.headline)
                Text("that!").font(.subheadline)
            }
            Spacer(minLength: 0)
        }
    }
}

struct test: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background
            ZStack {}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)

            // Foreground
            VStack {
                HeaderView()
                Spacer()
            }
        }
    }
}

#Preview {
    test()
}
