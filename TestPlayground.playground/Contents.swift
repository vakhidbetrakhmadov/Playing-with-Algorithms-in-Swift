// Subsets //
func generateAllSubsetsBRGC(size: Int) -> [String] {
    if size == 1 {
        return [String](arrayLiteral: "0","1")
    } else {
        var L1 = generateAllSubsetsBRGC(size: size-1)
        var L2: [String] = L1.reversed()
        L1 = L1.map{"0\($0)"}
        L2 = L2.map{"1\($0)"}
        return L1 + L2
    }
}

func generateAllSubsets(size: Int) -> [String] {
    var result = [String]()
    result.append(String(repeating: "0", count: size))
    for i in (0..<size).reversed() {
        result = result + result.map{
            let index = $0.index($0.startIndex, offsetBy: i)
            let nextIndex = $0.index(index, offsetBy: 1)
            return "\( $0[$0.startIndex..<index])1\($0[nextIndex...])"
        }
    }

    return result
}

// Quick sort //
func lomutoPartiotion(array: inout [Int], left: Int, right: Int) -> Int {
    let pivot = array[left]
    var s = left
    for i in left+1..<right {
        if(array[i] < pivot) {
            s+=1
            array.swapAt(i, s)
        }
    }
    array.swapAt(left, s)
    return s
}


func quickSort(array: inout [Int], left: Int, right: Int) {
    if left < right {
        let pivot = lomutoPartiotion(array: &array,left: left, right: right)
        quickSort(array: &array, left: left, right: pivot)
        quickSort(array: &array, left: pivot+1, right: right)
    }
}

func quickSort(array: inout [Int]) {
    quickSort(array: &array, left: 0, right: array.count)
}

// Quick select //
func quickSelect(array: inout [Int], n: Int, left: Int, right: Int) -> Int {
    let pivot = lomutoPartiotion(array: &array , left: left, right: right)
    if pivot == n-1 {
        return array[pivot]
    } else if n-1 < pivot {
        return quickSelect(array: &array,n: n, left: left, right: pivot)
    } else {
        return quickSelect(array: &array,n: n, left: pivot+1, right: right)
    }
}


func quickSelect(array: [Int], n: Int) -> Int {
    var array = array
    return quickSelect(array: &array,n: n, left: 0, right: array.count)
}



// Merge sort with counting inversions//
func merge(left: [Int], right: [Int], merged: inout [Int]) -> Int {
    
    var (leftIndex, rightIndex, mergedIndex) = (0,0,0)
    var invesions = 0
    
    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] < right[rightIndex] {
            merged[mergedIndex] = left[leftIndex]
            leftIndex+=1
            mergedIndex+=1
        }else if right[rightIndex] < left[leftIndex] {
            merged[mergedIndex] = right[rightIndex]
            rightIndex+=1
            mergedIndex+=1
            invesions += left.count-leftIndex
        } else {
            merged[mergedIndex] = left[leftIndex]
            mergedIndex+=1
            leftIndex+=1
            merged[mergedIndex] = right[rightIndex]
            mergedIndex+=1
            rightIndex+=1
        }
    }
    
    while leftIndex < left.count {
        merged[mergedIndex] = left[leftIndex]
        mergedIndex+=1
        leftIndex+=1
    }
    
    while rightIndex < right.count  {
        merged[mergedIndex] = right[rightIndex]
        mergedIndex+=1
        rightIndex+=1
    }
    
    return invesions
}

func mergeSort(array: inout [Int]) -> Int {
    if array.count > 1 {
        let mid = array.count / 2
        var left = Array<Int>(array[0..<mid])
        var right = Array<Int>(array[mid..<array.count])
        let leftInversions = mergeSort(array: &left)
        let rightInversions = mergeSort(array: &right)
        return leftInversions + rightInversions + merge(left: left, right: right, merged: &array)
    }
    
    return 0
}

// Change make //

func changeMake(money: Int, coins: [Int]) -> Int? {
    guard money > 0 && !coins.isEmpty else { return nil }
    
    func changeMake(_ money: Int, _ coins: [Int], _ dpTable: [Int?]) -> Int? {
        var minCoins: Int?
        for coin in coins {
            if (money-coin) >= 0, let dpValue = dpTable[money-coin] {
                minCoins = minCoins == nil ? dpValue+1 : min(minCoins!, dpValue+1)
            }
        }
        return minCoins
    }
    
    var dpTable = Array<Int?>(repeating: 0, count: money+1)
    dpTable[0] = 0

    for part in 1...money {
        dpTable[part] = changeMake(part, coins, dpTable)
    }
    
    return dpTable.last!
}





























