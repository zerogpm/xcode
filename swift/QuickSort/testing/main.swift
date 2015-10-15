//
//  main.swift
//  testing
//
//  Created by Jian Su on 2015-10-12.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import Foundation

var DaysInArray = [3,2,1,4]


func insertionSort(var arr: [Int]) -> [Int]
{
    for i in 1..<arr.count {
        var j = i
        let target = arr[i]
        
        while j > 0 && target < arr[j - 1] {
            swap(&arr[j], &arr[j - 1])
            j--
        }
        arr[j] = target
    }
    
    return arr;
}

func selectionSort(var arr: [Int]) -> [Int]
{
    var minIndex = 0
    
    for i in 0..<arr.count {
        minIndex = i
        
        for j in (i + 1)..<arr.count {
            if arr[j] < arr[minIndex] {
                minIndex = j
            }
        }
        
        if (minIndex != i) {
            swap(&arr[i], &arr[minIndex])
        }
    }
    return arr;
}

func partition(inout arr: [Int], left: Int, right: Int) -> Int
{
    var i = left
    var j = right
    let pivot = arr[(left + right) / 2]
    
    while i <= j {
        while arr[i] < pivot {
            i++
        }
        
        while j > 0 && arr[j] > pivot {
            j--
        }
        
        if i <= j {
            swap(&arr[i], &arr[j])
            i++
            
            if j > 0 {
                j--
            }
        }
    }
    return i
}

func quickSort(inout arr: [Int], left: Int, right: Int)
{
    let index = partition(&arr, left: left, right: right)
    
    if left < index - 1 {
        quickSort(&arr, left: left, right: index - 1)
    }
    
    if index < right {
        quickSort(&arr, left: index, right: right)
    }
}

print(insertionSort(DaysInArray))