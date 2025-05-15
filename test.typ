#for (i, variation) in (
  "umn", "bw", "mini-bw", "light-blue", "ldmx-sw", "eg-all"
).enumerate() {
  if i > 0 { pagebreak() }
  include "variations/"+variation+".typ"
}
