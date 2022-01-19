from solid import *
from solid.utils import *  # Not required, but the utils module is useful

scadfile = import_scad('arch.scad')
b = scadfile.box(2,4,6)
scad_render_to_file(b, 'out_file.scad')