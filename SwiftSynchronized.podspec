Pod::Spec.new do |s|
    s.name             = "SwiftSynchronized"
    s.version          = "0.0.1"
    s.summary          = "Objective-C's @synchronized ... for Swift"
    s.description      = <<-DESC
    @synchronized for Swift, using calls to the Objective-C runtime and providing nearly identical syntax.
    DESC
    s.homepage         = "https://github.com/jedlewison/SwiftSynchronized"
    s.license          = 'MIT'
    s.author           = { "Jed Lewison" => "jed@.....magic....app....factory.com" }
    s.source           = { :git => "https://github.com/jedlewison/SwiftSynchronized.git", :tag => s.version.to_s }
    s.platform     = :ios, '8.0'
    s.requires_arc = true
    s.source_files = 'SwiftSynchronized/SwiftSynchronized.swift'
end