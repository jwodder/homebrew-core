class Qsv < Formula
  desc "Ultra-fast CSV data-wrangling toolkit"
  homepage "https://qsv.dathere.com/"
  url "https://github.com/dathere/qsv/archive/refs/tags/25.0.0.tar.gz"
  sha256 "3e853384663b3df600da7596ca5dc242f7c67acb135d62802cfb9875cc0d80f2"
  license any_of: ["MIT", "Unlicense"]
  revision 1
  head "https://github.com/dathere/qsv.git", branch: "master"

  # There can be a notable gap between when a version is tagged and a
  # corresponding release is created, so we check the "latest" release instead
  # of the Git tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "2876c5066b3d5a1d18ff7111a851dafb2664b9e5e1087dd94679196718a50bfc"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "ce2fe6b792619e998c4338242af738a12d6a40e21eb1e56a8d3739f0add67dbd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "e9265723c1716b3f08c0119f67bdf59b4f8575650e6efe3333c4ad3aed083a30"
    sha256 cellar: :any,                 arm64_linux:       "276fa190f59b7e6c33b947b098d47d640fe2b677c25c9d3821f0bf7109515f34"
    sha256 cellar: :any,                 x86_64_linux:      "a676efdf68940bc3484fce2a7c117e8a220dbbbc73f6a1649acc9c1300c1ee77"
  end

  depends_on "cmake" => :build # for libz-ng-sys
  depends_on "pkgconf" => :build
  depends_on "rust" => :build

  on_linux do
    depends_on "libmagic"
    depends_on "openssl@4" # native-tls for the `viz_static` webdriver client
  end

  def install
    # Use explicit CPU target instead of "native" to avoid brittle behavior
    # see discussion at https://github.com/briansmith/ring/discussions/2528#discussioncomment-13196576
    ENV.append_to_rustflags "-C target-cpu=apple-m1" if OS.mac? && Hardware::CPU.arm?

    # Work around SIGKILL on arm64 linux runner from fat LTO
    github_arm64_linux = OS.linux? && Hardware::CPU.arm? &&
                         ENV["HOMEBREW_GITHUB_ACTIONS"].present? &&
                         ENV["GITHUB_ACTIONS_HOMEBREW_SELF_HOSTED"].blank?
    ENV["CARGO_PROFILE_RELEASE_LTO"] = "thin" if github_arm64_linux

    # Build `viz_static` without plotly's build-time webdriver download and default the
    # runtime driver to the `chromedriver` cask (`WEBDRIVER_PATH` overrides it)
    inreplace "Cargo.toml", '"plotly/static_export_default", "webdriver-downloader"',
                            '"plotly/static_export_chromedriver"'
    ENV["WEBDRIVER_DOWNLOAD_PATH"] = HOMEBREW_PREFIX/"bin/chromedriver"

    features = %w[distrib_features lens]
    system "cargo", "install", *std_cargo_args(features:)

    bash_completion.install "contrib/completions/examples/qsv.bash" => "qsv"
    fish_completion.install "contrib/completions/examples/qsv.fish"
    zsh_completion.install "contrib/completions/examples/qsv.zsh" => "_qsv"
    pwsh_completion.install "contrib/completions/examples/qsv.ps1" => "qsv"
  end

  def caveats
    <<~EOS
      `qsv viz` image export (PNG/SVG/PDF) needs Google Chrome and ChromeDriver:
        brew install --cask google-chrome chromedriver
      or set WEBDRIVER_PATH to an existing chromedriver binary.
    EOS
  end

  test do
    (testpath/"test.csv").write("first header,second header")
    assert_equal <<~CSV, shell_output("#{bin}/qsv stats test.csv")
      field,type,is_ascii,sum,min,max,range,sort_order,sortiness,min_length,max_length,sum_length,avg_length,stddev_length,variance_length,cv_length,mean,sem,geometric_mean,harmonic_mean,stddev,variance,cv,nullcount,n_negative,n_zero,n_positive,max_precision,sparsity
      first header,NULL,,,,,,,,,,,,,,,,,,,,,,0,,,,,
      second header,NULL,,,,,,,,,,,,,,,,,,,,,,0,,,,,
    CSV
  end
end
