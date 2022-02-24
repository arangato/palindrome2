import CoreFoundation
import Foundation

let batchSize: Int64 = 100000
let concurrentOperationCount = 10
let queue = OperationQueue()
queue.maxConcurrentOperationCount = concurrentOperationCount
let schedulingSemaphore = DispatchSemaphore(value: concurrentOperationCount + 1)
var lock = NSLock()

var pendingCompletion = [Int: [UInt64]]()
var lastCompletedBatch = 0
var checkedNumbersCount = 0

var batchNumber = 2
var numOfDigits = 2
var rangeStart: Int64 = 1
var rangeEnd: Int64 = 9
var start = rangeStart

// handling special cases is annoying, so these are hard coded.
// So I cheated a few nano second of compute, so what?!
completeBatch(1, 6, [0, 1, 3, 5, 7, 9])

let step: Int64 = 1_000_000
var checkpoint = step
var found = 0
let startTime = Date()

while true {
  schedulingSemaphore.wait()
  
  var end: Int64
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

func completeBatch(_ n: Int, _ size: Int, _ results: [UInt64]) {
  lock.lock()
  pendingCompletion[n] = results
  while let nextResults = pendingCompletion[lastCompletedBatch + 1] {
    lastCompletedBatch += 1
    pendingCompletion.removeValue(forKey: lastCompletedBatch)
    for n in nextResults {
//      print(n)
    }
  }
  checkedNumbersCount += size
  found += results.count

  if checkedNumbersCount > checkpoint {
    checkpoint += step
    let ellapsedSeconds = Date().timeIntervalSince(startTime)
    let rate = Double(checkedNumbersCount) / ellapsedSeconds
    print("\(ellapsedSeconds):  rate = \(round(rate)) / sec  \(found)   total count: \(checkedNumbersCount)")
  }

  lock.unlock()
}
