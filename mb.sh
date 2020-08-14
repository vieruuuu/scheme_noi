html-minifier  --collapse-boolean-attributes --collapse-inline-tag-whitespace --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --use-short-doctype --minify-css true --minify-js true --input-dir ./src/lib/components --file-ext html --output-dir ./tmp/components 
nim c -f -d:isProd=true -d:release -d:danger --opt:size --passC:-flto -o:./dist/master.exe ./src/master.nim
strip -s ./dist/master.exe
