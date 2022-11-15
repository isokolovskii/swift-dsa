import Foundation

/**
 * Stack errors
 */
enum StackError: Error {
    case emptyStack
    case stackOverflow
}

/**
 * Stack implementation
 */
class Stack<T> {
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
        get {
            return stack.count == 0
        }
    }
    
    /**
     * Check if stack is full
     */
    var isFull: Bool {
        get {
            return stack.count == size
        }
    }
    
    /**
     * Push value to stack
     */
    func push(_ value: T) throws {
        if isFull {
            throw StackError.stackOverflow
        }
        
        stack.append(value)
    }
    
    /**
     * Pop value from stack
     */
    func pop() throws -> T {
        if isEmpty {
            throw StackError.emptyStack
        }
        
        return stack.removeLast()
    }
    
    /**
     * Get value on top of stack
     */
    func peek() throws -> T {
        if isEmpty {
            throw StackError.emptyStack
        }
        
        return stack[stack.count - 1]
    }
}

/**
 * ---------------------------------------------------------------------------------------
 * Stack usage example
 * ---------------------------------------------------------------------------------------
 */
let stack = Stack<Int>(size: 5)

// Check initial states
do {
    try stack.pop()
} catch StackError.emptyStack {
    assert(true)
} catch {
    assert(false)
}
do {
    try stack.peek()
} catch StackError.emptyStack {
    assert(true)
} catch {
    assert(false)
}
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
let peekValue = try stack.peek()
assert(peekValue == 2)

// Check pop
let popValue = try stack.pop()
let peekValue2 = try stack.peek()
assert(popValue == 2)
assert(peekValue2 == 4)

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

