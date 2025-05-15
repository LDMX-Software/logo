# LDMX Logo Source Code
Source code for creating the LDMX logo with [Typst](https://typst.app/docs/).

## Credit
- Orignal black+white design by Nhan Tran? (or Omar Moreno? or Natalia Toro?)
- Using the [Aileron](https://www.fontsquirrel.com/fonts/aileron?filter%5Bfamily_size%5D=12) font

## Set Up

#### Install `typst`
There are a bunch of ways to do this, so I'm just going to refer you to
[their installation documentation](https://github.com/typst/typst?tab=readme-ov-file#installation).

#### Install Aileron Font
```
just install-fonts
```

## Development
```
just watch
```
This will compile (and re-compile) `test.typ` as you edit it or `logo.typ` and produce
the multi-page `test.pdf` where each page is a different version of the logo.
I would suggest opening `test.pdf` with "Continuous Mode" in your PDF viewer so you can
see multiple logo versions at once.

### Adding a New Variation
There are a few examples already in the [variations](variations) directory,
so that should get you started. Please also include your variation in [test.typ](test.typ)
so that it can be rendered with the others while the parent function is being developed.

## Usage
You can print a PDF, PNG, or SVG of any of the variations in [variations](variations) with
```
just print-{pdf,png,svg} <variation>
```
The output is written into a file of the same name but with a different extension.

## Implementation
Specifically, I am using the Typst package [fletcher](https://typst.app/universe/package/fletcher/)
to create this logo as a "diagram". flecter uses [CeTZ](https://typst.app/universe/package/cetz/)
under-the-hood so that might be helpful for more fine-tuning as well.
