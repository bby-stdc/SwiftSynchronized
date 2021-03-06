Pod::Spec.new do |s|
    s.name             = "SwiftSynchronized"
    s.version          = "1.0.1"
    s.summary          = "Objective-C's @synchronized for Swift, plus performAndWait for NSLock and NSRecursiveLock"
    s.description      = <<-DESC
    @synchronized for Swift, using calls to the Objective-C runtime and providing nearly identical syntax. Also provides performAndWait extension for NSLock and NSRecursiveLock.
    DESC
    s.homepage         = "https://github.com/jedlewison/SwiftSynchronized"
    s.license          = 'MIT'
    s.author           = { "Jed Lewison" => "jed@.....magic....app....factory.com" }
    s.source           = { :git => "https://github.com/jedlewison/SwiftSynchronized.git", :tag => s.version.to_s }
    s.ios.deployment_target = '8.0'
    s.osx.deployment_target = '10.10'
    s.tvos.deployment_target = '9.0'
    s.watchos.deployment_target = '2.0'
    s.requires_arc = true
    s.source_files = 'SwiftSynchronized.{swift,h}'
end
