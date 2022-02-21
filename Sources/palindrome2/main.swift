import CoreFoundation
import Foundation

let numberOfOperations = 5
let queue = OperationQueue()
queue.maxConcurrentOperationCount = numberOfOperations
let schedulingSemaphore = DispatchSemaphore(value: numberOfOperations + 3)

var pendingCompletion = [Int: Int]()
var completed = 0
var lock = NSLock()

for n in 1...10000 {
  schedulingSemaphore.wait()
  queue.addOperation {
    op(n)
    schedulingSemaphore.signal()
    complete(n)
  }
}

func op(_ n: Int) {
  print("Start op #\(n)")
  let group = DispatchGroup()
  group.enter()
  let duration = Double(Int.random(in: 1...9)) / 5
  print("op #\(n) duration: \(duration)")
  group.wait(timeout: .now() + duration)
  print("Finish op #\(n)")
}

func complete(_ n: Int) {
  lock.lock()
  pendingCompletion[n] = n
  while pendingCompletion[completed + 1] != nil {
    completed += 1
    pendingCompletion.removeValue(forKey: completed)
    print("                             completed \(completed)")
  }

  lock.unlock()
}
