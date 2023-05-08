export def build-dpd [] {
  OSTYPE=linux-gnu tools/ci_download_dendrite_stub

  let-env BIN_DIR = "/Users/just-be/Oxide/omicron/out/dendrite-stub/root/opt/oxide/dendrite/bin"

  cd /Users/just-be/Oxide/dendrite
  git pull
  cargo build -p dpd --features tofino_stub --release
  cargo build -p swadm --release
  cp target/release/dpd $"($env.BIN_DIR)/dpd"
  cp target/release/swadm $"($env.BIN_DIR)/swadm"
  cd ../omicron
}