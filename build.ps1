if (Test-Path ./dest) {
    Remove-Item ./dest -Recurse 
}
mkdir ./dest/src
Copy-Item ./src/lib.typ -Destination ./dest/src
Copy-Item ./src/era-map.json -Destination ./dest/src
Copy-Item ./exports.typ -Destination ./dest
