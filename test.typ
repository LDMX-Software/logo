#for (i, variation) in (
  "bw", "bw-square", "mini-bw", "blue-on-white", "light-blue", "ldmx-sw",
  "white-on-transparent", "umn", "ucsb", "eg-all"
).enumerate() {
  if i > 0 { pagebreak() }
  include "variations/"+variation+".typ"
}
