#for (i, variation) in (
  "bw", "mini-bw", "blue-on-white", "light-blue", "ldmx-sw", "umn", "eg-all"
).enumerate() {
  if i > 0 { pagebreak() }
  include "variations/"+variation+".typ"
}
