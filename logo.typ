#import "@preview/fletcher:0.5.7": *

/// create a single-page LDMX logo
///
/// text-color: type color, default white, color of all text objects in logo
/// bkgd-color: type color, default black, background color of logo
/// electron-color: type color, default to text-color, color of electron "beam" in logo
/// electron-ls: typ str, default to "-", line style for electron (e.g. solid is "-", dashed "--", dotted "..")
/// dm-color: type color, default to bkgd-color, color of produced DM tracks in logo
/// dm-text-color: type color, default to text-color, color of the letters D and M in LDMX in logo
/// prefix: extra text to include in front of LDMX
/// suffix: extra text to be included after LDMX
///
/// For prefix and suffix, if a string is provided, then some default formatting
/// is applied. You can customize this formatting by providing the content yourself
/// (like is done with the SW suffix in the ldmx-sw variation).
/// The default formatting for the prefix is 16pt font with light weight aligned
/// to the top so it is over the incoming beam (like in the umn and mini variations).
/// The default formatting for the suffix is 16pt font with light weight aligned
/// to the bottom.
#let logo(
  text-color: white,
  bkgd-color: black,
  electron-color: auto,
  electron-ls: "-",
  dm-color: auto,
  dm-text-color: auto,
  prefix: none,
  suffix: none
) = {

  // default dm color to bkgd color so that it "disappears"
  if dm-color == auto {
    dm-color = bkgd-color
  }

  // default DM text color to text color
  if dm-text-color == auto {
    dm-text-color = text-color
  }

  // default electron color to text color
  if electron-color == auto {
    electron-color = text-color
  }

  set text(font: "Aileron", fill: text-color)
  set page(height: auto, width: auto, margin: 0pt, fill: none)

  // magic number provided by
  // #context {
  //   measure(text(size:32pt)[L]).height
  // }
  // after choosing a font and a size
  let text-box-height = 22.08pt

  // other magic numbers I fiddle with to get the placements correct

  // shift of target point relative to the letter L so that the target
  // is in the vertical bar of the L
  // depends on the font and size
  let target-shift = (-0.45em, 0em)

  // point that electron should stop relative to target
  // ends in the upper left corner of the D as if the D is the calorimeters
  // depends on the font and size
  let beam-endpoint = (0.7cm, +0.35cm)

  // minimum prefix width so there is a horizontal line incident
  // on the target even if no prefix text is provided
  // depends on overall size
  let min-prefix-width = 0.25cm

  // angle of bend in electron beam so that it looks like its following
  // a circular trajectory after the target and into the Dcal
  // depends on beam-endpoint and target-shift
  let bend-angle = -28deg

  diagram(
    //debug: 3, // fletcher/CeTZ draw extra markings for nodes and coordinates
    spacing: 0pt, // have node bounding boxes immediately next to each other
    node-inset: 0pt, // no inset margin between interior bb and exterior bb
    node(
      (1,0),
      text(size: 32pt, weight: "thin")[L],
      shape: rect,
      name: <L>
    ),
    node(
      (0,0),
      if prefix == none [] else if type(prefix) == str {
        align(top + right, text(size: 16pt, weight: "light", prefix))
      } else {
        prefix
      },
      height: text-box-height,
      width: if prefix == none { min-prefix-width } else { auto },
      name: <prefix>
    ),
    node(
      (rel: target-shift, to: <L>),
      name: <target>
    ),
    node(
      pos: <prefix.west>,
      name: <beam-entry>
    ),
    node(
      (rel: beam-endpoint, to: <target>),
      name: <beam-exit>
    ),
    node(
      (2,0),
      shape: rect,
      text(size: 32pt, fill: dm-text-color, weight: "black")[DM],
      name: <DM>,
    ),
    node(
      (3,0),
      text(size: 32pt, weight: "thin")[X],
      name: <X>,
      shape: rect,
    ),
    node(
      (4,0),
      if type(suffix) == content or suffix == none {
        // assume user knows what they are doing
        suffix
      } else {
        // assume just a string and we should do our default
        align(bottom+left, text(size: 16pt, weight: "light", suffix))
      },
      name: <suffix>,
      shape: rect,
      height: text-box-height
    ),
    node(
      // intentionally not enclosing <beam-exit> so that the enclosing
      // box is vertically symmetric around the letters
      enclose: (<beam-entry>, <L>, <DM>, <X>, <suffix>),
      fill: bkgd-color,
      snap: -1,
      name: <LDMX-group>,
      inset: 5pt,
    ),
    edge(
      <beam-entry>, <target>, electron-ls, 
      stroke: electron-color + 1pt,
      layer: 2
    ),
    edge(
      <target>, <beam-exit>, electron-ls,
      stroke: electron-color + 1pt,
      bend: bend-angle,
      layer: 2
    ),
    node(
      (rel: (0em, -2pt), to: if suffix == none { <X.north-east> } else { <suffix.north-east> }),
      name: <dm-exit-top>
    ),
    node(
      (rel: (0em, +2pt), to: if suffix == none { <X.south-east> } else { <suffix.south-east> }),
      name: <dm-exit-bottom>
    ),
    edge(
      "-",
      vertices: (<target>, <dm-exit-bottom>),
      stroke: dm-color + 1pt,
      layer: 1
    ),
    edge(
      "-",
      vertices: (<target>, <dm-exit-top>),
      stroke: dm-color + 1pt,
      layer: 1
    ),
  )
}
