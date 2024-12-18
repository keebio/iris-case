Iris Keyboard Case
==================

Here's case design files for the [Iris](https://keeb.io/products/iris-keyboard-split-ergonomic-keyboard). It's a sandwich-style case with cutouts to accommodate the USB jack and the TRRS jack.


## Iris CE / Iris LM

Iris CE parts are in this repository: https://github.com/keebio/iris-ce-case

Iris LM parts are in this repository: https://github.com/keebio/iris-lm-case

Case pieces
-----------

The Iris sandwich case consists these pieces:

- Switch plate (Required)
- Bottom plate (Required)
- Middle layer (Optional)
- Top rim or Top shell (Optional)

### Case/Plate Versions

Before the release of the Iris Rev. 5 PCBs, the case parts for Rev. 3 & 4 used the same parts. However, with the release of Rev. 5-7 PCBs, the screw holes needed to be relocated to accomodate the wider USB-C port used for interconnect. Therefore, new case parts needed to be made to support the newer PCBs.

The newer case parts are called [Phoenix Edition (PE)](phoenix-edition-PE/), while the older Iris parts are now called [Legacy Edition (LE)](legacy-edition-LE).

Phoenix Edition parts and Legacy Edition parts are not compatible with each other due to the different placement of screw holes.

PE parts are compatible with Rev. 3 through 7 PCBs.

LE parts are compatible with Rev. 3 & 4 PCBs.

See additional info about Legacy Edition files in its [README](legacy-edition-LE/README.md).

Iris PE (Phoenix Edition) Parts
-------------------------------
### 3D-print STL files

For the 3D-print STL files, there are two sets of files, ones for the top shell, and ones for the middle layer. For each of these sets, there are different files based on how thick your plates are. If you have the FR4 plates or Stainless steel plates, then use the files for 1.5mm plate. If you are using 3mm acrylic plates, then use the files for the 3mm plate.

For the middle layer files for 1.5mm plates, there are two sets of files: one with a lip and one without a lip. The "lip" refers to the portion of the middle layer that extends past the standoffs and covers the sides of the 1.5mm plate, to hide the edges from view. The "No Lip" version may be more desirable for you to use if you are not using a top shell.

If you are using the top shells, you will need to use longer M2 screws, as the top shell has been designed to be threaded into directly from underneath. For 1.5mm plates, you will need [18mm screws](https://keeb.io/products/m2-screws-and-standoffs), and for 3mm plates, you will need 22mm screws.

If you choose to print the ErgoDox-style tenting legs, you will need six M3 screws (at least 16mm) and six M3 nuts. The legs and washers are best printed at 0.16mm quality or better.

Additional notes
----------------

Some of the files only have a left half, just mirror the file to produce a right half if needed.

Design info
-----------

A lot of these files have been derived from the following file: [iris-plate-design.ai](references/iris-plate-design.ai). By toggling various layers in that file, you can see various info on switch cutouts, screw holes, inner/outer edges, etc.

Screws and Standoffs
--------------------

This case was designed to use M2 screws and standoffs. The holes in the middle layers are for the standoffs, while the holes in the top and bottom layers are only wide enough for the screws. M2 screws and standoffs that fit the case can be purchased at Keebio: [M2 Screws & Standoffs](https://keeb.io/products/m2-screws-and-standoffs)

Fabrication of Acrylic Parts
----------------------------

### Places to go

- [Sculpteo](https://www.sculpteo.com)
- [Ponoko](https://www.ponoko.com)

### Middle Layer Thickness
If you're having the middle layers made, from the top of the switch plate to the top of the bottom plate, the minimum distance between the two required is 12mm if the plastic on the header pins is removed. The requirement is slightly more (about 13.5mm) if you leave the plastic on. Therefore, the following middle layer thickness are needed based on the thickness of the switch layer:

- 1.5mm Stainless steel switch plate: 10.5mm
    - Usually accomplished with:
        - 2x4.5mm + 1x1.5mm layers
        - or 3x3mm + 1x1.5mm layers
        - or 4x3mm layers
- 3mm acrylic switch plate: 9mm
    - Usually accomplished with:
        - 2x4.5mm layers
        - or 3x3mm layers

STL Files for 3D printing
-------------------------
A couple of STL files have also been included for the middle layers and are both single pieces. They are designed for the left half, so to get the right half, you will need to flip them within your slicer software.

One version allows the Ergodox EZ legs to be used with it. In addition to the legs, you'll need M3 nuts to allow the legs screws to screw into.

Community-Made Files
--------------------
Files not designed by Keebio are placed into the [community-made](community-made/) folder and also includes links to other designs not hosted in this repository.

License
-------
These case files are released under the MIT License.
