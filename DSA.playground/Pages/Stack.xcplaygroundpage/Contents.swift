import Foundation

/**
 * Stack errors
 */
enum StackError: Error {
    case stackOverflow
}

/**
 * Stack implementation
 */
struct Stack<T> {
    private var stack: [T]
    private let size: Int
    
    /**
     * Initialize stack of provided size
     */
    init(size: Int) {
        stack = []
        self.size = size
    }
    
    /**
     * Check if stack is empty
     */
    var isEmpty: Bool {
        return stack.count == 0
    }
    
    /**
     * Check if stack is full
     */
    var isFull: Bool {
        return stack.count == size
    }
    
    /**
     * Push value to stack
     */
    mutating func push(_ value: T) throws {
        if isFull {
            throw StackError.stackOverflow
        }
        
        stack.append(value)
    }
    
    /**
     * Pop value from stack
     */
    mutating func pop() -> T? {
        if isEmpty {
            return nil
        }
        
        return stack.removeLast()
    }
    
    /**
     * Get value on top of stack
     */
    var peek: T? {
        return stack.last
    }
}

/**
 * ---------------------------------------------------------------------------------------
 * Stack usage example
 * ---------------------------------------------------------------------------------------
 */
var stack = Stack<Int>(size: 5)

// Check initial states
assert(stack.pop() == nil)
assert(stack.peek == nil)
assert(stack.isEmpty == true)
assert(stack.isFull == false)

// Push values to stack
try stack.push(5)
try stack.push(10)
try stack.push(4)
try stack.push(2)

// Check state after pushes
assert(stack.isEmpty == false)
assert(stack.isFull == false)

// Check peek
if let peekValue = stack.peek {
    assert(peekValue == 2)
} else {
    assert(false)
}

// Check pop
if let popValue = stack.pop(), let peekValue = stack.peek {
    assert(popValue == 2)
    assert(peekValue == 4)
} else {
    assert(false)
}

// Check is full
try stack.push(3)
try stack.push(11)
assert(stack.isFull == true)

// Check push to full stack
do {
    try stack.push(15)
} catch StackError.stackOverflow {
    assert(true)
} catch {
    assert(false)
}

