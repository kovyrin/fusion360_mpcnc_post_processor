/* eslint-disable no-undef */
/*

https://github.com/kovyrin/mpcnc_posts_processor

MPCNC posts processor for milling and laser/plasma cutting.

*/

description = "MPCNC - Marlin 2.0";
vendor = "Oleksiy Kovyrin";
vendorUrl = "https://github.com/kovyrin/mpcnc_posts_processor";
certificationLevel = 2;

longDescription = "MPCNC post based on the DIYCNC post by martindb."

extension = "gcode";
setCodePage("ascii");

capabilities = CAPABILITY_MILLING | CAPABILITY_JET;

// Arc support variables
minimumChordLength = spatial(0.01, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(180);
allowHelicalMoves = false;
allowedCircularPlanes = undefined;

//-------------------------------------------------------------------------------------------------
// user-defined properties
properties = {
    jobMarlinEnforceFeedrate: {
      title: "Job: Enforce Feedrate",
      description: "Add feedrate to each movement g-code",
      group: 1,
      type: "boolean",
      value: false,
    },
  
    jobTravelSpeedXY: {
      title: "Job: Travel speed X/Y",
      description: "High speed for travel movements X & Y (mm/min)",
      group: 1,
      type: "spatial",
      value: 2500,
    },
  
    jobTravelSpeedZ: {
      title: "Job: Travel Speed Z",
      description: "High speed for travel movements z (mm/min)",
      group: 1,
      type: "spatial",
      value: 300,
    },
  
    jobManualSpindlePowerControl: {
      title: "Job: Manual Spindle On/Off",
      description:
        "Set Yes when your spindle motor is controlled by manual switch",
      group: 1,
      type: "boolean",
      value: false,
    },
  
    jobUseArcs: {
      title: "Job: Use Arcs",
      description: "Use G2/G3 g-codes fo circular movements",
      group: 1,
      type: "boolean",
      value: true,
    },
  
    jobSetOriginOnStart: {
      title: "Job: Reset on start (G92)",
      description: "Set origin when gcode start (G92)",
      group: 1,
      type: "boolean",
      value: false,
    },
  
    jobGoOriginOnFinish: {
      title: "Job: Goto 0 at end",
      description: "Go X0 Y0 at gcode end",
      group: 1,
      type: "boolean",
      value: true,
    },
  
    jobSequenceNumbers: {
      title: "Job: Line numbers",
      description: "Show sequence numbers",
      group: 1,
      type: "boolean",
      value: true,
    },
  
    jobSequenceNumberStart: {
      title: "Job: Line start",
      description: "First sequence number",
      group: 1,
      type: "integer",
      value: 10,
    },
  
    jobSequenceNumberIncrement: {
      title: "Job: Line increment",
      description: "Lncrement for sequence numbers",
      group: 1,
      type: "integer",
      value: 1,
    },
  
    jobSeparateWordsWithSpace: {
      title: "Job: Separate words",
      description:
        "Specifies that the words should be separated with a white space",
      group: 1,
      type: "boolean",
      value: true,
    },
    
    toolChangeEnabled: {
      title: "Change: Enabled",
      description:
        "Enable tool change code (bultin tool change requires LCD display)",
      group: 2,
      type: "boolean",
      value: false,
    },
  
    toolChangeX: {
      title: "Change: X",
      description: "X position for builtin tool change",
      group: 2,
      type: "spatial",
      value: 0,
    },
  
    toolChangeY: {
      title: "Change: Y",
      description: "Y position for builtin tool change",
      group: 2,
      type: "spatial",
      value: 0,
    },
  
    toolChangeZ: {
      title: "Change: Z ",
      description: "Z position for builtin tool change",
      group: 2,
      type: "spatial",
      value: 40,
    },
  
    toolChangeZProbe: {
      title: "Change: Make Z Probe",
      description: "Z probe after tool change",
      group: 2,
      type: "boolean",
      value: true,
    },
  
    toolChangeDisableZStepper: {
      title: "Change: Disable Z stepper",
      description: "Disable Z stepper when change a tool",
      group: 2,
      type: "boolean",
      value: false,
    },
  
    probeOnStart: {
      title: "Probe: On job start",
      description: "Execute probe gcode on job start",
      group: 3,
      type: "boolean",
      value: false,
    },
  
    probeThickness: {
      title: "Probe: Plate thickness",
      description: "Plate thickness (mm)",
      group: 3,
      type: "spatial",
      value: 0.8,
    },
  
    probeUseHomeZ: {
      title: "Probe: Use Home Z",
      description: "Use G28 or G38 for probing",
      group: 3,
      type: "boolean",
      value: true,
    },
  
    probeG38Target: {
      title: "Probe: G38 target",
      description: "Probing up to Z position (mm)",
      group: 3,
      type: "spatial",
      value: -10,
    },
  
    probeG38Speed: {
      title: "Probe: G38 speed",
      description: "Probing with speed (mm/min)",
      group: 3,
      type: "spatial",
      value: 30,
    },
  
    cutterOnVaporize: {
      title: "Laser: On - Vaporize",
      description:
        "Persent of power to turn on the laser/plasma cutter in vaporize mode",
      group: 4,
      type: "number",
      value: 100,
    },
  
    cutterOnThrough: {
      title: "Laser: On - Through",
      description:
        "Persent of power to turn on the laser/plasma cutter in through mode",
      group: 4,
      type: "number",
      value: 80,
    },
  
    cutterOnEtch: {
      title: "Laser: On - Etch",
      description: "Persent of power to on the laser/plasma cutter in etch mode",
      group: 4,
      type: "number",
      value: 40,
    },
  
    cutterMarlinMode: {
      title: "Laser: Marlin/Reprap mode",
      description: "Marlin/Reprar mode of the laser/plasma cutter",
      group: 4,
      type: "integer",
      value: 106,
      values: [
        { title: "M106 S{PWM}/M107", id: 106 },
        { title: "M3 O{PWM}/M5", id: 3 },
        { title: "M42 P{pin} S{PWM}", id: 42 },
      ],
    },
  
    cutterMarlinPin: {
      title: "Laser: Marlin M42 pin",
      description: "Marlin custom pin number for the laser/plasma cutter",
      group: 4,
      type: "integer",
      value: 4,
    },
  
    cutterGrblMode: {
      title: "Laser: GRBL mode",
      description: "GRBL mode of the laser/plasma cutter",
      group: 4,
      type: "integer",
      value: 4,
      values: [
        { title: "M4 S{PWM}/M5 dynamic power", id: 4 },
        { title: "M3 S{PWM}/M5 static power", id: 3 },
      ],
    },
  
    gcodeStartFile: {
      title: "Extern: Start File",
      description: "File with custom Gcode for header/start (in nc folder)",
      group: 5,
      type: "file",
      value: "",
    },
  
    gcodeStopFile: {
      title: "Extern: Stop File",
      description: "File with custom Gcode for footer/end (in nc folder)",
      group: 5,
      type: "file",
      value: "",
    },
  
    gcodeToolFile: {
      title: "Extern: Tool File",
      description: "File with custom Gcode for tool change (in nc folder)",
      group: 5,
      type: "file",
      value: "",
    },
  
    gcodeProbeFile: {
      title: "Extern: Probe File",
      description: "File with custom Gcode for tool probe (in nc folder)",
      group: 5,
      type: "file",
      value: "",
    },
  
    coolantA_Mode: {
      title: "Coolant: A Mode",
      description: "Enable issuing g-codes for control Coolant channel A",
      group: 6,
      type: "integer",
      value: 0,
      values: [
        { title: "off", id: 0 },
        { title: "flood", id: 1 },
        { title: "mist", id: 2 },
        { title: "throughTool", id: 3 },
        { title: "air", id: 4 },
        { title: "airThroughTool", id: 5 },
        { title: "suction", id: 6 },
        { title: "floodMist", id: 7 },
        { title: "floodThroughTool", id: 8 },
      ],
    },
  
    coolantAMarlinOn: {
      title: "Coolant: A On command",
      description: "GCode command to turn on Coolant channel A",
      group: 6,
      type: "string",
      value: "M42 P11 S255",
    },
  
    coolantAMarlinOff: {
      title: "Coolant: A Off command",
      description: "Gcode command to turn off Coolant A",
      group: 6,
      type: "string",
      value: "M42 P11 S0",
    },
  
    coolantB_Mode: {
      title: "Coolant: B Mode",
      description: "Enable issuing g-codes for control Coolant channel B",
      group: 6,
      type: "integer",
      value: 0,
      values: [
        { title: "off", id: 0 },
        { title: "flood", id: 1 },
        { title: "mist", id: 2 },
        { title: "throughTool", id: 3 },
        { title: "air", id: 4 },
        { title: "airThroughTool", id: 5 },
        { title: "suction", id: 6 },
        { title: "floodMist", id: 7 },
        { title: "floodThroughTool", id: 8 },
      ],
    },
  
    coolantBMarlinOn: {
      title: "Coolant: B On command",
      description: "GCode command to turn on Coolant channel B",
      group: 6,
      type: "string",
      value: "M42 P6 S255",
    },
  
    coolantBMarlinOff: {
      title: "Coolant: B Off command",
      description: "Gcode command to turn off Coolant channel B",
      group: 6,
      type: "string",
      value: "M42 P6 S0",
    },
  
    commentWriteTools: {
      title: "Comment: Write Tools",
      description: "Write table of used tools in job header",
      group: 7,
      type: "boolean",
      value: true,
    },
  
    commentActivities: {
      title: "Comment: Activities",
      description:
        "Write comments which somehow helps to understand current piece of g-code",
      group: 7,
      type: "boolean",
      value: true,
    },
  
    commentSections: {
      title: "Comment: Sections",
      description: "Write header of every section",
      group: 7,
      type: "boolean",
      value: true,
    },
  
    commentCommands: {
      title: "Comment: Trace Commands",
      description: "Write stringified commands called by CAM",
      group: 7,
      type: "boolean",
      value: true,
    },
  
    commentMovements: {
      title: "Comment: Trace Movements",
      description: "Write stringified movements called by CAM",
      group: 7,
      type: "boolean",
      value: true,
    },  
  };
  
//-------------------------------------------------------------------------------------------------
// Formats
var gFormat = createFormat({ prefix: "G", decimals: 1 });
var mFormat = createFormat({ prefix: "M", decimals: 0 });

var xyzFormat = createFormat({ decimals: unit == MM ? 3 : 4 });
var xFormat = createFormat({ prefix: "X", decimals: unit == MM ? 3 : 4 });
var yFormat = createFormat({ prefix: "Y", decimals: unit == MM ? 3 : 4 });
var zFormat = createFormat({ prefix: "Z", decimals: unit == MM ? 3 : 4 });
var iFormat = createFormat({ prefix: "I", decimals: unit == MM ? 3 : 4 });
var jFormat = createFormat({ prefix: "J", decimals: unit == MM ? 3 : 4 });
var kFormat = createFormat({ prefix: "K", decimals: unit == MM ? 3 : 4 });

var speedFormat = createFormat({ decimals: 0 });
var sFormat = createFormat({ prefix: "S", decimals: 0 });

var pFormat = createFormat({ prefix: "P", decimals: 0 });
var oFormat = createFormat({ prefix: "O", decimals: 0 });

var feedFormat = createFormat({ decimals: unit == MM ? 0 : 2 });
var fFormat = createFormat({ prefix: "F", decimals: unit == MM ? 0 : 2 });

var toolFormat = createFormat({ decimals: 0 });
var tFormat = createFormat({ prefix: "T", decimals: 0 });

var taperFormat = createFormat({ decimals: 1, scale: DEG });
var secFormat = createFormat({ decimals: 3, forceDecimal: true }); // seconds - range 0.001-1000

// Linear outputs
var xOutput = createVariable({}, xFormat);
var yOutput = createVariable({}, yFormat);
var zOutput = createVariable({}, zFormat);
var fOutput = createVariable({}, fFormat);
var sOutput = createVariable({ force: true }, sFormat);

// Circular outputs
var iOutput = createReferenceVariable({}, iFormat);
var jOutput = createReferenceVariable({}, jFormat);
var kOutput = createReferenceVariable({}, kFormat);

// Modals
var gMotionModal = createModal({}, gFormat); // modal group 1 // G0-G3, ...
var gPlaneModal = createModal(
  {
    onchange: function () {
      gMotionModal.reset();
    },
  },
  gFormat
); // modal group 2 // G17-19
var gAbsIncModal = createModal({}, gFormat); // modal group 3 // G90-91
var gFeedModeModal = createModal({}, gFormat); // modal group 5 // G93-94
var gUnitModal = createModal({}, gFormat); // modal group 6 // G20-21

// Copied from the class init
gMotionModal = createModal({ force: true }, gFormat); // modal group 1 // G0-G3, ...
if (getProperty("jobMarlinEnforceFeedrate")) {
  fOutput = createVariable({ force: true }, fFormat);
}

//-------------------------------------------------------------------------------------------------
// collected state
var sequenceNumber;
var spindleEnabled = false;
var cutterOnCurrentPower;
var pendingRadiusCompensation = RADIUS_COMPENSATION_OFF;
var currentSpindleSpeed = 0;
var currentCoolantMode = 0;

// Called on waterjet/plasma/laser cuts
var powerState = false;

//-------------------------------------------------------------------------------------------------
// Writes the specified block.
function writeBlock() {
    if (getProperty("jobSequenceNumbers")) {
      writeWords2("N" + sequenceNumber, arguments);
      sequenceNumber += getProperty("jobSequenceNumberIncrement");
    } else {
      writeWords(arguments);
    }
  }

  //-------------------------------------------------------------------------------------------------
// Called in every new gcode file
function onOpen() {
    init();
  
    sequenceNumber = getProperty("jobSequenceNumberStart");
    if (!getProperty("jobSeparateWordsWithSpace")) {
      setWordSeparator("");
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  // Called at end of gcode file
  function onClose() {
    writeActivityComment(" *** STOP begin ***");
    flushMotions();
    if (getProperty("gcodeStopFile") == "") {
      onCommand(COMMAND_COOLANT_OFF);
      if (getProperty("jobGoOriginOnFinish")) {
        rapidMovementsXY(0, 0);
      }
      onCommand(COMMAND_STOP_SPINDLE);
      end();
      writeActivityComment(" *** STOP end ***");
    } else {
      loadFile(getProperty("gcodeStopFile"));
    }
    close();
  }
  
  //-------------------------------------------------------------------------------------------------
  function onSection() {
    // Write Start gcode of the documment (after the "onParameters" with the global info)
    if (isFirstSection()) {
      writeFirstSection();
    }
    writeActivityComment(" *** SECTION begin ***");
  
    // Tool change
    if (
      getProperty("toolChangeEnabled") &&
      !isFirstSection() &&
      tool.number != getPreviousSection().getTool().number
    ) {
      if (getProperty("gcodeToolFile") == "") {
        // Builtin tool change gcode
        writeActivityComment(" --- CHANGE TOOL begin ---");
        toolChange();
        writeActivityComment(" --- CHANGE TOOL end ---");
      } else {
        // Custom tool change gcode
        loadFile(getProperty("gcodeToolFile"));
      }
    }
  
    if (getProperty("commentSections")) {
      // Machining type
      if (currentSection.type == TYPE_MILLING) {
        // Specific milling code
        writeComment(
          sectionComment +
            " - Milling - Tool: " +
            tool.number +
            " - " +
            tool.comment +
            " " +
            getToolTypeName(tool.type)
        );
      }
  
      if (currentSection.type == TYPE_JET) {
        // Cutter mode used for different cutting power in PWM laser
        switch (currentSection.jetMode) {
          case JET_MODE_THROUGH:
            cutterOnCurrentPower = getProperty("cutterOnThrough");
            break;
          case JET_MODE_ETCHING:
            cutterOnCurrentPower = getProperty("cutterOnEtch");
            break;
          case JET_MODE_VAPORIZE:
            cutterOnCurrentPower = getProperty("cutterOnVaporize");
            break;
          default:
            error("Cutting mode is not supported.");
        }
        writeComment(
          sectionComment +
            " - Laser/Plasma - Cutting mode: " +
            getParameter("operation:cuttingMode")
        );
      }
  
      // Print min/max boundaries for each section
      vectorX = new Vector(1, 0, 0);
      vectorY = new Vector(0, 1, 0);
      writeComment(
        " X Min: " +
          xyzFormat.format(currentSection.getGlobalRange(vectorX).getMinimum()) +
          " - X Max: " +
          xyzFormat.format(currentSection.getGlobalRange(vectorX).getMaximum())
      );
      writeComment(
        " Y Min: " +
          xyzFormat.format(currentSection.getGlobalRange(vectorY).getMinimum()) +
          " - Y Max: " +
          xyzFormat.format(currentSection.getGlobalRange(vectorY).getMaximum())
      );
      writeComment(
        " Z Min: " +
          xyzFormat.format(currentSection.getGlobalZRange().getMinimum()) +
          " - Z Max: " +
          xyzFormat.format(currentSection.getGlobalZRange().getMaximum())
      );
    }
  
    section(); //adjust mode
  
    onCommand(COMMAND_START_SPINDLE);
    onCommand(COMMAND_COOLANT_ON);
    // Display section name in LCD
    display_text(" " + sectionComment);
  }
  
  //-------------------------------------------------------------------------------------------------
  function resetAll() {
    xOutput.reset();
    yOutput.reset();
    zOutput.reset();
    fOutput.reset();
  }
  
  //-------------------------------------------------------------------------------------------------
  // Called in every section end
  function onSectionEnd() {
    resetAll();
    writeActivityComment(" *** SECTION end ***");
    writeln("");
  }
  
  //-------------------------------------------------------------------------------------------------
  function onComment(message) {
    writeComment(message);
  }
  
  //-------------------------------------------------------------------------------------------------
  function onRadiusCompensation() {
    pendingRadiusCompensation = radiusCompensation;
  }
  
  //-------------------------------------------------------------------------------------------------
  // Rapid movements
  function onRapid(x, y, z) {
    rapidMovements(x, y, z);
  }
  
  //-------------------------------------------------------------------------------------------------
  // Feed movements
  function onLinear(x, y, z, feed) {
    linearMovements(x, y, z, feed);
  }
  
  //-------------------------------------------------------------------------------------------------
  function onRapid5D(_x, _y, _z, _a, _b, _c) {
    error(localize("Multi-axis motion is not supported."));
  }
  
  //-------------------------------------------------------------------------------------------------
  function onLinear5D(_x, _y, _z, _a, _b, _c, _feed) {
    error(localize("Multi-axis motion is not supported."));
  }
  
  //-------------------------------------------------------------------------------------------------
  function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
    if (pendingRadiusCompensation != RADIUS_COMPENSATION_OFF) {
      error(
        localize(
          "Radius compensation cannot be activated/deactivated for a circular move."
        )
      );
      return;
    }
    circular(clockwise, cx, cy, cz, x, y, z, feed);
  }
  
  //-------------------------------------------------------------------------------------------------
  function onPower(power) {
    if (power != powerState) {
      if (power) {
        writeActivityComment(" >>> LASER Power ON");
        laserOn(cutterOnCurrentPower);
      } else {
        writeActivityComment(" >>> LASER Power OFF");
        laserOff();
      }
      powerState = power;
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  // Called on Dwell Manual NC invocation
  function onDwell(seconds) {
    if (seconds > 99999.999) {
      warning(localize("Dwelling time is out of range."));
    }
    writeActivityComment(" >>> Dwell");
    dwell(seconds);
  }
  
  //-------------------------------------------------------------------------------------------------
  // Called with every parameter in the documment/section
  function onParameter(name, value) {
    // Write gcode initial info
    // Product version
    if (name == "generated-by") {
      writeComment(value);
      writeComment(
        " Posts processor: " + FileSystem.getFilename(getConfigurationPath())
      );
    }
    // Date
    if (name == "generated-at")
      writeComment(" Gcode generated: " + value + " GMT");
    // Document
    if (name == "document-path") writeComment(" Document: " + value);
    // Setup
    if (name == "job-description") writeComment(" Setup: " + value);
  
    // Get section comment
    if (name == "operation-comment") sectionComment = value;
  }
  
  //-------------------------------------------------------------------------------------------------
  function onMovement(movement) {
    if (getProperty("commentMovements")) {
      var jet = tool.isJetTool && tool.isJetTool();
      var id;
      switch (movement) {
        case MOVEMENT_RAPID:
          id = "MOVEMENT_RAPID";
          break;
        case MOVEMENT_LEAD_IN:
          id = "MOVEMENT_LEAD_IN";
          break;
        case MOVEMENT_CUTTING:
          id = "MOVEMENT_CUTTING";
          break;
        case MOVEMENT_LEAD_OUT:
          id = "MOVEMENT_LEAD_OUT";
          break;
        case MOVEMENT_LINK_TRANSITION:
          id = jet ? "MOVEMENT_BRIDGING" : "MOVEMENT_LINK_TRANSITION";
          break;
        case MOVEMENT_LINK_DIRECT:
          id = "MOVEMENT_LINK_DIRECT";
          break;
        case MOVEMENT_RAMP_HELIX:
          id = jet ? "MOVEMENT_PIERCE_CIRCULAR" : "MOVEMENT_RAMP_HELIX";
          break;
        case MOVEMENT_RAMP_PROFILE:
          id = jet ? "MOVEMENT_PIERCE_PROFILE" : "MOVEMENT_RAMP_PROFILE";
          break;
        case MOVEMENT_RAMP_ZIG_ZAG:
          id = jet ? "MOVEMENT_PIERCE_LINEAR" : "MOVEMENT_RAMP_ZIG_ZAG";
          break;
        case MOVEMENT_RAMP:
          id = "MOVEMENT_RAMP";
          break;
        case MOVEMENT_PLUNGE:
          id = jet ? "MOVEMENT_PIERCE" : "MOVEMENT_PLUNGE";
          break;
        case MOVEMENT_PREDRILL:
          id = "MOVEMENT_PREDRILL";
          break;
        case MOVEMENT_EXTENDED:
          id = "MOVEMENT_EXTENDED";
          break;
        case MOVEMENT_REDUCED:
          id = "MOVEMENT_REDUCED";
          break;
        case MOVEMENT_HIGH_FEED:
          id = "MOVEMENT_HIGH_FEED";
          break;
        case MOVEMENT_FINISH_CUTTING:
          id = "MOVEMENT_FINISH_CUTTING";
          break;
      }
      if (id == undefined) {
        id = String(movement);
      }
      writeComment(" " + id);
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function setSpindeSpeed(_spindleSpeed, _clockwise) {
    if (currentSpindleSpeed != _spindleSpeed) {
      if (_spindleSpeed > 0) {
        spindleOn(_spindleSpeed, _clockwise);
      } else {
        spindleOff();
      }
      currentSpindleSpeed = _spindleSpeed;
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function onSpindleSpeed(spindleSpeed) {
    setSpindeSpeed(spindleSpeed, tool.clockwise);
  }
  
  //-------------------------------------------------------------------------------------------------
  function onCommand(command) {
    if (getProperty("commentActivities")) {
      var stringId = getCommandStringId(command);
      writeComment(" " + stringId);
    }
    switch (command) {
      case COMMAND_START_SPINDLE:
        onCommand(
          tool.clockwise
            ? COMMAND_SPINDLE_CLOCKWISE
            : COMMAND_SPINDLE_COUNTERCLOCKWISE
        );
        return;
      case COMMAND_SPINDLE_CLOCKWISE:
        if (tool.jetTool) return;
        setSpindeSpeed(spindleSpeed, true);
        return;
      case COMMAND_SPINDLE_COUNTERCLOCKWISE:
        if (tool.jetTool) return;
        setSpindeSpeed(spindleSpeed, false);
        return;
      case COMMAND_STOP_SPINDLE:
        if (tool.jetTool) return;
        setSpindeSpeed(0, true);
        return;
      case COMMAND_COOLANT_ON:
        setCoolant(tool.coolant);
        return;
      case COMMAND_COOLANT_OFF:
        setCoolant(0); //COOLANT_DISABLED
        return;
      case COMMAND_LOCK_MULTI_AXIS:
        return;
      case COMMAND_UNLOCK_MULTI_AXIS:
        return;
      case COMMAND_BREAK_CONTROL:
        return;
      case COMMAND_TOOL_MEASURE:
        if (tool.jetTool) return;
        probeTool();
        return;
      case COMMAND_STOP:
        writeBlock(mFormat.format(0));
        return;
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function handleMinMax(pair, range) {
    var rmin = range.getMinimum();
    var rmax = range.getMaximum();
    if (pair.min == undefined || pair.min > rmin) {
      pair.min = rmin;
    }
    if (pair.max == undefined || pair.max < rmax) {
      pair.max = rmax;
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function writeFirstSection() {
    // dump tool information
    var toolZRanges = {};
    var vectorX = new Vector(1, 0, 0);
    var vectorY = new Vector(0, 1, 0);
    var ranges = {
      x: { min: undefined, max: undefined },
      y: { min: undefined, max: undefined },
      z: { min: undefined, max: undefined },
    };
  
    var numberOfSections = getNumberOfSections();
    for (var i = 0; i < numberOfSections; ++i) {
      var section = getSection(i);
      var tool = section.getTool();
      var zRange = section.getGlobalZRange();
      var xRange = section.getGlobalRange(vectorX);
      var yRange = section.getGlobalRange(vectorY);
      handleMinMax(ranges.x, xRange);
      handleMinMax(ranges.y, yRange);
      handleMinMax(ranges.z, zRange);
      if (is3D() && getProperty("commentWriteTools")) {
        if (toolZRanges[tool.number]) {
          toolZRanges[tool.number].expandToRange(zRange);
        } else {
          toolZRanges[tool.number] = zRange;
        }
      }
    }
  
    writeComment(" ");
    writeComment(" Ranges table:");
    writeComment(
      " X: Min=" +
        xyzFormat.format(ranges.x.min) +
        " Max=" +
        xyzFormat.format(ranges.x.max) +
        " Size=" +
        xyzFormat.format(ranges.x.max - ranges.x.min)
    );
    writeComment(
      " Y: Min=" +
        xyzFormat.format(ranges.y.min) +
        " Max=" +
        xyzFormat.format(ranges.y.max) +
        " Size=" +
        xyzFormat.format(ranges.y.max - ranges.y.min)
    );
    writeComment(
      " Z: Min=" +
        xyzFormat.format(ranges.z.min) +
        " Max=" +
        xyzFormat.format(ranges.z.max) +
        " Size=" +
        xyzFormat.format(ranges.z.max - ranges.z.min)
    );
  
    if (getProperty("commentWriteTools")) {
      writeComment(" ");
      writeComment(" Tools table:");
      var tools = getToolTable();
      if (tools.getNumberOfTools() > 0) {
        for (var i = 0; i < tools.getNumberOfTools(); ++i) {
          var tool = tools.getTool(i);
          var comment =
            " T" +
            toolFormat.format(tool.number) +
            " D=" +
            xyzFormat.format(tool.diameter) +
            " CR=" +
            xyzFormat.format(tool.cornerRadius);
          if (tool.taperAngle > 0 && tool.taperAngle < Math.PI) {
            comment += " TAPER=" + taperFormat.format(tool.taperAngle) + "deg";
          }
          if (toolZRanges[tool.number]) {
            comment +=
              " - ZMIN=" +
              xyzFormat.format(toolZRanges[tool.number].getMinimum());
          }
          comment += " - " + getToolTypeName(tool.type) + " " + tool.comment;
          writeComment(comment);
        }
      }
    }
    writeln("");
    writeActivityComment(" *** START begin ***");
  
    if (getProperty("gcodeStartFile") == "") {
      start();
    } else {
      loadFile(getProperty("gcodeStartFile"));
    }
    writeActivityComment(" *** START end ***");
    writeln("");
  }
  
  //-------------------------------------------------------------------------------------------------
  // Output a comment
  function writeComment(text) {
    writeln(";" + String(text).replace(/[()]/g, ""));
  }
  
  //-------------------------------------------------------------------------------------------------
  // Rapid movements with G1 and differentiated travel speeds for XY and Z
  function rapidMovementsXY(_x, _y) {
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    if (x || y) {
      if (pendingRadiusCompensation != RADIUS_COMPENSATION_OFF) {
        error(
          localize(
            "Radius compensation mode cannot be changed at rapid traversal."
          )
        );
        return;
      }
      f = fOutput.format(propertyMmToUnit(getProperty("jobTravelSpeedXY")));
      writeBlock(gMotionModal.format(0), x, y, f);
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function rapidMovementsZ(_z) {
    var z = zOutput.format(_z);
    if (z) {
      if (pendingRadiusCompensation != RADIUS_COMPENSATION_OFF) {
        error(
          localize(
            "Radius compensation mode cannot be changed at rapid traversal."
          )
        );
        return;
      }
      f = fOutput.format(propertyMmToUnit(getProperty("jobTravelSpeedZ")));
      writeBlock(gMotionModal.format(0), z, f);
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function rapidMovements(_x, _y, _z) {
    rapidMovementsZ(_z);
    rapidMovementsXY(_x, _y);
  }
  
  //-------------------------------------------------------------------------------------------------
  // Linear movements
  function linearMovements(_x, _y, _z, _feed) {
    if (pendingRadiusCompensation != RADIUS_COMPENSATION_OFF) {
      // ensure that we end at desired position when compensation is turned off
      xOutput.reset();
      yOutput.reset();
    }
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var f = fOutput.format(_feed);
    if (x || y || z) {
      if (pendingRadiusCompensation != RADIUS_COMPENSATION_OFF) {
        error(localize("Radius compensation mode is not supported."));
        return;
      } else {
        writeBlock(gMotionModal.format(1), x, y, z, f);
      }
    } else if (f) {
      if (getNextRecord().isMotion()) {
        // try not to output feed without motion
        fOutput.reset(); // force feed on next line
      } else {
        writeBlock(gMotionModal.format(1), f);
      }
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  // Test if file exist/can read and load it
  function loadFile(_file) {
    var folder = FileSystem.getFolderPath(getOutputPath()) + PATH_SEPARATOR;
    if (FileSystem.isFile(folder + _file)) {
      var txt = loadText(folder + _file, "utf-8");
      if (txt.length > 0) {
        writeActivityComment(" --- Start custom gcode " + folder + _file);
        write(txt);
        writeActivityComment(" --- End custom gcode " + folder + _file);
        writeln("");
      }
    } else {
      writeComment(" Can't open file " + folder + _file);
      error("Can't open file " + folder + _file);
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  // Manage coolant state
  function setCoolant(coolant) {
    if (currentCoolantMode == coolant) {
      return;
    }
    if (getProperty("coolantA_Mode") != 0) {
      if (currentCoolantMode == getProperty("coolantA_Mode")) {
        writeActivityComment(" >>> Coolant A OFF");
        coolantA(true);
      } else if (coolant == getProperty("coolantA_Mode")) {
        writeActivityComment(" >>> Coolant A ON");
        coolantA(false);
      }
    }
    if (getProperty("coolantB_Mode") != 0) {
      if (currentCoolantMode == getProperty("coolantB_Mode")) {
        writeActivityComment(" >>> Coolant B OFF");
        coolantB(true);
      } else if (coolant == getProperty("coolantB_Mode")) {
        writeActivityComment(" >>> Coolant B ON");
        coolantB(false);
      }
    }
    currentCoolantMode = coolant;
  }
  
  //-------------------------------------------------------------------------------------------------
  function propertyMmToUnit(_v) {
    return _v / (unit == IN ? 25.4 : 1);
  }
  
  //-------------------------------------------------------------------------------------------------
  function writeActivityComment(_comment) {
    if (getProperty("commentActivities")) {
      writeComment(_comment);
    }
  }
  
  //-----------------------------------------------------------------------------------------------------------------------------
  function start() {
    writeBlock(gAbsIncModal.format(90)); // Set to Absolute Positioning
    writeBlock(gUnitModal.format(unit == IN ? 20 : 21));
    writeBlock(mFormat.format(84), sFormat.format(0)); // Disable steppers timeout
    if (getProperty("jobSetOriginOnStart")) {
      writeBlock(
        gFormat.format(92),
        xFormat.format(0),
        yFormat.format(0),
        zFormat.format(0)
      ); // Set origin to initial position
    }
    if (getProperty("probeOnStart") && tool.number != 0 && !tool.jetTool) {
      onCommand(COMMAND_TOOL_MEASURE);
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function end() {
    display_text("Job end");
  }
  
  //-------------------------------------------------------------------------------------------------
  function close() {
    // noop
  }
  

  //-------------------------------------------------------------------------------------------------
  function flushMotions() {
    writeBlock(mFormat.format(400));
  }
  
  //-------------------------------------------------------------------------------------------------
  function spindleOn(spindleSpeed, _clockwise) {
    if (getProperty("jobManualSpindlePowerControl")) {
      // for manual any positive input speed assumed as enabled. so it's just a flag
      if (!spindleEnabled) {
        askUser(
          "Turn ON " + speedFormat.format(spindleSpeed) + "RPM",
          "Spindle",
          false
        );
      }
    } else {
      //writeActivityComment(" >>> Spindle Speed " + speedFormat.format(_spindleSpeed));
      // writeBlock(mFormat.format(_clockwise ? 3 : 4), sOutput.format(spindleSpeed));
      writeActivityComment(" >>> Turning the spindle ON by enabling the fan");
      writeBlock(mFormat.format(106));
    }
    spindleEnabled = true;
  }
  
  //-------------------------------------------------------------------------------------------------
  function spindleOff() {
    if (getProperty("jobManualSpindlePowerControl")) {
      writeBlock(mFormat.format(300), sFormat.format(300), pFormat.format(3000));
      askUser("Turn OFF spindle", "Spindle", false);
    } else {
      // writeBlock(mFormat.format(5));
      writeActivityComment(" >>> Turning the spindle OFF by disabling the fan");
      writeBlock(mFormat.format(107));
    }
    spindleEnabled = false;
  }
  
  //-------------------------------------------------------------------------------------------------
  function laserOn(power) {
    var laser_pwm = (power / 100) * 255;
    switch (getProperty("cutterMarlinMode")) {
      case 106:
        writeBlock(mFormat.format(106), sFormat.format(laser_pwm));
        break;
      case 3:
        writeBlock(mFormat.format(3), oFormat.format(laser_pwm));
        break;
      case 42:
        writeBlock(
          mFormat.format(42),
          pFormat.format(getProperty("cutterMarlinPin")),
          sFormat.format(laser_pwm)
        );
        break;
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function laserOff() {
    switch (getProperty("cutterMarlinMode")) {
      case 106:
        writeBlock(mFormat.format(107));
        break;
      case 3:
        writeBlock(mFormat.format(5));
        break;
      case 42:
        writeBlock(
          mFormat.format(42),
          pFormat.format(getProperty("cutterMarlinPin")),
          sFormat.format(0)
        );
        break;
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function coolantA(on) {
    writeBlock(on ? getProperty("coolantAMarlinOn") : getProperty("coolantAMarlinOff"));
  }
  
  //-------------------------------------------------------------------------------------------------
  function coolantB(on) {
    writeBlock(on ? getProperty("coolantBMarlinOn") : roperties.coolantBMarlinOff);
  }
  
  //-------------------------------------------------------------------------------------------------
  function dwell(seconds) {
    writeBlock(gFormat.format(4), "S" + secFormat.format(seconds));
  }
  
  //-------------------------------------------------------------------------------------------------
  function display_text(txt) {
    writeBlock(
      mFormat.format(117),
      (getProperty("jobSeparateWordsWithSpace") ? "" : " ") + txt
    );
  }
  
  //-------------------------------------------------------------------------------------------------
  function circular(
    clockwise,
    cx,
    cy,
    cz,
    x,
    y,
    z,
    feed
  ) {
    if (!getProperty("jobUseArcs")) {
      linearize(tolerance);
      return;
    }
    // Marlin supports arcs only on XY plane
    var start = getCurrentPosition();
    if (isFullCircle()) {
      if (isHelical()) {
        linearize(tolerance);
        return;
      }
      switch (getCircularPlane()) {
        case PLANE_XY:
          writeBlock(
            gMotionModal.format(clockwise ? 2 : 3),
            xOutput.format(x),
            iOutput.format(cx - start.x, 0),
            jOutput.format(cy - start.y, 0),
            fOutput.format(feed)
          );
          break;
        default:
          linearize(tolerance);
      }
    } else {
      switch (getCircularPlane()) {
        case PLANE_XY:
          writeBlock(
            gMotionModal.format(clockwise ? 2 : 3),
            xOutput.format(x),
            yOutput.format(y),
            zOutput.format(z),
            iOutput.format(cx - start.x, 0),
            jOutput.format(cy - start.y, 0),
            fOutput.format(feed)
          );
          break;
        default:
          linearize(tolerance);
      }
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function askUser(text, title, allowJog) {
    writeBlock(
      mFormat.format(0),
      (getProperty("jobSeparateWordsWithSpace") ? "" : " ") + text
    );
  }
  
  //-------------------------------------------------------------------------------------------------
  function toolChange() {
    flushMotions();

    // Go to tool change position
    onRapid(
      propertyMmToUnit(getProperty("toolChangeX")),
      propertyMmToUnit(getProperty("toolChangeY")),
      propertyMmToUnit(getProperty("toolChangeZ"))
    );
    flushMotions();

    // turn off spindle and coolant
    onCommand(COMMAND_COOLANT_OFF);
    onCommand(COMMAND_STOP_SPINDLE);

    if (!getProperty("jobManualSpindlePowerControl")) {
      // Beep
      writeBlock(mFormat.format(300), sFormat.format(400), pFormat.format(2000));
    }
  
    // Disable Z stepper
    if (getProperty("toolChangeDisableZStepper")) {
      askUser(
        "Z Stepper will disabled. Wait for STOP!!",
        "Tool change",
        false
      );
      writeBlock(mFormat.format(17), "Z"); // Disable steppers timeout
    }

    // Ask tool change and wait user to touch lcd button
    askUser("Tool " + tool.number + " " + tool.comment, "Tool change", true);
  
    // Run Z probe gcode
    if (getProperty("toolChangeZProbe") && tool.number != 0) {
      onCommand(COMMAND_TOOL_MEASURE);
    }
  }
  
  //-------------------------------------------------------------------------------------------------
  function probeTool() {
    askUser("Attach ZProbe", "Probe", false);

    // refer http://marlinfw.org/docs/gcode/G038.html
    if (getProperty("probeUseHomeZ")) {
      writeBlock(gFormat.format(28), "Z");
    } else {
      writeBlock(
        gMotionModal.format(38.3),
        fFormat.format(propertyMmToUnit(getProperty("probeG38Speed"))),
        zFormat.format(propertyMmToUnit(getProperty("probeG38Target")))
      );
    }

    writeBlock(
      gFormat.format(92),
      zFormat.format(propertyMmToUnit(getProperty("probeThickness")))
    ); // Set origin to initial position

    resetAll();

    if (getProperty("toolChangeZ") != "") {
      // move up tool to safe height again after probing
      rapidMovementsZ(propertyMmToUnit(getProperty("toolChangeZ")));
    }

    flushMotions();
    askUser("Detach ZProbe", "Probe", false);
  }
  