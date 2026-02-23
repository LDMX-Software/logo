# LDMX Logo Source Code
Source code for creating the LDMX logo with [Typst](https://typst.app/docs/).

## Credit
- Orignal black+white design by Nhan Tran, available as PDF and in Keynote on [LDMX DocDB #5808](https://projects-docdb.fnal.gov/cgi-bin/private/ShowDocument?docid=5808)
- Using the [Aileron](https://www.fontsquirrel.com/fonts/aileron?filter%5Bfamily_size%5D=12) font

## Set Up

#### Install `just`
`just` is used to share common recipes similar to how we use it [for ldmx-sw development](https://ldmx-software.github.io/developing/getting-started.html#install-just).

#### Install `typst`
There are a bunch of ways to do this, so I'm just going to refer you to
[their installation documentation](https://github.com/typst/typst?tab=readme-ov-file#installation).

#### Install Aileron Font
- Download [Aileron Font](https://www.fontsquirrel.com/fonts/download/aileron)
- Install into this repo for development
```
just install-font path/to/aileron.zip
```

#### Install tytanic (Development)
If you wish to develop the central `logo.typ` file (to add some additional feature
for example), please [install tytanic](https://typst-community.github.io/tytanic/quickstart/install.html)
which is used here to organize the different variations and make sure edits to
the `logo.typ` file do not alter variations already in use (or at least we know
that the logo has changed).

## Development
- Start a new template logo variation with `just new-variation NAME`
- Edit the file template now located at `tests/NAME/test.typ`
- Update the test reference with `just tt update`
  - View the logo at `tests/NAME/ref/1.png`
- `git add tests/NAME` when you are happy with the new logo variation

The other "tests" are just the other logo variations and should always "pass"
unless you are editing `logo.typ` itself. Edits to `logo.typ` that change
the logo variations should be considered breaking changes and should be
done with care.

## Usage
You can print a PDF, PNG, or SVG of [any of the variations](tests) with
```
just print-{pdf,png,svg} <variation>
```
The output is written into a file of the same name (but with the correct extension)
in the `variations` directory.

## Implementation
Specifically, I am using the Typst package [fletcher](https://typst.app/universe/package/fletcher/)
to create this logo as a "diagram". flecter uses [CeTZ](https://typst.app/universe/package/cetz/)
under-the-hood so that might be helpful for more fine-tuning as well.
