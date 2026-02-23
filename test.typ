#for (i, variation) in (
  "lundmx-bw",  "bw", "bw-square", "mini-bw", "blue-on-white", "light-blue", "ldmx-sw",
  "white-on-transparent", "umn", "ucsb", "stanford", "eg-all"
).enumerate() {
  if i > 0 { pagebreak() }
  include "variations/"+variation+".typ"
}
