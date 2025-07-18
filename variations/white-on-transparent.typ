// white on transparent is a helpful logo for putting
// on other objects e.g. circuit boards
// this logo only really makes sense as a PNG or SVG
// where the background is acknowledged as potentially undefined
#import "/logo.typ" : logo
#logo(bkgd-color: none, dm-color: white.transparentize(100%))
