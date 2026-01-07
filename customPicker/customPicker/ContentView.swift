//
//  ContentView.swift
//  customPicker
//
//  Created by Nabilah Ashriyah on 07/01/26.
//

import SwiftUI

struct ContentView: View {
  @State var data: [String] = ["Apple", "Banana", "Orange", "Mango"]
  @State var selectedData: String = "Apple"
  
  var body: some View {
    VStack {
      InfinitePicker(data: $data, selectedData: $selectedData)
    }
  }
}


#Preview {
  ContentView()
}
