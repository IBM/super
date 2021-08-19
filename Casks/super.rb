cask "super" do
  version "1.6.7"

  name "Super"
  desc "CLI for the Serverless Supercomputer"
  homepage "https://github.com/IBM/super"

  if Hardware::CPU.intel?
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-x64.tar.bz2"
    sha256 "b531df0a8c4e7381779423f3cae406eaa99e7fb476a1a349719f4828e3890faf"
    app "Super-darwin-x64/Super.app"
  else
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-amd64.tar.bz2"
    sha256 "047bb8ae13db93e7103b658c10002c858665ff8b8d9f2bc277722c1dc5f3a36f"
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
