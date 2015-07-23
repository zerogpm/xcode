// Playground - noun: a place where people can play

import UIKit


var number = 3

var isPrime = true

for var i=2; i<number; i++ {
    if number % i == 0 {
        isPrime = false
    }
}

println(isPrime)