import SwiftUI

struct MainView: View {
    @State private var firstValue: String = ""
    @State private var secondValue: String = ""
    @State private var resultValue: String = ""
    @State private var showAlert = false
    
    let firstTextTitle: String = "Перше значення"
    let secondTextTitle: String = "Друге значення"
    let resultTitle: String = "Результат"
    let textOfButton: String = "Обчислити"
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack {
                // MARK: Inputs
                Group {
                    setTitleText(someText: firstTextTitle)
                    setTextField(text: $firstValue)
                    
                    setTitleText(someText: secondTextTitle)
                    setTextField(text: $secondValue)
                }
                Spacer().frame(height: 60)
                
                // MARK: Result Display
                VStack {
                    setTitleText(someText: resultTitle)
                        .bold()
                    setTextField(text: $resultValue)
                        .disabled(true)
                }
                
                // MARK: Calculate Button
                Button(action: {
                    if !isValidInput() {
                        showAlert = true
                    } else {
                        calculateResult()
                    }
                }, label: {
                    setTitleText(someText: textOfButton)
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                })
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Помилка"), message: Text("Введіть дійсні числа"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func calculateResult() {
           if let firstNumber = Double(firstValue), let secondNumber = Double(secondValue) {
               let result = firstNumber + secondNumber
               resultValue = String(result)
           }
       }
    
    private func isValidInput() -> Bool {
        guard !firstValue.isEmpty, !secondValue.isEmpty else {
            return false
        }
        
        return Double(firstValue) != nil && Double(secondValue) != nil
    }
    
    @ViewBuilder
    private func setTitleText(someText: String) -> some View {
        Text(someText)
            .font(.title2)
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    private func setTextField(text: Binding<String>) -> some View {
        TextField("", text: text)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.leading)
            .background(Color.white)
            .padding(10)
            .frame(width: 260)
            .font(.system(size: 24))
    }
}

#Preview {
    MainView()
}
