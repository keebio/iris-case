3D Print Iris Keyboard Case 
===========================

This is the source code for a 3D printable case for the [Iris keyboard](https://keeb.io/products/iris-keyboard-split-ergonomic-keyboard).
![Alt text](/3d-print-case/readme-images/case-exploded.png?raw=true "Iris case (exploded)")

The 3D print case supports many different combinations of options, and including generated files for all of them would bloat the size of this repository. Because of this, the source file and instructions for generating the STLs are provided in this document.

What's supported
----------------
This case does not support all configuration options for the Iris. If you would like to add any of the missing features, the source code for the case is available in this repo. Please contribute your changes back once they are tested.

### Supported
- Iris 2.7 and earlier PCB
- MX compatible switches
- 1u thumb keys 
- 2u thumb keys
- PCB mount stabilizers (both clip and screw-in)
- TRRS cables < 10mm in diameter (6.5mm recommended)
- Micro USB pro-micro
- Elite-C controller

### Unsupported
- Iris 3.0 PCB
- Alps switches
- Low profile switches
- DIP sockets
- Plate-mount stabilizers
- Threaded screw inserts

How to generate STL files from this project
-------------------------------------------
1. Install [OpenSCAD](http://www.openscad.org/)
2. Download `iris_case.scad` from this repository and open it using OpenSCAD
3. Configure the options you want in iris_case.scad
    - Please see the **User configurable options** section for details
4. For each of the four case parts:
    1. Update `selector` to the correct value for that case part
    2. Click the render button in the top bar (cube with an hour glass icon)
    3. Wait for the case to render (this may take a few minutes)
    4. Click the export button (labeled STL) in the top bar to export the STL

### User configurable options
- **two_unit_thumb**
    - If `false`, two 1u switch cutouts are generated on the diagonal thumb section
    - If `true`, a single centered cutout for a 2u thumb key is generated
- **stabilizers**
    - `stabilizers` only has an effect when using a 2u thumb key
    - If `false`, PCB stabilizer cutouts are not generated
    - If `true`, stabilizer cutous are generated for the 2u thumb key
- **usb_c_pro_micro**
    - If `false`, USB cutout is shaped for micro-USB
    - If `true`, USB cutout is shaped for USB-C
- **trrs_diameter**
    - The way the Iris PCB is designed, the left-side TRRS cable is extremely 
close to the edge of the PCB. Since the case must be wider than the PCB, 
this can cause the case to interfere with TRRS cables that have a diameter 
larger than 6.55 millimeters. 
    - Increasing `trrs_diameter` will add a divot into the side of the case 
to accomodate larger cables. This can make the wall section near the cable too thin and compromise 
the print quality (although it will be covered up by the larger cable). A 
smaller sized cable is the recommended solution.
- **selector**
    - `selector` controls which part of the case is generated. To generate the full case, each part must be selected separately, rendered, then exported.
    - If `1`, top left
    - If `2`, bottom left
    - If `3`, top right
    - If `4`, bottom right
    - If `5`, Top and bottom left hand
    - If `6`, Top and bottom right hand

Case assembly
-------------
The [Iris build guide](https://docs.keeb.io/iris-build-guide/) still applies to the assembly process, with a few additional callouts:
- This case was designed to use M3 screws that are 8mm long. The screw shaft will pass freely through the holes in the bottom layer, and will bind into the plastic of the top layer. 
    - Using screws longer than 8mm (threads longer than 6mm) may deform the top layer if they are fully screwed in.
- After soldering the switches, the pro-micro must be positioned so that the USB connector is within the cutout of the top layer, and must be leveled so that the USB connector is not at an angle.
    - Inserting a small amount of material (like paper) under the end opposite the USB until the first solder points are done can help level the connector until it's fixed in place by solder.
- If you're using stabilizers, be sure to install them before soldering the switches. Because the 3D print case fully encloses the top half of the PCB, it's not possible possible to install them later without desoldering.
    - Screw-in stabilizers are recommended because the snap-in variety can sometimes come unseated when removing keycaps, which is hard to fix for the same reason.

Fabrication
-----------

### FDM Printing
This case is designed for printing on consumer grade FDM printers. These printers are the most common variety owned by hobbyists, schools, libraries, and maker spaces.

Many printing materials will work, but the case has been designed and tested using PLA.

### Shapeways
[Shapeways](https://www.shapeways.com) is a 3D printing company that will produce your model and mail it to you. Their services are significantly more expensive than producing the case yourself, but they are an option if you don't have access to a 3D printer, or if you want an especially high quality print.


Shapeways' "Strong and Flexible" plastic is recommended for printing this case.
