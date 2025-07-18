_default:
    @just --list --justfile {{ justfile() }}

aileron_url := "https://www.fontsquirrel.com/fonts/download/aileron"

_install_font URL:
    #!/bin/sh
    set -o errexit
    set -o nounset
    dir=$(mktemp -d)
    wget -O "${dir}/font.zip" "{{ URL }}"
    mkdir -p fonts
    cd fonts
    unzip "${dir}/font.zip"
    rm -r "${dir}"

# install necessary fonts into 'fonts/' directory
install-fonts: (_install_font aileron_url)

fonts_path := source_directory() / "fonts"
typst_args := "--font-path " + fonts_path +  " --root " + source_directory() 

# generic typst command with additional font path
typst CMD *ARGS:
    typst {{ CMD }} {{ typst_args }} {{ ARGS }} 

# watch the testing file while developing
watch *ARGS: (typst "watch" "test.typ" ARGS)

# private print to avoid repeating myself
_print variation *ARGS: (typst "compile" "variations/"+variation+".typ" ARGS)

# print a PDF logo
print-pdf variation="bw": (_print variation "--format=pdf")

# print a PNG logo
print-png variation="bw": (_print variation "--format png --ppi 300")

# print a SVG logo
print-svg variation="bw": (_print variation "--format svg")

# print all types of all variations
_print-all:
    #!/bin/bash
    set -o nounset
    set -o errexit
    for type in pdf png svg; do
      for varfile in variations/*.typ; do
        varname="$(basename --suffix=.typ "${varfile}")"
        just print-${type} ${varname}
      done
    done

# make a draft release with all the current variations built and attached
release: _print-all
    gh release create --draft --generate-notes "$(date +"%Y.%m.%d")" variations/*.png variations/*.pdf variations/*.svg
