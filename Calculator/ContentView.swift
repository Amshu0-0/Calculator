//
//  ContentView.swift
//  Calculator
//
//  Created by Amshu Wagle on 9/26/24.
//

import SwiftUI

// main veiw of the app
struct ContentView: View {
    // tracks what to show on screen
    @State private var display: String = ""//starts the display with a empty
    @State private var firstOperand: Double? = nil //first operand for calculations
    @State private var currentOperation: String? = nil //stores current operator
    
    //body defines layout
    var body: some View {
        VStack { //stacks element on top of e/o
            Text(display.isEmpty ? "0" : display )//shows 0 if display is empty
                .font(.largeTitle)//makes text big and clear
                .padding()//adds space around the text
            
            //numbers and operations
            HStack {
                Button("1") {buttonTapped("1")}//when number is tapped, code calls for the button
                Button("2") {buttonTapped("2")}
                Button("3") {buttonTapped("3")}
            }
            HStack {
                Button("4") {buttonTapped("4")}
                Button("5") {buttonTapped("5")}
                Button("6") {buttonTapped("6")}
            }
            HStack {
                Button("7") {buttonTapped("7")}
                Button("8") {buttonTapped("8")}
                Button("9") {buttonTapped("9")}
            }
            HStack {
                Button("0") {buttonTapped("0")}
                Button("+") {operationTapped("+")}
                Button("-") {operationTapped("-")}
            }
            HStack {
                Button("*") { operationTapped("*") }
                Button("/") { operationTapped("/") }
                Button("C") { clearDisplay() }
            }
            HStack {
                Button("<") { backspace() }
                Button("=") { calculateResult() }
            }
        }
    }
    // function which handles what happens when we tap the numbers
    func buttonTapped(_ number: String) {
        // If the display shows a result, clear it and start fresh
        if display.contains("=") {
            display = number // Set display to the new number
        } else {
            // Replaces the display if it's empty or shows 0
            if display.isEmpty || display == "0" {
                display = number
            } else { // else add the number to already existing number
                display += number
            }
        }
    }

    // tapping on operation buttons
    func operationTapped(_ operation: String) {
        // Save the first operand and current operation
        if let currentDisplay = Double(display) {
            firstOperand = currentDisplay // Store the current displayed number
            currentOperation = operation // Set the current operation
            display += " \(operation) " // Show the operation in the display
        }
    }
    
    // Tapping equal button
    func calculateResult() {
        // Split the display to extract operands and operator
        let components = display.split(separator: " ")
        
        guard components.count == 3,
              let firstValue = Double(components[0]),
              let secondValue = Double(components[2]) else { return }
        
        var result: Double?
        
        switch String(components[1]) { // Use the operator from the display
        case "+":
            result = firstValue + secondValue
        case "-":
            result = firstValue - secondValue
        case "*":
            result = firstValue * secondValue
        case "/":
            if secondValue != 0 {
                result = firstValue / secondValue
            } else {
                display = "Error" // Display error if trying to divide by zero
                return
            }
        default:
            break
        }
        
        if let result = result {
            // Format operands and result
            let formattedFirstValue = firstValue.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(firstValue)) : String(firstValue)
            let formattedSecondValue = secondValue.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(secondValue)) : String(secondValue)
            let formattedResult = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(result)
            
            // Display the full operation with formatted numbers
            display = "\(formattedFirstValue) \(components[1]) \(formattedSecondValue) = \(formattedResult)"
        }
        
        // Reset operands and operation
        firstOperand = nil
        currentOperation = nil
    }
        
    // Clear display
    func clearDisplay() {
        display = ""
        firstOperand = nil
        currentOperation = nil
    }
        
    // Backspace function
    func backspace() {
        if !display.isEmpty {
            display.removeLast() // Remove the last character from the display
        }
    }
}
