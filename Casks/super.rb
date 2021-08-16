cask "super" do
  version "1.6.5"

  name "Super"
  desc "CLI for the Serverless Supercomputer"
  homepage "https://github.com/IBM/super"

  if Hardware::CPU.intel?
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-x64.tar.bz2"
    sha256 "b02e3213a7ac7245303c22faee2ddd66415075c8467ce2ea92ed3433366a380f"
    app "Super-darwin-x64/Super.app"
  else
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-amd64.tar.bz2"
    sha256 "746c9357dcb883477a9365b08fc6d435f1e4a766adf751d46412749d26574e65"
    app "Super-darwin-amd64/Super.app"
  end

  livecheck do
    url :url
    strategy :git
    regex(/^v(\d+(?:\.\d+)*)$/)
  end

  binary "#{appdir}/Super.app/Contents/Resources/super"

  zap trash: "~/Library/Application\ Support/Super"
end
