cask "super" do
  version "1.6.2"

  name "Super"
  desc "CLI for the Serverless Supercomputer"
  homepage "https://github.com/IBM/super"

  if Hardware::CPU.intel?
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-x64.tar.bz2"
    sha256 "7292917f66720f01de9ce2426092956828371dadacc90b83c7deba17b5f5e32b"
    app "Super-darwin-x64/Super.app"
  else
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-amd64.tar.bz2"
    sha256 "P57064bcb17c1957718a135ef5e0360a74f617d9dc274059ff438c21a49499475"
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
