
Pod::Spec.new do |s|
  s.name             = "FeedMediaUI"
  s.version          = "0.1.5"
  s.summary          = "UI elements that interact with the 'FeedMedia' pod to retrieve and play music"
  s.description      = <<-DESC
    This is a collection of UI elements that build on top of the 'FeedMedia' cocoapod that
    accesses the Feed.fm music service. Sample elements include: play/pause, skip, and like/dislike
    buttons that update themselves automatically; UILabels that marquee and display the active
    song; and others.

    This pod includes an example app that can be used with 'pod try FeedMediaUI'
                       DESC

  s.homepage         = "https://feed.fm/"
  s.license          = 'MIT'
  s.author           = { "Eric Lambrecht" => "eric@feed.fm", "Feed Media" => "support@feed.fm" }
  s.source           = { :git => "https://github.com/feedfm/iOS-UI-SDK.git", :tag => "v#{s.version}" }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'FeedMediaUI' => ['Pod/Assets/**/*.png']
  }

  s.dependency "FeedMedia", "~> 2.4.5"
  s.dependency "MarqueeLabel", "~> 2.5"

end
