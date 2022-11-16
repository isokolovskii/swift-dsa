import Foundation

/**
 * Circular queue errors
 */
enum CircularQueueError: Error {
    case queueFull
}

/**
 * Circular queue implementation
 */
struct CircularQueue<T> {
    /**
     * Queue elements
     */
    private var elements: [T?]
    /**
     * Queue front pointer
     */
    private var front = -1
    /**
     * Queue rear pointer
     */
    private var rear = -1
    
    /**
     * Initialize queue
     */
    init(size: Int) {
        elements = Array(repeating: nil, count: size)
    }
    
    /**
     * Check if queue is empty
     */
    var isEmpty: Bool {
        front == -1 && rear == -1
    }
    
    /**
     * Check if queue is full
     */
    var isFull: Bool {
        (rear + 1) % elements.count == front
    }
    
    /**
     * Peek at first item in queue
     */
    var peek: T? {
        if isEmpty {
            return nil
        }
        
        return elements[front]
    }
    
    /**
     * Add to queue
     */
    mutating func enqueue(_ element: T) throws {
        if isFull {
            throw CircularQueueError.queueFull
        }
        
        if front == -1 && rear == -1 {
            front = 0
            rear = 0
            elements[rear] = element
        } else {
            rear = (rear + 1) % elements.count
            elements[rear] = element
        }
    }
    
    /**
     * Remove from queue
     */
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        
        if front == rear {
            defer {
                elements[front] = nil
                front = -1
                rear = -1
            }
            return elements[front]
        } else {
            defer {
                elements[front] = nil
                front = (front + 1) % elements.count
            }
            return elements[front]
        }
    }
}

/**
 * ---------------------------------------------------------------------------------------
 * Circular Queue usage example
 * ---------------------------------------------------------------------------------------
 */
var queue = CircularQueue<Int>(size: 5)

// Check initial states
assert(queue.dequeue() == nil)
assert(queue.peek == nil)
assert(queue.isEmpty == true)
assert(queue.isFull == false)

// Push values to stack
try queue.enqueue(5)
try queue.enqueue(10)
try queue.enqueue(4)
try queue.enqueue(2)

// Check state after pushes
assert(queue.isEmpty == false)
assert(queue.isFull == false)

// Check peek
if let peekValue = queue.peek {
    assert(peekValue == 5)
} else {
    assert(false)
}

// Check pop
if let popValue = queue.dequeue(), let peekValue = queue.peek {
    assert(popValue == 5)
    assert(peekValue == 10)
} else {
    assert(false)
}

// Check is full
try queue.enqueue(3)
try queue.enqueue(11)
assert(queue.isFull == true)

// Check push to full stack
do {
    try queue.enqueue(15)
} catch CircularQueueError.queueFull {
    assert(true)
} catch {
    assert(false)
}
