class Dotslash < Formula
  desc "Simplified executable deployment"
  homepage "https://dotslash-cli.com"
  url "https://github.com/facebook/dotslash/archive/refs/tags/v0.5.9.tar.gz"
  sha256 "28cc3b27598d3a776d3c54c2132a8d533a130d80db9deff3c1883b63224dcd41"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "922b39cd7f2ebb17955b6d09f147103c206e8a5a7769a43e9cb61eed67c40976"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "be6210c4f1c4480fd8467d1fb0289f15b5378d53711af6b680ef8befe315df7b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "f4e6f136b3909e6ef3152da3322ee09f4f7a6fdff9a7b8b83df267cfc4726e3f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "142877b7c2c62603e029b5b5fe979a4bdb4a9d297886f3e21f2045a8bba293b1"
    sha256 cellar: :any_skip_relocation, sonoma:            "d65a6e4d7024f59d7ee0589cc25dbc74e79abf9374c3284e5fffbd7ef03bdf5d"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "931f8ae80184b502859c9831f4ce6a762483287f7e3ad6df657490b6d3ae31c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "b6fe22ff3e2ac243dc76d62a6bf341f0d418e50341af7b3d50fbb469a21b79c0"
  end

  depends_on "rust" => :build

  # Regenerate `Cargo.lock` file
  patch :DATA

  allow_network_access! :test

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"node").write <<~EOS
      #!/usr/bin/env dotslash

      // Example file from https://dotslash-cli.com/docs/.
      // The URLs in this file were taken from https://nodejs.org/dist/v18.19.0/

      {
        "name": "node-v18.19.0",
        "platforms": {
          "macos-aarch64": {
            "size": 40660307,
            "hash": "blake3",
            "digest": "6e2ca33951e586e7670016dd9e503d028454bf9249d5ff556347c3d98c347c34",
            "format": "tar.gz",
            "path": "node-v18.19.0-darwin-arm64/bin/node",
            "providers": [
              {
                "url": "https://nodejs.org/dist/v18.19.0/node-v18.19.0-darwin-arm64.tar.gz"
              }
            ]
          },
          "macos-x86_64": {
            "size": 42202872,
            "hash": "blake3",
            "digest": "37521058114e7f71e0de3fe8042c8fa7908305e9115488c6c29b514f9cd2a24c",
            "format": "tar.gz",
            "path": "node-v18.19.0-darwin-x64/bin/node",
            "providers": [
              {
                "url": "https://nodejs.org/dist/v18.19.0/node-v18.19.0-darwin-x64.tar.gz"
              }
            ]
          },
          "linux-aarch64": {
            "size": 44559104,
            "hash": "blake3",
            "digest": "bd605f5957f792def0885db18a9595202ba13f64d2e8d92514f95fb8c8ee5de5",
            "format": "tar.gz",
            "path": "node-v18.19.0-linux-arm64/bin/node",
            "providers": [
              {
                "url": "https://nodejs.org/dist/v18.19.0/node-v18.19.0-linux-arm64.tar.gz"
              }
            ]
          },
          "linux-x86_64": {
            "size": 44694523,
            "hash": "blake3",
            "digest": "72b81fc3a30b7bedc1a09a3fafc4478a1b02e5ebf0ad04ea15d23b3e9dc89212",
            "format": "tar.gz",
            "path": "node-v18.19.0-linux-x64/bin/node",
            "providers": [
              {
                "url": "https://nodejs.org/dist/v18.19.0/node-v18.19.0-linux-x64.tar.gz"
              }
            ]
          }
        }
      }
    EOS
    chmod 0755, testpath/"node"
    assert_match "v18.19.0", shell_output("#{testpath}/node -v")
  end
end

__END__
diff --git a/Cargo.lock b/Cargo.lock
index 6a3c286..74f34c7 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -4,15 +4,15 @@ version = 4
 
 [[package]]
 name = "adler2"
-version = "2.0.0"
+version = "2.0.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "512761e0bb2578dd7380c6baaa0f4ce03e84f95e960231d1dec8bf4d7d6e2627"
+checksum = "320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
 
 [[package]]
 name = "aho-corasick"
-version = "1.1.4"
+version = "1.1.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
+checksum = "c982642fa9e8606056828ee9a8505737230110bb1099153c79efe865c59d12ba"
 dependencies = [
  "memchr",
 ]
@@ -46,44 +46,44 @@ checksum = "940b3a0ca603d1eade50a4846a2afffd5ef57a9feac2c0e2ec2e14f9ead76000"
 
 [[package]]
 name = "anstyle-parse"
-version = "0.2.0"
+version = "0.2.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e765fd216e48e067936442276d1d57399e37bce53c264d6fefbe298080cb57ee"
+checksum = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
 dependencies = [
  "utf8parse",
 ]
 
 [[package]]
 name = "anstyle-query"
-version = "1.0.0"
+version = "1.1.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5ca11d4be1bab0c8bc8734a9aa7bf4ee8316d462a08c6ac5052f888fef5b494b"
+checksum = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
 dependencies = [
- "windows-sys 0.48.0",
+ "windows-sys",
 ]
 
 [[package]]
 name = "anstyle-wincon"
-version = "3.0.7"
+version = "3.0.11"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ca3534e77181a9cc07539ad51f2141fe32f6c3ffd4df76db8ad92346b003ae4e"
+checksum = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
 dependencies = [
  "anstyle",
- "once_cell",
- "windows-sys 0.59.0",
+ "once_cell_polyfill",
+ "windows-sys",
 ]
 
 [[package]]
 name = "anyhow"
-version = "1.0.102"
+version = "1.0.104"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7f202df86484c868dbad7eaa557ef785d5c66295e41b460ef922eca0723b842c"
+checksum = "330a5ed07fa54e4702c9d6c4174f74427fc0ef6e214bbd677ae50a5099946470"
 
 [[package]]
 name = "arbitrary"
-version = "1.4.2"
+version = "1.5.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c3d036a3c4ab069c7b410a2ce876bd74808d2d0888a82667669f8e783a898bf1"
+checksum = "3bc62ac97cc33321f50863d514c3bc38a453947a8f9e781137e47c7401020aed"
 dependencies = [
  "derive_arbitrary",
 ]
@@ -96,9 +96,9 @@ checksum = "76a2e8124351fda1ef8aaaa3bbd7ebbcb486bbcd4225aca0aa0d84bb2db8fecb"
 
 [[package]]
 name = "arrayvec"
-version = "0.7.6"
+version = "0.7.8"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7c02d123df017efcdfbd739ef81735b36c5ba83ec3c59c80a9d7ecc718f92e50"
+checksum = "d3fb67a6e08acf24fdeccbac2cb6ac4305825bd1f117462e0e6f2f193345ad56"
 
 [[package]]
 name = "assert_matches"
@@ -108,15 +108,15 @@ checksum = "9b34d609dfbaf33d6889b2b7106d3ca345eacad44200913df5ba02bfd31d2ba9"
 
 [[package]]
 name = "autocfg"
-version = "1.1.0"
+version = "1.5.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
+checksum = "f2032f911046de80f0a198e0901378627c33f59ea0ac00e363d481118bd70a53"
 
 [[package]]
 name = "bitflags"
-version = "2.11.0"
+version = "2.13.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "843867be96c8daad0d758b57df9392b6d8d271134fce549de6ce169ff98a92af"
+checksum = "3ded4057c258ba199e2d26386d3af3780957ecaee6c4ef4041c6b4b8b97c0b06"
 
 [[package]]
 name = "blake3"
@@ -136,9 +136,9 @@ dependencies = [
 
 [[package]]
 name = "block-buffer"
-version = "0.10.2"
+version = "0.10.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0bf7fe51849ea569fd452f37822f606a5cabb684dc918707a0193fd4664ff324"
+checksum = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
 dependencies = [
  "generic-array",
 ]
@@ -158,9 +158,9 @@ dependencies = [
 
 [[package]]
 name = "bumpalo"
-version = "3.20.2"
+version = "3.20.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5d20789868f4b01b2f2caec9f5c4e0213b41e3e5702a50157d699ae31ced2fcb"
+checksum = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
 
 [[package]]
 name = "bzip2"
@@ -189,9 +189,9 @@ checksum = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
 
 [[package]]
 name = "cc"
-version = "1.2.57"
+version = "1.9.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7a0dd1ca384932ff3641c8718a02769f1698e7563dc6974ffd03346116310423"
+checksum = "877bf67ac8e52449eb2f9e98a344ea163beb70dd1f9eebe3cc5357dcfeaee4df"
 dependencies = [
  "find-msvc-tools",
  "jobserver",
@@ -201,15 +201,15 @@ dependencies = [
 
 [[package]]
 name = "cfg-if"
-version = "1.0.4"
+version = "1.0.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+checksum = "4e7648175b45a9a48536d676f68d918270699102aa8dab5496df06904c914600"
 
 [[package]]
 name = "cfg_aliases"
-version = "0.2.1"
+version = "0.2.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724"
+checksum = "f079e83a288787bcd14a6aea84cee5c87a67c5a3e660c30f557a3d24761b3527"
 
 [[package]]
 name = "ciborium"
@@ -240,18 +240,18 @@ dependencies = [
 
 [[package]]
 name = "clap"
-version = "4.6.0"
+version = "4.6.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b193af5b67834b676abd72466a96c1024e6a6ad978a1f484bd90b85c94041351"
+checksum = "aa8876b300ab35ba921adea3dfd70157a46249b33f95c9084ae5709785478946"
 dependencies = [
  "clap_builder",
 ]
 
 [[package]]
 name = "clap_builder"
-version = "4.6.0"
+version = "4.6.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "714a53001bf66416adb0e2ef5ac857140e7dc3a0c48fb28b2f10762fc4b5069f"
+checksum = "ec0797fb7aeb1406c84efac526901f7ec3ead2124f946b494e72879d4b54704d"
 dependencies = [
  "anstyle",
  "clap_lex",
@@ -259,15 +259,15 @@ dependencies = [
 
 [[package]]
 name = "clap_lex"
-version = "1.0.0"
+version = "1.1.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3a822ea5bc7590f9d40f1ba12c0dc3c2760f3482c6984db1573ad11031420831"
+checksum = "1c133bc6a41be0d194c306b5506d15e6feeea7b1d6604bd3f8310dfb2ca96486"
 
 [[package]]
 name = "colorchoice"
-version = "1.0.0"
+version = "1.0.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "acbf1af155f9b9ef647e42cdc158db4b64a1b61f743629225fde6f3e0be2a7c7"
+checksum = "1d07550c9036bf2ae0c684c4297d503f838287c83c53686d05370d0e139ae570"
 
 [[package]]
 name = "constant_time_eq"
@@ -286,9 +286,9 @@ dependencies = [
 
 [[package]]
 name = "crc32fast"
-version = "1.5.0"
+version = "1.5.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
+checksum = "01a7799fd6b852db0e61728dde9a204c423b44d689dbd432522543614b490e78"
 dependencies = [
  "cfg-if",
 ]
@@ -331,9 +331,9 @@ dependencies = [
 
 [[package]]
 name = "crossbeam-deque"
-version = "0.8.6"
+version = "0.8.8"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
+checksum = "622f3fc73690be383c7214310406f28a90e6edeadc3cea882f9d71e495b9711a"
 dependencies = [
  "crossbeam-epoch",
  "crossbeam-utils",
@@ -341,24 +341,24 @@ dependencies = [
 
 [[package]]
 name = "crossbeam-epoch"
-version = "0.9.18"
+version = "0.9.21"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
+checksum = "dc74980687109a3b14c72fd458107bf0baa1da1a1a805e178d15501ba9b86d9d"
 dependencies = [
  "crossbeam-utils",
 ]
 
 [[package]]
 name = "crossbeam-utils"
-version = "0.8.21"
+version = "0.8.23"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
+checksum = "a31eee39dddec8330830986fcd7625edb5a24ec90ea038215273bbc3adb08ac6"
 
 [[package]]
 name = "crunchy"
-version = "0.2.2"
+version = "0.2.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7a81dae078cea95a014a339291cec439d2f232ebe854a9d672b796c6afafa9b7"
+checksum = "460fbee9c2c2f33933d720630a6a0bac33ba7053db5344fac858d4b8952d77d5"
 
 [[package]]
 name = "crypto-common"
@@ -373,13 +373,13 @@ dependencies = [
 
 [[package]]
 name = "derive_arbitrary"
-version = "1.4.1"
+version = "1.5.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "30542c1ad912e0e3d22a1935c290e12e8a29d704a420177a31faad4a601a0800"
+checksum = "1b034bd7d5f032402a2479444dcc6f74e36a03f31854d41680fb240ef682a1ac"
 dependencies = [
  "proc-macro2",
  "quote",
- "syn",
+ "syn 3.0.9",
 ]
 
 [[package]]
@@ -411,7 +411,7 @@ dependencies = [
  "libc",
  "option-ext",
  "redox_users",
- "windows-sys 0.61.2",
+ "windows-sys",
 ]
 
 [[package]]
@@ -440,7 +440,7 @@ dependencies = [
  "snapbox",
  "tar",
  "tempfile",
- "thiserror 2.0.18",
+ "thiserror 2.0.21",
  "zip",
  "zstd",
 ]
@@ -453,15 +453,15 @@ checksum = "92773504d58c093f6de2459af4af33faa518c13451eb8f2b5698ed3d36e7c813"
 
 [[package]]
 name = "either"
-version = "1.15.0"
+version = "1.19.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
+checksum = "0e9c71c2167ca323c882b99918929403426e2373ea17242ff5653e0d5e1058be"
 
 [[package]]
 name = "equivalent"
-version = "1.0.2"
+version = "1.0.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
+checksum = "00d174d5400e5e8fd687ad1049e2f578285fa914201b1af7e8b112a4546bd826"
 
 [[package]]
 name = "errno"
@@ -470,49 +470,42 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
 dependencies = [
  "libc",
- "windows-sys 0.61.2",
+ "windows-sys",
 ]
 
 [[package]]
 name = "fastrand"
-version = "2.3.0"
+version = "2.5.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
+checksum = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
 
 [[package]]
 name = "filetime"
-version = "0.2.27"
+version = "0.2.29"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "f98844151eee8917efc50bd9e8318cb963ae8b297431495d3f758616ea5c57db"
+checksum = "5c287a33c7f0a620c38e641e7f60827713987b3c0f26e8ddc9462cc69cf75759"
 dependencies = [
  "cfg-if",
  "libc",
- "libredox",
 ]
 
 [[package]]
 name = "find-msvc-tools"
-version = "0.1.9"
+version = "0.1.15"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5baebc0774151f905a1a2cc41989300b1e6fbb29aff0ceffa1064fdd3088d582"
+checksum = "1c66915cc5391097de7a2b0b972e8505aa33c0df401fd3a6811dbdb32881ba48"
 
 [[package]]
 name = "flate2"
-version = "1.1.9"
+version = "1.1.10"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "843fba2746e448b37e26a819579957415c8cef339bf08564fe8b7ddbd959573c"
+checksum = "6e634e2e0ebac1ee034020da1ca582e17ffe4e0f5e985823721e168928136dcb"
 dependencies = [
  "crc32fast",
  "miniz_oxide",
  "zlib-rs",
 ]
 
-[[package]]
-name = "foldhash"
-version = "0.1.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2"
-
 [[package]]
 name = "fs2"
 version = "0.4.3"
@@ -524,24 +517,37 @@ dependencies = [
 ]
 
 [[package]]
-name = "generic-array"
-version = "0.14.7"
+name = "futures-core"
+version = "0.3.34"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
+checksum = "92d699e522242e69e3003b94ecc1f960f3a5e015aa7c5d7486e65ad01dd94f5e"
+
+[[package]]
+name = "futures-task"
+version = "0.3.34"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "cd417de3d1d015fc3bfd2b1ea46dfc7bab72ef86f1cc7cc9c78e728b34a6d1fd"
+
+[[package]]
+name = "futures-util"
+version = "0.3.34"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0d50a92467f8ba5dd6e3ee5d4bd04d73ab2e4e1c44474a0674821dfce14b79bc"
 dependencies = [
- "typenum",
- "version_check",
+ "futures-core",
+ "futures-task",
+ "pin-project-lite",
+ "slab",
 ]
 
 [[package]]
-name = "getrandom"
-version = "0.2.16"
+name = "generic-array"
+version = "0.14.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "335ff9f135e4384c8150d6f27c6daed433577f86b4750418338c01a1a2528592"
+checksum = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
 dependencies = [
- "cfg-if",
- "libc",
- "wasi",
+ "typenum",
+ "version_check",
 ]
 
 [[package]]
@@ -552,21 +558,19 @@ checksum = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
 dependencies = [
  "cfg-if",
  "libc",
- "r-efi",
+ "r-efi 5.3.0",
  "wasip2",
 ]
 
 [[package]]
 name = "getrandom"
-version = "0.4.1"
+version = "0.4.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "139ef39800118c7683f2fd3c98c1b23c09ae076556b435f8e9064ae108aaeeec"
+checksum = "300e883d756b2e4ec94e02791f39b04b522276138852cfc41d9fb7e904106099"
 dependencies = [
  "cfg-if",
  "libc",
- "r-efi",
- "wasip2",
- "wasip3",
+ "r-efi 6.0.0",
 ]
 
 [[package]]
@@ -582,71 +586,42 @@ dependencies = [
 
 [[package]]
 name = "hashbrown"
-version = "0.15.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1"
-dependencies = [
- "foldhash",
-]
-
-[[package]]
-name = "hashbrown"
-version = "0.16.1"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
-
-[[package]]
-name = "heck"
-version = "0.5.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
-
-[[package]]
-name = "hermit-abi"
-version = "0.3.9"
+version = "0.17.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d231dfb89cfffdbc30e7fc41579ed6066ad03abda9e567ccafae602b97ec5024"
+checksum = "ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
 
 [[package]]
 name = "hermit-abi"
-version = "0.5.2"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "fc0fef456e4baa96da950455cd02c081ca953b141298e41db3fc7e36b1da849c"
-
-[[package]]
-name = "id-arena"
-version = "2.3.0"
+version = "0.5.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3d3067d79b975e8844ca9eb072e16b31c3c1c36928edf9c6789548c524d0d954"
+checksum = "e17592d60ebacc7d5e169f4663c5f84f9161cc90328abcfe8456f41e4dfcb284"
 
 [[package]]
 name = "indexmap"
-version = "2.13.0"
+version = "2.14.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7714e70437a7dc3ac8eb7e6f8df75fd8eb422675fc7678aff7364301092b1017"
+checksum = "cc4e190f5d26ca7051642629da2c52fc03bde85a03197c99408dcd291734c855"
 dependencies = [
  "equivalent",
- "hashbrown 0.16.1",
- "serde",
- "serde_core",
+ "hashbrown",
 ]
 
 [[package]]
 name = "is-terminal"
-version = "0.4.9"
+version = "0.4.17"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "cb0889898416213fab133e1d33a0e5858a48177452750691bde3666d0fdbaf8b"
+checksum = "3640c1c38b8e4e43584d8df18be5fc6b0aa314ce6ebf51b53313d4306cca8e46"
 dependencies = [
- "hermit-abi 0.3.9",
- "rustix 0.38.44",
- "windows-sys 0.48.0",
+ "hermit-abi",
+ "libc",
+ "windows-sys",
 ]
 
 [[package]]
 name = "is_terminal_polyfill"
-version = "1.70.1"
+version = "1.70.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7943c866cc5cd64cbc25b2e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
+checksum = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 
 [[package]]
 name = "itertools"
@@ -665,20 +640,22 @@ checksum = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
 
 [[package]]
 name = "jobserver"
-version = "0.1.34"
+version = "0.1.35"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9afb3de4395d6b3e67a780b6de64b51c978ecf11cb9a462c66be7d4ca9039d33"
+checksum = "1c00acbd29eabad4a2392fa0e921c874934dbbf4194312ad20f04a0ed67a3cb3"
 dependencies = [
- "getrandom 0.3.4",
+ "getrandom 0.4.3",
  "libc",
 ]
 
 [[package]]
 name = "js-sys"
-version = "0.3.94"
+version = "0.3.106"
 source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7883d941dae510fb2d978fc3fe018c71c9e2892fd38854de3e8b92c2e5ad9cc5"
 dependencies = [
- "once_cell",
+ "cfg-if",
+ "futures-util",
  "wasm-bindgen",
 ]
 
@@ -691,33 +668,26 @@ dependencies = [
  "serde_json",
 ]
 
-[[package]]
-name = "leb128fmt"
-version = "0.1.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "09edd9e8b54e49e587e4f6295a7d29c3ea94d469cb40ab8ca70b288248a81db2"
-
 [[package]]
 name = "libc"
-version = "0.2.183"
+version = "0.2.191"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b5b646652bf6661599e1da8901b3b9522896f01e736bad5f723fe7a3a27f899d"
+checksum = "65cd87c9a6d60536580b316ad985726104730a5151c99845f2490428ef91240a"
 
 [[package]]
 name = "liblzma"
-version = "0.4.6"
+version = "0.4.9"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b6033b77c21d1f56deeae8014eb9fbe7bdf1765185a6c508b5ca82eeaed7f899"
+checksum = "aa980ea6744074a5b5e0ac6b164aca94fc970121869b3e78ae12a2b0097dbea7"
 dependencies = [
  "liblzma-sys",
- "num_cpus",
 ]
 
 [[package]]
 name = "liblzma-sys"
-version = "0.4.4"
+version = "0.4.9"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "01b9596486f6d60c3bbe644c0e1be1aa6ccc472ad630fe8927b456973d7cb736"
+checksum = "7c7e3581f367a78d7b7e7ae948d023310556f0cfc13156c2e4e00e25616492b9"
 dependencies = [
  "cc",
  "libc",
@@ -726,50 +696,36 @@ dependencies = [
 
 [[package]]
 name = "libredox"
-version = "0.1.12"
+version = "0.1.25"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3d0b95e02c851351f877147b7deea7b1afb1df71b63aa5f8270716e0c5720616"
+checksum = "61ff90caf6077a803a240f62fdbe88645a890bbca49ef8174c3cb0404362171d"
 dependencies = [
- "bitflags",
  "libc",
- "redox_syscall",
 ]
 
-[[package]]
-name = "linux-raw-sys"
-version = "0.4.15"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d26c52dbd32dccf2d10cac7725f8eae5296885fb5703b261f7d0a0739ec807ab"
-
 [[package]]
 name = "linux-raw-sys"
 version = "0.12.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
 
-[[package]]
-name = "lockfree-object-pool"
-version = "0.1.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9374ef4228402d4b7e403e5838cb880d9ee663314b0a900d5a6aabf0c213552e"
-
 [[package]]
 name = "log"
-version = "0.4.29"
+version = "0.4.34"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5e5032e24019045c762d3c0f28f5b6b8bbf38563a65908389bf7978758920897"
+checksum = "f9f8bd3e56ce4dfc153cf470fffbfa98c7620958b312ca5c3a4b8d5181fd13c6"
 
 [[package]]
 name = "memchr"
-version = "2.8.0"
+version = "2.8.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "f8ca58f447f06ed17d5fc4043ce1b10dd205e060fb3ce5b979b8ed8e59ff3f79"
+checksum = "cf8baf1c55e62ffcace7a9f06f4bd9cd3f0c4beb022d3b367256b91b87513d98"
 
 [[package]]
 name = "memmap2"
-version = "0.9.10"
+version = "0.9.11"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "714098028fe011992e1c3962653c96b2d578c4b4bce9036e15ff220319b1e0e3"
+checksum = "d1219ed1b7f229ee7104d281dd01d6802fe28bb6e95d292942c4daacdeb798c0"
 dependencies = [
  "libc",
 ]
@@ -785,9 +741,9 @@ dependencies = [
 
 [[package]]
 name = "miniz_oxide"
-version = "0.8.8"
+version = "0.9.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3be647b768db090acb35d5ec5db2b0e1f1de11133ca123b9eacf5137868f892a"
+checksum = "b63fbc4a50860e98e7b2aa7804ded1db5cbc3aff9193adaff57a6931bf7c4b4c"
 dependencies = [
  "adler2",
  "simd-adler32",
@@ -821,22 +777,18 @@ dependencies = [
  "autocfg",
 ]
 
-[[package]]
-name = "num_cpus"
-version = "1.17.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "91df4bbde75afed763b708b7eee1e8e7651e02d97f6d5dd763e89367e957b23b"
-dependencies = [
- "hermit-abi 0.5.2",
- "libc",
-]
-
 [[package]]
 name = "once_cell"
 version = "1.21.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
 
+[[package]]
+name = "once_cell_polyfill"
+version = "1.70.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
+
 [[package]]
 name = "oorandom"
 version = "11.1.5"
@@ -849,11 +801,17 @@ version = "0.2.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "04744f49eae99ab78e0d5c0b603ab218f515ea8cfe5a456d7629ad883a3b6e7d"
 
+[[package]]
+name = "pin-project-lite"
+version = "0.2.17"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd"
+
 [[package]]
 name = "pkg-config"
-version = "0.3.32"
+version = "0.3.34"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
+checksum = "f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
 
 [[package]]
 name = "plotters"
@@ -892,45 +850,41 @@ dependencies = [
  "zerocopy",
 ]
 
-[[package]]
-name = "prettyplease"
-version = "0.2.37"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "479ca8adacdd7ce8f1fb39ce9ecccbfe93a3f1344b3d0d97f20bc0196208f62b"
-dependencies = [
- "proc-macro2",
- "syn",
-]
-
 [[package]]
 name = "proc-macro2"
-version = "1.0.106"
+version = "1.0.107"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
+checksum = "985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
 dependencies = [
  "unicode-ident",
 ]
 
 [[package]]
 name = "quote"
-version = "1.0.45"
+version = "1.0.47"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "41f2619966050689382d2b44f664f4bc593e129785a36d6ee376ddf37259b924"
+checksum = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
 dependencies = [
  "proc-macro2",
 ]
 
 [[package]]
 name = "r-efi"
-version = "5.2.0"
+version = "5.3.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "74765f6d916ee2faa39bc8e68e4f3ed8949b48cccdac59983d287a7cb71ce9c5"
+checksum = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
+
+[[package]]
+name = "r-efi"
+version = "6.0.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
 
 [[package]]
 name = "rand"
-version = "0.9.2"
+version = "0.9.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
+checksum = "b9ef1d0d795eb7d84685bca4f72f3649f064e6641543d3a8c415898726a57b41"
 dependencies = [
  "rand_chacha",
  "rand_core 0.9.5",
@@ -963,9 +917,9 @@ dependencies = [
 
 [[package]]
 name = "rayon"
-version = "1.11.0"
+version = "1.12.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "368f01d005bf8fd9b1206fb6fa653e6c4a81ceb1466406b81792d87c5677a58f"
+checksum = "fb39b166781f92d482534ef4b4b1b2568f42613b53e5b6c160e24cfbfa30926d"
 dependencies = [
  "either",
  "rayon-core",
@@ -981,31 +935,21 @@ dependencies = [
  "crossbeam-utils",
 ]
 
-[[package]]
-name = "redox_syscall"
-version = "0.7.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "49f3fe0889e69e2ae9e41f4d6c4c0181701d00e4697b356fb1f74173a5e0ee27"
-dependencies = [
- "bitflags",
-]
-
 [[package]]
 name = "redox_users"
-version = "0.5.0"
+version = "0.5.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "dd6f9d3d47bdd2ad6945c5015a226ec6155d0bcdfd8f7cd29f86b71f8de99d2b"
+checksum = "60dc65c0ff1a7ae1294b0c67b9f14baf70b644404010370171787bfac1038fc0"
 dependencies = [
- "getrandom 0.2.16",
  "libredox",
- "thiserror 2.0.18",
+ "thiserror 2.0.21",
 ]
 
 [[package]]
 name = "regex"
-version = "1.12.3"
+version = "1.13.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e10754a14b9137dd7b1e3e5b0493cc9171fdd105e0ab477f51b72e7f3ac0e276"
+checksum = "f020237b6c8eed93db2e2cb53c00c60a8e1bc73da7d073199a1180401450218d"
 dependencies = [
  "aho-corasick",
  "memchr",
@@ -1015,9 +959,9 @@ dependencies = [
 
 [[package]]
 name = "regex-automata"
-version = "0.4.13"
+version = "0.4.18"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5276caf25ac86c8d810222b3dbb938e512c55c6831a10f3e6ed1c93b84041f1c"
+checksum = "ad8553b9b26413251cbf30e620595c7a41b3887f03da04579c0e6b0d6a06b4b2"
 dependencies = [
  "aho-corasick",
  "memchr",
@@ -1026,41 +970,28 @@ dependencies = [
 
 [[package]]
 name = "regex-syntax"
-version = "0.8.8"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7a2d987857b319362043e95f5353c0535c1f58eec5336fdfcf626430af7def58"
-
-[[package]]
-name = "rustix"
-version = "0.38.44"
+version = "0.8.11"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "fdb5bc1ae2baa591800df16c9ca78619bf65c0488b41b96ccec5d11220d8c154"
-dependencies = [
- "bitflags",
- "errno",
- "libc",
- "linux-raw-sys 0.4.15",
- "windows-sys 0.59.0",
-]
+checksum = "d6f6ff9a378485b298a5286656da665ba74413d36db0979633275d2e708145d4"
 
 [[package]]
 name = "rustix"
-version = "1.1.4"
+version = "1.1.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b6fe4565b9518b83ef4f91bb47ce29620ca828bd32cb7e408f0062e9930ba190"
+checksum = "891efababe418670775f199f0d233d84843c227a0949a883ce15b37c78d6629d"
 dependencies = [
  "bitflags",
  "errno",
  "libc",
- "linux-raw-sys 0.12.1",
- "windows-sys 0.61.2",
+ "linux-raw-sys",
+ "windows-sys",
 ]
 
 [[package]]
 name = "rustversion"
-version = "1.0.22"
+version = "1.0.23"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
+checksum = "cf54715a573b99ac80df0bc206da022bcd442c974952c7b9720069370852e21f"
 
 [[package]]
 name = "same-file"
@@ -1071,17 +1002,11 @@ dependencies = [
  "winapi-util",
 ]
 
-[[package]]
-name = "semver"
-version = "1.0.27"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d767eb0aabc880b29956c35734170f26ed551a859dbd361d140cdbeca61ab1e2"
-
 [[package]]
 name = "serde"
-version = "1.0.228"
+version = "1.0.229"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
+checksum = "4148590afebada386688f18773da617792bf2ef03ffc1e4cbd2b1d45b023e0ba"
 dependencies = [
  "serde_core",
  "serde_derive",
@@ -1089,29 +1014,29 @@ dependencies = [
 
 [[package]]
 name = "serde_core"
-version = "1.0.228"
+version = "1.0.229"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
+checksum = "67dca2c9c51e58a4791a4b1ed58308b39c64224d349a935ab5039aa360942a48"
 dependencies = [
  "serde_derive",
 ]
 
 [[package]]
 name = "serde_derive"
-version = "1.0.228"
+version = "1.0.229"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
+checksum = "e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
 dependencies = [
  "proc-macro2",
  "quote",
- "syn",
+ "syn 3.0.9",
 ]
 
 [[package]]
 name = "serde_json"
-version = "1.0.149"
+version = "1.0.154"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
+checksum = "e7e9cc8b1b85264074fbcc02a88680c4096b1e47df8f739dceb03bf482f04bd6"
 dependencies = [
  "itoa",
  "memchr",
@@ -1133,15 +1058,15 @@ dependencies = [
 
 [[package]]
 name = "shlex"
-version = "1.3.0"
+version = "2.0.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
+checksum = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
 
 [[package]]
 name = "simd-adler32"
-version = "0.3.7"
+version = "0.3.10"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d66dc143e6b11c1eddc06d5c423cfc97062865baf299914ab64caa38182078fe"
+checksum = "3a219298ac11a56ea9a6d2120044824d6f01aeb034955e7af7bc16858527deea"
 
 [[package]]
 name = "similar"
@@ -1149,6 +1074,12 @@ version = "2.7.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "bbbb5d9659141646ae647b42fe094daf6c6192d1620870b449d9557f748b2daa"
 
+[[package]]
+name = "slab"
+version = "0.4.12"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
+
 [[package]]
 name = "snapbox"
 version = "0.6.24"
@@ -1182,9 +1113,20 @@ checksum = "13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
 
 [[package]]
 name = "syn"
-version = "2.0.117"
+version = "2.0.119"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862091e2a240a84f17297"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "syn"
+version = "3.0.9"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e665b8803e7b1d2a727f4023456bbbbe74da67099c585258af0ad9c5013b9b99"
+checksum = "d78c8dee4c7bf0e14673097256fed6142ce9d3b85a408189d07482442145823b"
 dependencies = [
  "proc-macro2",
  "quote",
@@ -1193,9 +1135,9 @@ dependencies = [
 
 [[package]]
 name = "tar"
-version = "0.4.45"
+version = "0.4.46"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "22692a6476a21fa75fdfc11d452fda482af402c008cdbaf3476414e122040973"
+checksum = "3f6221d9a6003c78398e3b239969f352578258df48c8eb051caadae0015bc840"
 dependencies = [
  "filetime",
  "libc",
@@ -1209,10 +1151,10 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
 dependencies = [
  "fastrand",
- "getrandom 0.4.1",
+ "getrandom 0.4.3",
  "once_cell",
- "rustix 1.1.4",
- "windows-sys 0.61.2",
+ "rustix",
+ "windows-sys",
 ]
 
 [[package]]
@@ -1226,11 +1168,11 @@ dependencies = [
 
 [[package]]
 name = "thiserror"
-version = "2.0.18"
+version = "2.0.21"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
+checksum = "09e52cb86a36cede5cb101bf8908837b3e4c6e5e59fe7fd85c23fb56200d189e"
 dependencies = [
- "thiserror-impl 2.0.18",
+ "thiserror-impl 2.0.21",
 ]
 
 [[package]]
@@ -1241,18 +1183,18 @@ checksum = "4fee6c4efc90059e10f81e6d42c60a18f76588c3d74cb83a0b242a2b6c7504c1"
 dependencies = [
  "proc-macro2",
  "quote",
- "syn",
+ "syn 2.0.119",
 ]
 
 [[package]]
 name = "thiserror-impl"
-version = "2.0.18"
+version = "2.0.21"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
+checksum = "fe5197923287db20a58125f0bc85c062f7f2c892de97b18c356f9efb14b28524"
 dependencies = [
  "proc-macro2",
  "quote",
- "syn",
+ "syn 3.0.9",
 ]
 
 [[package]]
@@ -1267,21 +1209,15 @@ dependencies = [
 
 [[package]]
 name = "typenum"
-version = "1.19.0"
+version = "1.20.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
+checksum = "b6f5e870be6c3b371b77fe0ee0bafb859fa4964b4404c27de1d380043c4dda20"
 
 [[package]]
 name = "unicode-ident"
-version = "1.0.24"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
-
-[[package]]
-name = "unicode-xid"
-version = "0.2.6"
+version = "1.0.27"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853"
+checksum = "a2c754d6c33795a1c324727428e5a7dedb5b06195f9890bdbcba760d3e246563"
 
 [[package]]
 name = "utf8parse"
@@ -1305,34 +1241,20 @@ dependencies = [
  "winapi-util",
 ]
 
-[[package]]
-name = "wasi"
-version = "0.11.0+wasi-snapshot-preview1"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-
 [[package]]
 name = "wasip2"
 version = "1.0.1+wasi-0.2.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "0562428422c63773dad2c345a1882263bbf4d65cf3f42e90921f787ef5ad58e7"
 dependencies = [
- "wit-bindgen 0.46.0",
-]
-
-[[package]]
-name = "wasip3"
-version = "0.4.0+wasi-0.3.0-rc-2026-01-06"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5428f8bf88ea5ddc08faddef2ac4a67e390b88186c703ce6dbd955e1c145aca5"
-dependencies = [
- "wit-bindgen 0.51.0",
+ "wit-bindgen",
 ]
 
 [[package]]
 name = "wasm-bindgen"
-version = "0.2.117"
+version = "0.2.129"
 source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9bb54f33acc68fd454578d9820b0bde1a1a3d17aa17bb7b6595806d02886d409"
 dependencies = [
  "cfg-if",
  "once_cell",
@@ -1343,8 +1265,9 @@ dependencies = [
 
 [[package]]
 name = "wasm-bindgen-macro"
-version = "0.2.117"
+version = "0.2.129"
 source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2e29d0c35b16e224a7eeb5cd2d25e3e1968fbd65604117b44d3b789d00ee8535"
 dependencies = [
  "quote",
  "wasm-bindgen-macro-support",
@@ -1352,62 +1275,31 @@ dependencies = [
 
 [[package]]
 name = "wasm-bindgen-macro-support"
-version = "0.2.117"
+version = "0.2.129"
 source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "6f501a8bc3719dba86ef8ae4728879c08001bea749eb1333ac5b91e040e2a6b7"
 dependencies = [
  "bumpalo",
  "proc-macro2",
  "quote",
- "syn",
+ "syn 3.0.9",
  "wasm-bindgen-shared",
 ]
 
 [[package]]
 name = "wasm-bindgen-shared"
-version = "0.2.117"
+version = "0.2.129"
 source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "23f0c9c52aa7cd7d77769a4cfe2a9adb1b331f489a41d912ce14513d5ab995c6"
 dependencies = [
  "unicode-ident",
 ]
 
-[[package]]
-name = "wasm-encoder"
-version = "0.244.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "990065f2fe63003fe337b932cfb5e3b80e0b4d0f5ff650e6985b1048f62c8319"
-dependencies = [
- "leb128fmt",
- "wasmparser",
-]
-
-[[package]]
-name = "wasm-metadata"
-version = "0.244.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "bb0e353e6a2fbdc176932bbaab493762eb1255a7900fe0fea1a2f96c296cc909"
-dependencies = [
- "anyhow",
- "indexmap",
- "wasm-encoder",
- "wasmparser",
-]
-
-[[package]]
-name = "wasmparser"
-version = "0.244.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "47b807c72e1bac69382b3a6fb3dbe8ea4c0ed87ff5629b8685ae6b9a611028fe"
-dependencies = [
- "bitflags",
- "hashbrown 0.15.5",
- "indexmap",
- "semver",
-]
-
 [[package]]
 name = "web-sys"
-version = "0.3.94"
+version = "0.3.106"
 source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "88261b9deccee56594c11a3460c462c41f58d148598fe70ad77070126a68aba4"
 dependencies = [
  "js-sys",
  "wasm-bindgen",
@@ -1435,7 +1327,7 @@ version = "0.1.11"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
 dependencies = [
- "windows-sys 0.61.2",
+ "windows-sys",
 ]
 
 [[package]]
@@ -1450,24 +1342,6 @@ version = "0.2.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
 
-[[package]]
-name = "windows-sys"
-version = "0.48.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
-dependencies = [
- "windows-targets 0.48.5",
-]
-
-[[package]]
-name = "windows-sys"
-version = "0.59.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
-dependencies = [
- "windows-targets 0.52.6",
-]
-
 [[package]]
 name = "windows-sys"
 version = "0.61.2"
@@ -1477,221 +1351,12 @@ dependencies = [
  "windows-link",
 ]
 
-[[package]]
-name = "windows-targets"
-version = "0.48.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
-dependencies = [
- "windows_aarch64_gnullvm 0.48.5",
- "windows_aarch64_msvc 0.48.5",
- "windows_i686_gnu 0.48.5",
- "windows_i686_msvc 0.48.5",
- "windows_x86_64_gnu 0.48.5",
- "windows_x86_64_gnullvm 0.48.5",
- "windows_x86_64_msvc 0.48.5",
-]
-
-[[package]]
-name = "windows-targets"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
-dependencies = [
- "windows_aarch64_gnullvm 0.52.6",
- "windows_aarch64_msvc 0.52.6",
- "windows_i686_gnu 0.52.6",
- "windows_i686_gnullvm",
- "windows_i686_msvc 0.52.6",
- "windows_x86_64_gnu 0.52.6",
- "windows_x86_64_gnullvm 0.52.6",
- "windows_x86_64_msvc 0.52.6",
-]
-
-[[package]]
-name = "windows_aarch64_gnullvm"
-version = "0.48.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "2b38e32f0abccf9987a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
-
-[[package]]
-name = "windows_aarch64_gnullvm"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
-
-[[package]]
-name = "windows_aarch64_msvc"
-version = "0.48.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "dc35310971f3b2dbbf3f0690a219f40e2d9afcf64f9ab7cc1be722937c26b4bc"
-
-[[package]]
-name = "windows_aarch64_msvc"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
-
-[[package]]
-name = "windows_i686_gnu"
-version = "0.48.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "a75915e7def60c94dcef72200b9a8e58e5091744960da64ec734a6c6e9b3743e"
-
-[[package]]
-name = "windows_i686_gnu"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
-
-[[package]]
-name = "windows_i686_gnullvm"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
-
-[[package]]
-name = "windows_i686_msvc"
-version = "0.48.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "8f55c233f70c4b27f66c523580f78f1004e8b5a8b659e05a4eb49d4166cca406"
-
-[[package]]
-name = "windows_i686_msvc"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
-
-[[package]]
-name = "windows_x86_64_gnu"
-version = "0.48.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "53d40abd2583d23e4718fddf1ebec84dbff8381c07cae67ff7768bbf19c6718e"
-
-[[package]]
-name = "windows_x86_64_gnu"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
-
-[[package]]
-name = "windows_x86_64_gnullvm"
-version = "0.48.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0b7b52767868a23d5bab768e390dc5f5c55825b6d30b86c844ff2dc7414044cc"
-
-[[package]]
-name = "windows_x86_64_gnullvm"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
-
-[[package]]
-name = "windows_x86_64_msvc"
-version = "0.48.5"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
-
-[[package]]
-name = "windows_x86_64_msvc"
-version = "0.52.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-
 [[package]]
 name = "wit-bindgen"
 version = "0.46.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "f17a85883d4e6d00e8a97c586de764dabcc06133f7f1d55dce5cdc070ad7fe59"
 
-[[package]]
-name = "wit-bindgen"
-version = "0.51.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
-dependencies = [
- "wit-bindgen-rust-macro",
-]
-
-[[package]]
-name = "wit-bindgen-core"
-version = "0.51.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ea61de684c3ea68cb082b7a88508a8b27fcc8b797d738bfc99a82facf1d752dc"
-dependencies = [
- "anyhow",
- "heck",
- "wit-parser",
-]
-
-[[package]]
-name = "wit-bindgen-rust"
-version = "0.51.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b7c566e0f4b284dd6561c786d9cb0142da491f46a9fbed79ea69cdad5db17f21"
-dependencies = [
- "anyhow",
- "heck",
- "indexmap",
- "prettyplease",
- "syn",
- "wasm-metadata",
- "wit-bindgen-core",
- "wit-component",
-]
-
-[[package]]
-name = "wit-bindgen-rust-macro"
-version = "0.51.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0c0f9bfd77e6a48eccf51359e3ae77140a7f50b1e2ebfe62422d8afdaffab17a"
-dependencies = [
- "anyhow",
- "prettyplease",
- "proc-macro2",
- "quote",
- "syn",
- "wit-bindgen-core",
- "wit-bindgen-rust",
-]
-
-[[package]]
-name = "wit-component"
-version = "0.244.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "9d66ea20e9553b30172b5e831994e35fbde2d165325bec84fc43dbf6f4eb9cb2"
-dependencies = [
- "anyhow",
- "bitflags",
- "indexmap",
- "log",
- "serde",
- "serde_derive",
- "serde_json",
- "wasm-encoder",
- "wasm-metadata",
- "wasmparser",
- "wit-parser",
-]
-
-[[package]]
-name = "wit-parser"
-version = "0.244.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ecc8ac4bc1dc3381b7f59c34f00b67e18f910c2c0f50015669dde7def656a736"
-dependencies = [
- "anyhow",
- "id-arena",
- "indexmap",
- "log",
- "semver",
- "serde",
- "serde_derive",
- "serde_json",
- "unicode-xid",
- "wasmparser",
-]
-
 [[package]]
 name = "xattr"
 version = "1.6.1"
@@ -1699,27 +1364,27 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "32e45ad4206f6d2479085147f02bc2ef834ac85886624a23575ae137c8aa8156"
 dependencies = [
  "libc",
- "rustix 1.1.4",
+ "rustix",
 ]
 
 [[package]]
 name = "zerocopy"
-version = "0.8.31"
+version = "0.8.63"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "fd74ec98b9250adb3ca554bdde269adf631549f51d8a8f8f0a10b50f1cb298c3"
+checksum = "e5fe1f8f1b06191a00962174c61aa5005e0bb391a6d80d07e24d115c01a92ed8"
 dependencies = [
  "zerocopy-derive",
 ]
 
 [[package]]
 name = "zerocopy-derive"
-version = "0.8.31"
+version = "0.8.63"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d8a8d209fdf45cf5138cbb5a506f6b52522a25afccc534d1475dad8e31105c6a"
+checksum = "863ad3ac83293fb4d740aedbfdc9240dd8d1a50c1099acd76ce80ce7c7230c7f"
 dependencies = [
  "proc-macro2",
  "quote",
- "syn",
+ "syn 2.0.119",
 ]
 
 [[package]]
@@ -1738,27 +1403,25 @@ dependencies = [
 
 [[package]]
 name = "zlib-rs"
-version = "0.6.2"
+version = "0.6.8"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c745c48e1007337ed136dc99df34128b9faa6ed542d80a1c673cf55a6d7236c8"
+checksum = "b268e58e7c693d7c271f93ffc4ba3b380412554231c85bf61ca7af91042a4112"
 
 [[package]]
 name = "zmij"
-version = "1.0.21"
+version = "1.0.23"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
+checksum = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
 
 [[package]]
 name = "zopfli"
-version = "0.8.1"
+version = "0.8.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e5019f391bac5cf252e93bbcc53d039ffd62c7bfb7c150414d61369afe57e946"
+checksum = "f05cd8797d63865425ff89b5c4a48804f35ba0ce8d125800027ad6017d2b5249"
 dependencies = [
  "bumpalo",
  "crc32fast",
- "lockfree-object-pool",
  "log",
- "once_cell",
  "simd-adler32",
 ]
 
@@ -1773,18 +1436,18 @@ dependencies = [
 
 [[package]]
 name = "zstd-safe"
-version = "7.2.4"
+version = "7.3.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "8f49c4d5f0abb602a93fb8736af2a4f4dd9512e36f7f570d66e65ff867ed3b9d"
+checksum = "64d80649ab6db9d9f6f9c80a40becd948eda4714a0a5ac8c4d157a32231c7882"
 dependencies = [
  "zstd-sys",
 ]
 
 [[package]]
 name = "zstd-sys"
-version = "2.0.16+zstd.1.5.7"
+version = "2.1.2+zstd.1.5.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "91e19ebc2adc8f83e43039e79776e3fda8ca919132d68a1fed6a5faca2683748"
+checksum = "481ada9c543b2323cbb7bbdbb5249177fbf0188ed959ed2c15e4b22421c84ed3"
 dependencies = [
  "cc",
  "pkg-config",
