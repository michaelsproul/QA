# Determine the appropriate arch to install
if ($env:PLATFORM -eq "x86") {
    $arch = "i686"
} else {
    $arch = "x86_64"
}

# Download Rust installer
$url = "https://github.com/rust-lang-nursery/multirust-rs-binaries/raw/master/$arch-pc-windows-gnu/multirust-setup.exe"
$installer = $env:TEMP + "\multirust-rs.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $installer)

# Install MultiRust
$input_file = $env:TEMP + "\input.txt"
Set-Content $input_file "y`r`ny`r`n"
Start-Process $installer -Wait -NoNewWindow -RedirectStandardInput $input_file

# Add MultiRust to path
$env:Path = $env:USERPROFILE + "\.cargo\bin;" + $env:Path

# Set the requested channel and install nightly
# multirust update nightly
multirust default $env:RUST_VERSION

"Rust version:"
""
rustc -vV
if (!$?) {
    exit 99
}
""
""

"Cargo version:"
""
cargo -V
if (!$?) {
    exit 99
}
""
""
