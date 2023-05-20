import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let currencyCode = Locale.current.currency!.identifier
    
    var grandTotal:Double{
        (checkAmount/100*Double(tipPercentage))+checkAmount
    }
    
    let tipPercentages = [0,10,15,20,25]
    
    var totalPerPerson: Double{
        let tip = checkAmount/100*Double(tipPercentage)
        let grandTotal = checkAmount+tip
        return grandTotal/Double(numberOfPeople+2)
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip percentage",selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format:.percent)
                        }
                    }.pickerStyle(.navigationLink)
                } header: {
                    Text("Tip percentage")
                    
                }
                
                Section{
                    Text(totalPerPerson,format: .currency(code: currencyCode))
                } header:{
                    Text("Amount per person")
                }
                
                Section{
                    Text("Total amount: \(checkAmount)")
                    Text("Grand total: \(grandTotal)")
                    Text(" \(numberOfPeople)")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done",action: {
                        amountIsFocused=false
                    })
                }
            }
        }
    }
}

//debugging
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}
