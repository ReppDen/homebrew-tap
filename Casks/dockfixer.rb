cask "dockfixer" do
  version "1.0.2"
  sha256 "30fff00a8af5e7d93a6705428057921b5ee354da8d99e240230d5405876c4b45"

  url "https://github.com/ReppDen/dockfixer/releases/download/v#{version}/DockFixer-#{version}.zip"
  name "DockFixer"
  desc "Keeps windows away from the Dock"
  homepage "https://github.com/ReppDen/dockfixer"

  livecheck do
    url "https://github.com/ReppDen/dockfixer/releases/latest/download/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :sonoma

  app "DockFixer.app"

  # The app is signed with a self-signed certificate and not notarised, so
  # Gatekeeper refuses a quarantined copy. Updates arrive through Sparkle,
  # which does not quarantine what it installs.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/DockFixer.app"]
  end

  uninstall quit: "com.github.reppden.dockfixer"

  zap trash: [
    "~/Library/Application Support/DockFixer",
    "~/Library/Caches/com.github.reppden.dockfixer",
    "~/Library/HTTPStorages/com.github.reppden.dockfixer",
    "~/Library/Logs/DockFixer",
    "~/Library/Preferences/com.github.reppden.dockfixer.plist",
  ]
end
