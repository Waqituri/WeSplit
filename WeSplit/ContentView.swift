//
//  ContentView.swift
//  WeSplit
//
//  Created by Waqar Hussain on 19/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPerecentage = 20
    @FocusState private var isFocused : Bool
    let precentageAmount = [0, 5, 10, 15, 20]
    var tipvalue : Double  {
        let people = Double(numberOfPeople + 2)
        let perecntage = Double(tipPerecentage)
        let tipValue = amount / 100 * perecntage
        let totalAmount = amount + tipValue
        let amountPerPerson = totalAmount/people
        
        return  amountPerPerson
    }
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Total amount : ", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" )
                        .precision(.fractionLength(2)))
                    .foregroundColor(tipPerecentage == 0 ? .red : .primary)
                    .focused($isFocused)
                    .keyboardType(.decimalPad)
                }
                
                Picker("Number of people:", selection : $numberOfPeople){
                    ForEach (2..<99){
                        Text("\($0) people ")
                    }
                }
                Section("Tip percentage"){
                    Picker("Tip Perecentage", selection: $tipPerecentage){
                        ForEach(precentageAmount, id: \.self){
                            Text($0, format: .percent)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    Text(tipvalue, format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                        .precision(.fractionLength(2)))
                }
                
            }
            .navigationTitle("WeSplit")
            
            .toolbar{
                if isFocused {
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
