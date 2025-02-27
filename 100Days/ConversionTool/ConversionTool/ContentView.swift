import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var far = 0.0
    @State private var cel = 0.0
    @State private var kel = 0.0
    @State private var unit = ["Fahrenheit", "Celsius", "Kelvin"]
    @State private var selectedUnit = "Fahrenheit"
    
    
    var calcFar: Double{
        if selectedUnit == "Fahrenheit"{
            return amount
        } else if selectedUnit == "Celsius"{
            return (amount * 9/5)+32
        } else {
            return (amount - 273.15) * 9/5 + 32
        }
    }
    
    var calcCel: Double{
        if selectedUnit == "Celsius"{
            return amount
        } else if selectedUnit == "Fahrenheit"{
            return (amount - 32) * 5/9
        } else {
            return amount - 273.15
        }
    }
    
    var calcKel: Double{
        if selectedUnit == "Kelvin"{
            return amount
        } else if selectedUnit == "Fahrenheit"{
            return (amount - 32) * 5/9 + 273.15
        } else {
            return amount + 273.15
        }
    }
    
    
    let formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()

    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature") {
                    TextField("Amount", value: $amount, formatter: formatter)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("Unit", selection: $selectedUnit) {
                        ForEach(unit, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Section("Conversions:") {
                        Text("Fahrenheit: \(calcFar)")
                        Text("Celsius: \(calcCel)")
                        Text("Kelvin: \(calcKel)")
                    }

                        
                        
                    

                }
               
            }
            .navigationTitle("ConversionTool")
        }
    }
}

#Preview {
    ContentView()
}
