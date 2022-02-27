import CoreFoundation
import Foundation
import BigNumber

let batchSize: UInt64 = 100000
let concurrentOperationCount = ProcessInfo.processInfo.processorCount
let queue = OperationQueue()
queue.maxConcurrentOperationCount = concurrentOperationCount
let schedulingSemaphore = DispatchSemaphore(value: concurrentOperationCount + 1)
var lock = NSLock()

var pendingCompletion = [Int: [String]]() // holds string representation of numbers
var lastCompletedBatch = 0
var checkedNumbersCount = 0
var totalCheckedNumbersCount = 0
var dualPalindromeCount = 0

var batchNumber = 2
var numOfDigits = 2
var rangeStart: UInt64 = 1
var rangeEnd: UInt64 = 9
var start = rangeStart

var found = 0
var startTime = Date()
var measurementStartTime = startTime

// handling special cases is annoying, so these are hard coded.
// So I cheated a few nano second of compute, so what?!
completeBatch(1, 6, ["0", "1", "3", "5", "7", "9"])

// This loop goes over decimal palindroms
while true {
  schedulingSemaphore.wait()
  
  var end: UInt64
  if numOfDigits.isOdd {
    end = start + batchSize / 10 // because each input half is repeated 10 times with different middle digits
  } else {
    end = start + batchSize
  }
  
  end = min(end, rangeEnd)
  
  let startFirstDigit = start.digit(numOfDigits / 2)
  let endFirstDigit = end.digit(numOfDigits / 2)
  if !startFirstDigit.isOdd && startFirstDigit == endFirstDigit {
    start = rangeStart * UInt64(startFirstDigit + 1)
    schedulingSemaphore.signal()
    continue
  }
  
  let batchStart = start
  let batchEnd = end
  let batchDigits = numOfDigits
  let n = batchNumber
  queue.addOperation {
//    print("           batch \(n): \(Int(batchEnd - batchStart + 1)),   " +
//          "start: \(batchStart), end: \(batchEnd)")
    let results = Decimal.makePalindrome(
      highHalfStart: batchStart,
      highHalfEnd: batchEnd,
      numOfDigits: batchDigits
    )
    completeBatch(n, Int(batchEnd - batchStart + 1), results)
    schedulingSemaphore.signal()
  }

  batchNumber += 1
  
  if end == rangeEnd {
    if numOfDigits == 20 {
      break
    }
    
    if numOfDigits.isOdd {
      rangeStart *= 10
      rangeEnd = rangeEnd * 10 + 9
    }

    numOfDigits += 1
    if numOfDigits == 20 {
      // the end of UInt64. some serious sourcery required to go beyond.
      rangeEnd = 1843999999
    }

    start = rangeStart
  } else {
    start = end + 1
  }
}

// This loop goes over numbers larger than UInt64
var rangeStartBInt = BInt("1000000000", radix: 10)!
var rangeEndBInt = BInt("9999999999", radix: 10)!
var startBInt = BInt("1844000000", radix: 10)!

while true {
  schedulingSemaphore.wait()
  
  var end: BInt
  if numOfDigits.isOdd {
    end = startBInt + Int(batchSize / 10) // because each input half is repeated 10 times with different middle digits
  } else {
    end = startBInt + Int(batchSize)
  }
  
  end = min(end, rangeEndBInt)
  
  let startFirstDigit = startBInt.digit(numOfDigits / 2)
  let endFirstDigit = end.digit(numOfDigits / 2)
  if !startFirstDigit.isOdd && startFirstDigit == endFirstDigit {
    startBInt = rangeStartBInt * (startFirstDigit + 1)
    schedulingSemaphore.signal()
    continue
  }

  let batchStart = startBInt
  let batchEnd = end
  let batchDigits = numOfDigits
  let n = batchNumber
  queue.addOperation {
    let results = Decimal.makePalindrome(
      highHalfStart: batchStart,
      highHalfEnd: batchEnd,
      numOfDigits: batchDigits
    )
    completeBatch(n, Int(batchEnd - batchStart + 1), results)
    schedulingSemaphore.signal()
  }

  batchNumber += 1
  if end == rangeEnd {
    if numOfDigits.isOdd {
      rangeStartBInt *= 10
      rangeEndBInt = rangeEndBInt * 10 + 9
    }
    numOfDigits += 1
    startBInt = rangeStartBInt
  } else {
    startBInt = end + 1
  }
}


func completeBatch(_ n: Int, _ size: Int, _ results: [String]) {
  lock.lock()
  pendingCompletion[n] = results
  while let nextResults = pendingCompletion[lastCompletedBatch + 1] {
    lastCompletedBatch += 1
    pendingCompletion.removeValue(forKey: lastCompletedBatch)
    for n in nextResults {
#if !MEASURE
      dualPalindromeCount += 1
      #if TIMING
      let totalEllapsedSeconds = Date().timeIntervalSince(startTime)
      print("\(dualPalindromeCount):  \(n)      \(totalEllapsedSeconds)")
      #else
      print(n)
      #endif
#endif
    }
  }
  
  checkedNumbersCount += size
  totalCheckedNumbersCount += size
  found += results.count
  
#if MEASURE
  let now = Date()
  let ellapsedSeconds = now.timeIntervalSince(measurementStartTime)
  if ellapsedSeconds > 1 {
    let totalEllapsedSeconds = now.timeIntervalSince(startTime)
    let rate = Double(checkedNumbersCount) / ellapsedSeconds
    let totalRate = Double(totalCheckedNumbersCount) / totalEllapsedSeconds
    print("\(totalEllapsedSeconds):  rate = \(round(totalRate)) / sec  \(found)" +
          "   numbers checked: \(checkedNumbersCount)     total count: \(totalCheckedNumbersCount)" +
          "   batches issued: \(batchNumber), completed in order: \(lastCompletedBatch)")
    measurementStartTime = now
    checkedNumbersCount = 0
    if totalEllapsedSeconds > 210.0 {
      exit(0)
    }
  }
#endif

  lock.unlock()
}
