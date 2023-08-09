//
//  ChooseTimePeriodView.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 09.08.2023.
//

import SwiftUI

struct ChooseTimePeriodView: View {
    @Binding var isShowDateTimeView: Bool
    @Binding var fromDate: Date
    @Binding var toDate: Date
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
                .frame(height: 10)
            
            Text("Choose time period:")
                .font(.system(.title2))
                .padding()
            
            DatePicker("From:",
                       selection: $fromDate,
                       in: ...Date.now,
                       displayedComponents: [.date])
            .environment(\.locale, Locale(identifier: "en_US"))
            
            DatePicker("To:",
                       selection:
                        $toDate,
                       in: ...Date.now,
                       displayedComponents: [.date])
            .environment(\.locale, Locale(identifier: "en_US"))
            
            Button(action: {
                isShowDateTimeView.toggle()
            }, label: {
                Text("Save")
            })
            .padding(.horizontal, 50)
            
            Spacer()
        }
        .padding(.bottom, 15)
    }
}
