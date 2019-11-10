import Foundation

public typealias Byte = UInt8
public protocol BinaryDataSource {
    var current: Byte {get}
    var hasData: Bool {get}
    var offset: Int {get}
    func advance()
    func read() -> Byte?
}
public class ArrayDataSource: BinaryDataSource {
    public var current: Byte {
        return buffer[bufferIndex]
    }
    public var offset: Int {
        return bufferIndex
    }
    public func read() -> Byte? {
        defer {
            advance()
        }
        return current
    }
    public func advance() {
        bufferIndex += 1
    }
    public var hasData: Bool {
        return bufferIndex < buffer.count
    }
    var bufferIndex = 0
    let buffer: [UInt8]
    public init(buffer: [UInt8]) {
        self.buffer = buffer
    }
}
public class StreamDataSource: BinaryDataSource {
    public var current: Byte {
        return buffer[bufferIndex]
    }
    public func read() -> Byte? {
        if !hasData {
            return nil
        }
        let byte = current
        advance()
        return byte
    }
    public var hasData: Bool
    public func advance() {
        offset += 1
        if bufferIndex + 1 < dataLen {
            bufferIndex += 1
        } else {
            readFromBuffer()
            if dataLen <= 0 {
                hasData = false
            }
        }
    }
    public var offset = 0
    let stream: InputStream
    var buffer: [UInt8]
    var dataLen: Int = 0
    var bufferIndex: Int = 0
    init?(path: String, bufferSize: Int = 1024) {
        guard let stream = InputStream(fileAtPath: path) else {
            return nil
        }
        buffer = [UInt8](repeating: 0, count: bufferSize)
        self.stream = stream
        self.hasData = true
        stream.open()
        readFromBuffer()
    }
    init(data: Data, bufferSize: Int = 1024) {
        let stream = InputStream(data: data)
        buffer = [UInt8](repeating: 0, count: bufferSize)
        self.stream = stream
        self.hasData = true
        stream.open()
        readFromBuffer()
    }
    deinit {
        stream.close()
    }
    func readFromBuffer() {
        dataLen = stream.read(&buffer, maxLength: buffer.count)
        bufferIndex = 0
    }
}
