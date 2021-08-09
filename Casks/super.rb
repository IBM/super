cask "super" do
  version "1.6.0"

  name "Super"
  desc "CLI for the Serverless Supercomputer"
  homepage "https://github.com/IBM/super"

  if Hardware::CPU.intel?
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-x64.tar.bz2"
    sha256 "2381e091ce94f8effe6393614df6c0d3796f396888fc026c9a4294456e966657"
    app "Super-darwin-x64/Super.app"
  else
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-amd64.tar.bz2"
    sha256 "ef4e69248c085c13f28f3ea871cc3f1d73fe4ee97f94ac95fda157950a255aa0"
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
