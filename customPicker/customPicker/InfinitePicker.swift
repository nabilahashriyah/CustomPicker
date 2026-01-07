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
        guard !data.isEmpty, data.count > 2 else { return }
        var temp: [String] = []
        temp.append(contentsOf: data)
        temp.append(contentsOf: data)
        temp.append(contentsOf: data)
        
        selectedIndex = data.count
        adjustedData.removeAll()
        adjustedData.append(contentsOf: temp)
      }
      .onChange(of: selectedIndex) { index in
        selectedData = adjustedData[index]
        var temp = adjustedData
        
        if index < data.count {
          let movedData = temp.dropLast(data.count)
          temp.insert(contentsOf: movedData, at: 0)
          selectedIndex = index + data.count
        } else if index > adjustedData.endIndex - data.count {
          let movedData = temp.dropFirst(data.count)
          temp.insert(contentsOf: movedData, at: temp.endIndex)
        }
        
        adjustedData = temp
      }
    }
  }
}

#Preview {
  @Previewable @State var selectedData: String = "1"
  InfinitePicker(data: .constant(["1","2","3", "4", "5", "6", "7", "8", "9"]), selectedData: $selectedData)
}

