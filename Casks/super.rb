cask "super" do
  version "1.6.12"

  name "Super"
  desc "CLI for the Serverless Supercomputer"
  homepage "https://github.com/IBM/super"

  if Hardware::CPU.intel?
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-x64.tar.bz2"
    sha256 "06f7a0b8fea8c27f07924528f6cbbe3a64401e418397d1b4eaf091d4ac0fd729"
    app "Super-darwin-x64/Super.app"
  else
    url "https://github.com/IBM/super/releases/download/v#{version}/Super-darwin-amd64.tar.bz2"
    sha256 "41a27721deb2f6bdf49efb065dbe16162c6d07dcd7eee75dea9c2f59e993b33d"
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
