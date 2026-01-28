//
//  InfinitePicker.swift
//  customPicker
//
//  Created by Nabilah Ashriyah on 07/01/26.
//

import SwiftUI

struct InfinitePicker: View {
  @Binding var data: [String]
  @Binding var selectedData: String
  @State private var adjustedData: [String] = []
  @State private var selectedIndex: Int = 0
  
  var body: some View {
    VStack {
      Text("Selected Data: \(selectedData)")
      Picker("", selection: $selectedIndex) {
        ForEach(Array(adjustedData.enumerated()), id: \.offset) { (index, element) in
          Text(element)
            .tag(index)
        }
      }
      .pickerStyle(.wheel)
      .onAppear() {
        guard !data.isEmpty, data.count > 5 else {
          adjustedData = data
          selectedIndex = data.firstIndex(of: selectedData) ?? 0
          return
        }
        
        var temp: [String] = []
        let multiplier = Int(500 / data.count)
        
        if multiplier < 3 {
          temp.append(contentsOf: data)
          temp.append(contentsOf: data)
          temp.append(contentsOf: data)
        } else {
          for _ in 0..<multiplier {
            temp.append(contentsOf: data)
          }
        }
        
        selectedIndex = (data.firstIndex(of: selectedData) ?? 0) + data.count
        adjustedData.removeAll()
        adjustedData.append(contentsOf: temp)
      }
      .onChange(of: selectedIndex) { index in
        selectedData = adjustedData[index]
        
        guard !data.isEmpty, data.count > 5 else { return }
        
        let multiplier = Int(500 / data.count)
        if multiplier < 3 {
          if (index < data.count) {
            selectedIndex = index + data.count
          } else if index > data.count * 2 {
            selectedIndex = index - data.count
          }
        } else {
          if (index < data.count * Int(multiplier / 4)) {
            selectedIndex = index + data.count * Int(multiplier / 4)
          } else if (index > data.count * Int(multiplier / 2)) {
            selectedIndex = index - data.count * Int(multiplier / 2)
          }
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var selectedData: String = "1"
  InfinitePicker(data: .constant(["1","2","3", "4", "5", "6", "7", "8", "9"]), selectedData: $selectedData)
}
