import CoreFoundation
import Foundation
import BigNumber

let batchSize: Int = 100000
let concurrentOperationCount = ProcessInfo.processInfo.processorCount
let queue = OperationQueue()
queue.maxConcurrentOperationCount = concurrentOperationCount
let schedulingSemaphore = DispatchSemaphore(value: concurrentOperationCount + 1)
var lock = NSLock()

var pendingCompletion = [Int: [BInt]]()
var lastCompletedBatch = 0
var checkedNumbersCount = 0
var totalCheckedNumbersCount = 0
var dualPalindromeCount = 0

var batchNumber = 2
var numOfDigits = 2
var rangeStart = BInt.one
var rangeEnd = BInt.nine
var start = rangeStart

var found = 0
var startTime = Date()
var measurementStartTime = startTime

// handling special cases is annoying, so these are hard coded.
// So I cheated a few nano second of compute, so what?!
completeBatch(1, 6, [0, 1, 3, 5, 7, 9])

while true {
  schedulingSemaphore.wait()
  
  var end: BInt
  if numOfDigits.isOdd {
    end = start + batchSize / 10 // because each input half is repeated 10 times with different middle digits
  } else {
    end = start + batchSize
  }
  
  end = min(end, rangeEnd)
  
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
    if numOfDigits.isOdd {
      rangeStart *= 10
      rangeEnd = rangeEnd * 10 + 9
    }
    numOfDigits += 1
    start = rangeStart
  } else {
    start = end + 1
  }
  
}

func completeBatch(_ n: Int, _ size: Int, _ results: [BInt]) {
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
