# BinaryUtilities

This package does provide to different classes that implement a common `BinaryDataSource` protocol that can be used to represent types of data source which can be read sequentially as a stream of bytes.
`StreamDataSource` can be used to read bytes sequentially from either a file a from a data object. `bufferSize` specifies how many bytes are read at a time.
`ArrayDataSource` reads from a static array of `UInt8` and can be used for testing purposes.
