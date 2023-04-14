export def build-dpd [] {
  OSTYPE=linux-gnu tools/ci_download_dendrite_stub

  cd ../dendrite
  cargo build -p dpd --features tofino_stub --release
  cargo build -p swadm --release
  cp target/release/dpd ../omicron/out/dendrite-stub/bin/dpd
  cp target/release/swadm ../omicron/out/dendrite-stub/bin/swadm
  cd ../omicron
}