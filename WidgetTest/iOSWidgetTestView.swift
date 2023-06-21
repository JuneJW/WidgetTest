//
//  ContentView.swift
//  WidgetTest
//
//  Created by sooin on 2023/06/21.
//

import SwiftUI

struct iOSWidgetTestView: View {
    var body: some View {
        NavigationView {
            WeatherView()
                .navigationTitle("날씨")
        }
        .navigationViewStyle(.stack)
    }
}

struct iOSWidgetTestView_Previews: PreviewProvider {
    static var previews: some View {
        iOSWidgetTestView()
    }
}
