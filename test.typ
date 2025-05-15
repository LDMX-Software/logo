#for (i, variation) in (
  "bw", "mini-bw", "light-blue", "ldmx-sw", "umn", "eg-all"
).enumerate() {
  if i > 0 { pagebreak() }
  include "variations/"+variation+".typ"
}
