//
//  HIDUsage.swift
//  SwiftyHID
//
//  Created by James Linnell on 9/22/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

/*
 * HID Usage Tables
 *
 * The following constants are from the USB 'HID Usage Tables' specification, revision 1.1rc3
 */

public typealias UsagePageUsage = (usagePage: Int, usage: Int)

protocol IUsagePageUsage {
	var usage: UsagePageUsage { get }
}

public enum Usage {
	case undefined(UndefinedUsage)
	case genericDesktop(GenericDesktopUsage)
	case simulation(SimulationUsage)
	case vr(VRUsage)
	case sport(SportUsage)
	case game(GameUsage)
	case genDevControls(GenDevControlsUsage)
	case keyboardOrKeypad(KeyboardOrKeypadUsage)
	case leds(LEDsUsage)
	case button(ButtonUsage)
	case ordinal(OrdinalUsage)
	case telphony(TelephonyUsage)
	case consumer(ConsumerUsage)
	case digitizer(DigitizerUsage)
	case physicalInterfaceDevice(PhysicalInterfaceDeviceUsage)
	case alphanumeric(AlphanumericDisplayUsage)
	case sensor(SensorUsage)
	case powerDevice(PowerDeviceUsage)
	case batterySystem(BatterySystemUsage)
	case barCodeScanner(BarCodeScannerUsage)
	case weighDevice(WeighDevicesUsage)
	case magneticStripeReader(MagneticStripeReaderUsage)
	case reserved(ReservedUsage)
	
	public init(withUsagePage usagePage: Int, usage: Int) {
		switch usagePage {
		case kHIDPage_Undefined: self = .undefined(.undefined)
		case kHIDPage_GenericDesktop: self = .genericDesktop(GenericDesktopUsage(with: usage))
		case kHIDPage_Simulation: self = .simulation(SimulationUsage(with: usage))
		case kHIDPage_VR: self = .vr(VRUsage(with: usage))
		case kHIDPage_Sport: self = .sport(SportUsage(with: usage))
		case kHIDPage_Game: self = .game(GameUsage(with: usage))
		case kHIDPage_GenericDeviceControls: self = .genDevControls(GenDevControlsUsage(with: usage))
		case kHIDPage_KeyboardOrKeypad: self = .keyboardOrKeypad(KeyboardOrKeypadUsage(with: usage))
		case kHIDPage_LEDs: self = .leds(LEDsUsage(with: usage))
		case kHIDPage_Button: self = .button(ButtonUsage(with: usage))
		case kHIDPage_Ordinal: self = .ordinal(OrdinalUsage(with: usage))
		case kHIDPage_Telephony: self = .telphony(TelephonyUsage(with: usage))
		case kHIDPage_Consumer: self = .consumer(ConsumerUsage(with: usage))
		case kHIDPage_Digitizer: self = .digitizer(DigitizerUsage(with: usage))
		case kHIDPage_PID: self = .physicalInterfaceDevice(PhysicalInterfaceDeviceUsage(with: usage))
		case kHIDPage_AlphanumericDisplay: self = .alphanumeric(AlphanumericDisplayUsage(with: usage))
		case kHIDPage_Sensor: self = .sensor(SensorUsage(with: usage))
		case kHIDPage_PowerDevice: self = .powerDevice(PowerDeviceUsage(with: usage))
		case kHIDPage_BatterySystem: self = .batterySystem(BatterySystemUsage(with: usage))
		case kHIDPage_BarCodeScanner: self = .barCodeScanner(BarCodeScannerUsage(with: usage))
		case kHIDPage_WeighingDevice: self = .weighDevice(WeighDevicesUsage(with: usage))
		case kHIDPage_MagneticStripeReader: self = .magneticStripeReader(MagneticStripeReaderUsage(with: usage))
		default: self = .reserved(ReservedUsage(withUsagePage: usagePage, usage: usage))
		}
	}
	
	public var usagePage: String {
		switch self {
		case .undefined: return "Undefined"
		case .genericDesktop: return "GenericDesktop"
		case .simulation: return "Simulation"
		case .vr: return "VR"
		case .sport: return "Sport"
		case .game: return "Game"
		case .genDevControls: return "GenDevControls"
		case .keyboardOrKeypad: return "KeyboardOrKeypad"
		case .leds: return "LEDs"
		case .button: return "Button"
		case .ordinal: return "Ordinal"
		case .telphony: return "Telephony"
		case .consumer: return "Consumer"
		case .digitizer: return "Digitizer"
		case .physicalInterfaceDevice: return "PhysicalInterfaceDevice"
		case .alphanumeric: return "AlphanumericDisplay"
		case .sensor: return "Sensor"
		case .powerDevice: return "PowerDevice"
		case .batterySystem: return "BatterySystem"
		case .barCodeScanner: return "BarCodeScanner"
		case .weighDevice: return "WeighDevices"
		case .magneticStripeReader: return "MagneticStripeReader"
		case .reserved(let val): return "Reserved(\(val.usage.usagePage))"
		}
	}
	
	public var usage: String {
		switch self {
		case .undefined(let usage): return "\(usage)"
		case .genericDesktop(let usage): return "\(usage)"
		case .simulation(let usage): return "\(usage)"
		case .vr(let usage): return "\(usage)"
		case .sport(let usage): return "\(usage)"
		case .game(let usage): return "\(usage)"
		case .genDevControls(let usage): return "\(usage)"
		case .keyboardOrKeypad(let usage): return "\(usage)"
		case .leds(let usage): return "\(usage)"
		case .button(let usage): return "\(usage)"
		case .ordinal(let usage): return "\(usage)"
		case .telphony(let usage): return "\(usage)"
		case .consumer(let usage): return "\(usage)"
		case .digitizer(let usage): return "\(usage)"
		case .physicalInterfaceDevice(let usage): return "\(usage)"
		case .alphanumeric(let usage): return "\(usage)"
		case .sensor(let usage): return "\(usage)"
		case .powerDevice(let usage): return "\(usage)"
		case .batterySystem(let usage): return "\(usage)"
		case .barCodeScanner(let usage): return "\(usage)"
		case .weighDevice(let usage): return "\(usage)"
		case .magneticStripeReader(let usage): return "\(usage)"
		case .reserved(let usage): return "reserved(\(usage.usage.usage))"
		}
	}
}

/** Undefined Usage for all usage pages */
public enum UndefinedUsage: IUsagePageUsage
{
	case undefined
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Undefined, kHIDUsage_Undefined)
		}
	}
};

/** GenericDesktop Page (0x01) */
public enum GenericDesktopUsage: IUsagePageUsage
{
	case undefined
	case pointer /* Physical Collection */
	case mouse /* Application Collection */
	/* 0x03 Reserved */
	case joystick /* Application Collection */
	case gamePad /* Application Collection */
	case keyboard /* Application Collection */
	case keypad /* Application Collection */
	case multiAxisController /* Application Collection */
	/* 0x09 - 0x2F Reserved */
	case x /* Dynamic Value */
	case y /* Dynamic Value */
	case z /* Dynamic Value */
	case rx /* Dynamic Value */
	case ry /* Dynamic Value */
	case rz /* Dynamic Value */
	case slider /* Dynamic Value */
	case dial /* Dynamic Value */
	case wheel /* Dynamic Value */
	case hatswitch /* Dynamic Value */
	case countedBuffer /* Logical Collection */
	case byteCount /* Dynamic Value */
	case motionWakeup /* One-Shot Control */
	case start /* On/Off Control */
	case select /* On/Off Control */
	/* 0x3F Reserved */
	case vx /* Dynamic Value */
	case vy /* Dynamic Value */
	case vz /* Dynamic Value */
	case vbrx /* Dynamic Value */
	case vbry /* Dynamic Value */
	case vbrz /* Dynamic Value */
	case vno /* Dynamic Value */
	/* 0x47 - 0x7F Reserved */
	case systemControl /* Application Collection */
	case systemPowerDown /* One-Shot Control */
	case systemSleep /* One-Shot Control */
	case systemWakeUp /* One-Shot Control */
	case systemContextMenu /* One-Shot Control */
	case systemMainMenu /* One-Shot Control */
	case systemAppMenu /* One-Shot Control */
	case systemMenuHelp /* One-Shot Control */
	case systemMenuExit /* One-Shot Control */
	case systemMenuSelect /* Selector */
	case systemMenu /* Selector */
	case systemMenuRight /* Re-Trigger Control */
	case systemMenuLeft /* Re-Trigger Control */
	case systemMenuUp /* Re-Trigger Control */
	case systemMenuDown /* Re-Trigger Control */
	/* 0x8E - 0x8F Reserved */
	case dPadUp /* On/Off Control */
	case dPadDown /* On/Off Control */
	case dPadRight /* On/Off Control */
	case dPadLeft /* On/Off Control */
	/* 0x94 - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_GenericDesktop, kHIDUsage_Undefined)
		case .pointer: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Pointer) /* Physical Collection */
		case .mouse: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Mouse) /* Application Collection */
		/* 0x03 Reserved */
		case .joystick: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Joystick) /* Application Collection */
		case .gamePad: return (kHIDPage_GenericDesktop, kHIDUsage_GD_GamePad) /* Application Collection */
		case .keyboard: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Keyboard) /* Application Collection */
		case .keypad: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Keypad) /* Application Collection */
		case .multiAxisController: return (kHIDPage_GenericDesktop, kHIDUsage_GD_MultiAxisController) /* Application Collection */
		/* 0x09 - 0x2F Reserved */
		case .x: return (kHIDPage_GenericDesktop, kHIDUsage_GD_X) /* Dynamic Value */
		case .y: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Y) /* Dynamic Value */
		case .z: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Z) /* Dynamic Value */
		case .rx: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Rx) /* Dynamic Value */
		case .ry: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Ry) /* Dynamic Value */
		case .rz: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Rz) /* Dynamic Value */
		case .slider: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Slider) /* Dynamic Value */
		case .dial: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Dial) /* Dynamic Value */
		case .wheel: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Wheel) /* Dynamic Value */
		case .hatswitch: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Hatswitch) /* Dynamic Value */
		case .countedBuffer: return (kHIDPage_GenericDesktop, kHIDUsage_GD_CountedBuffer) /* Logical Collection */
		case .byteCount: return (kHIDPage_GenericDesktop, kHIDUsage_GD_ByteCount) /* Dynamic Value */
		case .motionWakeup: return (kHIDPage_GenericDesktop, kHIDUsage_GD_MotionWakeup) /* One-Shot Control */
		case .start: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Start) /* On/Off Control */
		case .select: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Select) /* On/Off Control */
		/* 0x3F Reserved */
		case .vx: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Vx) /* Dynamic Value */
		case .vy: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Vy) /* Dynamic Value */
		case .vz: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Vz) /* Dynamic Value */
		case .vbrx: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Vbrx) /* Dynamic Value */
		case .vbry: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Vbry) /* Dynamic Value */
		case .vbrz: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Vbrz) /* Dynamic Value */
		case .vno: return (kHIDPage_GenericDesktop, kHIDUsage_GD_Vno) /* Dynamic Value */
		/* 0x47 - 0x7F Reserved */
		case .systemControl: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemControl) /* Application Collection */
		case .systemPowerDown: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemPowerDown) /* One-Shot Control */
		case .systemSleep: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemSleep) /* One-Shot Control */
		case .systemWakeUp: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemWakeUp) /* One-Shot Control */
		case .systemContextMenu: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemContextMenu) /* One-Shot Control */
		case .systemMainMenu: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemMainMenu) /* One-Shot Control */
		case .systemAppMenu: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemAppMenu) /* One-Shot Control */
		case .systemMenuHelp: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemMenuHelp) /* One-Shot Control */
		case .systemMenuExit: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemMenuExit) /* One-Shot Control */
		case .systemMenuSelect, .systemMenu: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemMenu) /* Selector */
		case .systemMenuRight: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemMenuRight) /* Re-Trigger Control */
		case .systemMenuLeft: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemMenuLeft) /* Re-Trigger Control */
		case .systemMenuUp: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemMenuUp) /* Re-Trigger Control */
		case .systemMenuDown: return (kHIDPage_GenericDesktop, kHIDUsage_GD_SystemMenuDown) /* Re-Trigger Control */
		/* 0x8E - 0x8F Reserved */
		case .dPadUp: return (kHIDPage_GenericDesktop, kHIDUsage_GD_DPadUp) /* On/Off Control */
		case .dPadDown: return (kHIDPage_GenericDesktop, kHIDUsage_GD_DPadDown) /* On/Off Control */
		case .dPadRight: return (kHIDPage_GenericDesktop, kHIDUsage_GD_DPadRight) /* On/Off Control */
		case .dPadLeft: return (kHIDPage_GenericDesktop, kHIDUsage_GD_DPadLeft) /* On/Off Control */
		/* 0x94 - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_GenericDesktop, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_GD_Pointer: self = .pointer
		case kHIDUsage_GD_Mouse: self = .mouse
		/* 0x03 Reserved */
		case kHIDUsage_GD_Joystick: self = .joystick
		case kHIDUsage_GD_GamePad: self = .gamePad
		case kHIDUsage_GD_Keyboard: self = .keyboard
		case kHIDUsage_GD_Keypad: self = .keypad
		case kHIDUsage_GD_MultiAxisController: self = .multiAxisController
		/* 0x09 - 0x2F Reserved */
		case kHIDUsage_GD_X: self = .x
		case kHIDUsage_GD_Y: self = .y
		case kHIDUsage_GD_Z: self = .z
		case kHIDUsage_GD_Rx: self = .rx
		case kHIDUsage_GD_Ry: self = .ry
		case kHIDUsage_GD_Rz: self = .rz
		case kHIDUsage_GD_Slider: self = .slider
		case kHIDUsage_GD_Dial: self = .dial
		case kHIDUsage_GD_Wheel: self = .wheel
		case kHIDUsage_GD_Hatswitch: self = .hatswitch
		case kHIDUsage_GD_CountedBuffer: self = .countedBuffer
		case kHIDUsage_GD_ByteCount: self = .byteCount
		case kHIDUsage_GD_MotionWakeup: self = .motionWakeup
		case kHIDUsage_GD_Start: self = .start
		case kHIDUsage_GD_Select: self = .select
		/* 0x3F Reserved */
		case kHIDUsage_GD_Vx: self = .vx
		case kHIDUsage_GD_Vy: self = .vy
		case kHIDUsage_GD_Vz: self = .vz
		case kHIDUsage_GD_Vbrx: self = .vbrx
		case kHIDUsage_GD_Vbry: self = .vbry
		case kHIDUsage_GD_Vbrz: self = .vbrz
		case kHIDUsage_GD_Vno: self = .vno
		/* 0x47 - 0x7F Reserved */
		case kHIDUsage_GD_SystemControl: self = .systemControl
		case kHIDUsage_GD_SystemPowerDown: self = .systemPowerDown
		case kHIDUsage_GD_SystemSleep: self = .systemSleep
		case kHIDUsage_GD_SystemWakeUp: self = .systemWakeUp
		case kHIDUsage_GD_SystemContextMenu: self = .systemContextMenu
		case kHIDUsage_GD_SystemMainMenu: self = .systemMainMenu
		case kHIDUsage_GD_SystemAppMenu: self = .systemAppMenu
		case kHIDUsage_GD_SystemMenuHelp: self = .systemMenuHelp
		case kHIDUsage_GD_SystemMenuExit: self = .systemMenuExit
		case kHIDUsage_GD_SystemMenu: self = .systemMenuSelect
		case kHIDUsage_GD_SystemMenuRight: self = .systemMenuRight
		case kHIDUsage_GD_SystemMenuLeft: self = .systemMenuLeft
		case kHIDUsage_GD_SystemMenuUp: self = .systemMenuUp
		case kHIDUsage_GD_SystemMenuDown: self = .systemMenuDown
		/* 0x8E - 0x8F Reserved */
		case kHIDUsage_GD_DPadUp: self = .dPadUp
		case kHIDUsage_GD_DPadDown: self = .dPadDown
		case kHIDUsage_GD_DPadRight: self = .dPadRight
		case kHIDUsage_GD_DPadLeft: self = .dPadLeft
		/* 0x94 - 0xFFFF Reserved */
		case kHIDUsage_GD_Reserved: self = .reserved(kHIDUsage_GD_Reserved)
		default: self = .reserved(usage)
		}
	}
};

/**
 Simulation Page (0x02)
 This section provides detailed descriptions of the usages employed by simulation devices.
 */
public enum SimulationUsage: IUsagePageUsage
{
	case undefined
	case flightSimulationDevice /* Application Collection */
	case automobileSimulationDevice /* Application Collection */
	case tankSimulationDevice /* Application Collection */
	case spaceshipSimulationDevice /* Application Collection */
	case submarineSimulationDevice /* Application Collection */
	case sailingSimulationDevice /* Application Collection */
	case motorcycleSimulationDevice /* Application Collection */
	case sportsSimulationDevice /* Application Collection */
	case airplaneSimulationDevice /* Application Collection */
	case helicopterSimulationDevice /* Application Collection */
	case magicCarpetSimulationDevice /* Application Collection */
	case bicycleSimulationDevice /* Application Collection */
	/* 0x0D - 0x1F Reserved */
	case flightControlStick /* Application Collection */
	case flightStick /* Application Collection */
	case cyclicControl /* Physical Collection */
	case cyclicTrim /* Physical Collection */
	case flightYoke /* Application Collection */
	case trackControl /* Physical Collection */
	/* 0x26 - 0xAF Reserved */
	case aileron /* Dynamic Value */
	case aileronTrim /* Dynamic Value */
	case antiTorqueControl /* Dynamic Value */
	case autopilotEnable /* On/Off Control */
	case chaffRelease /* One-Shot Control */
	case collectiveControl /* Dynamic Value */
	case diveBrake /* Dynamic Value */
	case electronicCountermeasures /* On/Off Control */
	case elevator /* Dynamic Value */
	case elevatorTrim /* Dynamic Value */
	case rudder /* Dynamic Value */
	case throttle /* Dynamic Value */
	case flightCommunications /* On/Off Control */
	case flareRelease /* One-Shot Control */
	case landingGear /* On/Off Control */
	case toeBrake /* Dynamic Value */
	case trigger /* Momentary Control */
	case weaponsArm /* On/Off Control */
	case weapons /* Selector */
	case wingFlaps /* Dynamic Value */
	case accelerator /* Dynamic Value */
	case brake /* Dynamic Value */
	case clutch /* Dynamic Value */
	case shifter /* Dynamic Value */
	case steering /* Dynamic Value */
	case turretDirection /* Dynamic Value */
	case barrelElevation /* Dynamic Value */
	case divePlane /* Dynamic Value */
	case ballast /* Dynamic Value */
	case bicycleCrank /* Dynamic Value */
	case handleBars /* Dynamic Value */
	case frontBrake /* Dynamic Value */
	case rearBrake /* Dynamic Value */
	/* 0xD1 - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Simulation, kHIDUsage_Undefined)
		case .flightSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_FlightSimulationDevice) /* Application Collection */
		case .automobileSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_AutomobileSimulationDevice) /* Application Collection */
		case .tankSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_TankSimulationDevice) /* Application Collection */
		case .spaceshipSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_SpaceshipSimulationDevice) /* Application Collection */
		case .submarineSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_SubmarineSimulationDevice) /* Application Collection */
		case .sailingSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_SailingSimulationDevice) /* Application Collection */
		case .motorcycleSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_MotorcycleSimulationDevice) /* Application Collection */
		case .sportsSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_SportsSimulationDevice) /* Application Collection */
		case .airplaneSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_AirplaneSimulationDevice) /* Application Collection */
		case .helicopterSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_HelicopterSimulationDevice) /* Application Collection */
		case .magicCarpetSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_MagicCarpetSimulationDevice) /* Application Collection */
		case .bicycleSimulationDevice: return (kHIDPage_Simulation, kHIDUsage_Sim_BicycleSimulationDevice) /* Application Collection */
		/* 0x0D - 0x1F Reserved */
		case .flightControlStick: return (kHIDPage_Simulation, kHIDUsage_Sim_FlightControlStick) /* Application Collection */
		case .flightStick: return (kHIDPage_Simulation, kHIDUsage_Sim_FlightStick) /* Application Collection */
		case .cyclicControl: return (kHIDPage_Simulation, kHIDUsage_Sim_CyclicControl) /* Physical Collection */
		case .cyclicTrim: return (kHIDPage_Simulation, kHIDUsage_Sim_CyclicTrim) /* Physical Collection */
		case .flightYoke: return (kHIDPage_Simulation, kHIDUsage_Sim_FlightYoke) /* Application Collection */
		case .trackControl: return (kHIDPage_Simulation, kHIDUsage_Sim_TrackControl) /* Physical Collection */
		/* 0x26 - 0xAF Reserved */
		case .aileron: return (kHIDPage_Simulation, kHIDUsage_Sim_Aileron) /* Dynamic Value */
		case .aileronTrim: return (kHIDPage_Simulation, kHIDUsage_Sim_AileronTrim) /* Dynamic Value */
		case .antiTorqueControl: return (kHIDPage_Simulation, kHIDUsage_Sim_AntiTorqueControl) /* Dynamic Value */
		case .autopilotEnable: return (kHIDPage_Simulation, kHIDUsage_Sim_AutopilotEnable) /* On/Off Control */
		case .chaffRelease: return (kHIDPage_Simulation, kHIDUsage_Sim_ChaffRelease) /* One-Shot Control */
		case .collectiveControl: return (kHIDPage_Simulation, kHIDUsage_Sim_CollectiveControl) /* Dynamic Value */
		case .diveBrake: return (kHIDPage_Simulation, kHIDUsage_Sim_DiveBrake) /* Dynamic Value */
		case .electronicCountermeasures: return (kHIDPage_Simulation, kHIDUsage_Sim_ElectronicCountermeasures) /* On/Off Control */
		case .elevator: return (kHIDPage_Simulation, kHIDUsage_Sim_Elevator) /* Dynamic Value */
		case .elevatorTrim: return (kHIDPage_Simulation, kHIDUsage_Sim_ElevatorTrim) /* Dynamic Value */
		case .rudder: return (kHIDPage_Simulation, kHIDUsage_Sim_Rudder) /* Dynamic Value */
		case .throttle: return (kHIDPage_Simulation, kHIDUsage_Sim_Throttle) /* Dynamic Value */
		case .flightCommunications: return (kHIDPage_Simulation, kHIDUsage_Sim_FlightCommunications) /* On/Off Control */
		case .flareRelease: return (kHIDPage_Simulation, kHIDUsage_Sim_FlareRelease) /* One-Shot Control */
		case .landingGear: return (kHIDPage_Simulation, kHIDUsage_Sim_LandingGear) /* On/Off Control */
		case .toeBrake: return (kHIDPage_Simulation, kHIDUsage_Sim_ToeBrake) /* Dynamic Value */
		case .trigger: return (kHIDPage_Simulation, kHIDUsage_Sim_Trigger) /* Momentary Control */
		case .weaponsArm: return (kHIDPage_Simulation, kHIDUsage_Sim_WeaponsArm) /* On/Off Control */
		case .weapons: return (kHIDPage_Simulation, kHIDUsage_Sim_Weapons) /* Selector */
		case .wingFlaps: return (kHIDPage_Simulation, kHIDUsage_Sim_WingFlaps) /* Dynamic Value */
		case .accelerator: return (kHIDPage_Simulation, kHIDUsage_Sim_Accelerator) /* Dynamic Value */
		case .brake: return (kHIDPage_Simulation, kHIDUsage_Sim_Brake) /* Dynamic Value */
		case .clutch: return (kHIDPage_Simulation, kHIDUsage_Sim_Clutch) /* Dynamic Value */
		case .shifter: return (kHIDPage_Simulation, kHIDUsage_Sim_Shifter) /* Dynamic Value */
		case .steering: return (kHIDPage_Simulation, kHIDUsage_Sim_Steering) /* Dynamic Value */
		case .turretDirection: return (kHIDPage_Simulation, kHIDUsage_Sim_TurretDirection) /* Dynamic Value */
		case .barrelElevation: return (kHIDPage_Simulation, kHIDUsage_Sim_BarrelElevation) /* Dynamic Value */
		case .divePlane: return (kHIDPage_Simulation, kHIDUsage_Sim_DivePlane) /* Dynamic Value */
		case .ballast: return (kHIDPage_Simulation, kHIDUsage_Sim_Ballast) /* Dynamic Value */
		case .bicycleCrank: return (kHIDPage_Simulation, kHIDUsage_Sim_BicycleCrank) /* Dynamic Value */
		case .handleBars: return (kHIDPage_Simulation, kHIDUsage_Sim_HandleBars) /* Dynamic Value */
		case .frontBrake: return (kHIDPage_Simulation, kHIDUsage_Sim_FrontBrake) /* Dynamic Value */
		case .rearBrake: return (kHIDPage_Simulation, kHIDUsage_Sim_RearBrake) /* Dynamic Value */
		/* 0xD1 - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_Simulation, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_Sim_FlightSimulationDevice: self = .flightSimulationDevice
		case kHIDUsage_Sim_AutomobileSimulationDevice: self = .automobileSimulationDevice
		case kHIDUsage_Sim_TankSimulationDevice: self = .tankSimulationDevice
		case kHIDUsage_Sim_SpaceshipSimulationDevice: self = .spaceshipSimulationDevice
		case kHIDUsage_Sim_SubmarineSimulationDevice: self = .submarineSimulationDevice
		case kHIDUsage_Sim_SailingSimulationDevice: self = .sailingSimulationDevice
		case kHIDUsage_Sim_MotorcycleSimulationDevice: self = .motorcycleSimulationDevice
		case kHIDUsage_Sim_SportsSimulationDevice: self = .sportsSimulationDevice
		case kHIDUsage_Sim_AirplaneSimulationDevice: self = .airplaneSimulationDevice
		case kHIDUsage_Sim_HelicopterSimulationDevice: self = .helicopterSimulationDevice
		case kHIDUsage_Sim_MagicCarpetSimulationDevice: self = .magicCarpetSimulationDevice
		case kHIDUsage_Sim_BicycleSimulationDevice: self = .bicycleSimulationDevice
		/* 0x0D - 0x1F Reserved */
		case kHIDUsage_Sim_FlightControlStick: self = .flightControlStick
		case kHIDUsage_Sim_FlightStick: self = .flightStick
		case kHIDUsage_Sim_CyclicControl: self = .cyclicControl
		case kHIDUsage_Sim_CyclicTrim: self = .cyclicTrim
		case kHIDUsage_Sim_FlightYoke: self = .flightYoke
		case kHIDUsage_Sim_TrackControl: self = .trackControl
		/* 0x26 - 0xAF Reserved */
		case kHIDUsage_Sim_Aileron: self = .aileron
		case kHIDUsage_Sim_AileronTrim: self = .aileronTrim
		case kHIDUsage_Sim_AntiTorqueControl: self = .antiTorqueControl
		case kHIDUsage_Sim_AutopilotEnable: self = .autopilotEnable
		case kHIDUsage_Sim_ChaffRelease: self = .chaffRelease
		case kHIDUsage_Sim_CollectiveControl: self = .collectiveControl
		case kHIDUsage_Sim_DiveBrake: self = .diveBrake
		case kHIDUsage_Sim_ElectronicCountermeasures: self = .electronicCountermeasures
		case kHIDUsage_Sim_Elevator: self = .elevator
		case kHIDUsage_Sim_ElevatorTrim: self = .elevatorTrim
		case kHIDUsage_Sim_Rudder: self = .rudder
		case kHIDUsage_Sim_Throttle: self = .throttle
		case kHIDUsage_Sim_FlightCommunications: self = .flightCommunications
		case kHIDUsage_Sim_FlareRelease: self = .flareRelease
		case kHIDUsage_Sim_LandingGear: self = .landingGear
		case kHIDUsage_Sim_ToeBrake: self = .toeBrake
		case kHIDUsage_Sim_Trigger: self = .trigger
		case kHIDUsage_Sim_WeaponsArm: self = .weaponsArm
		case kHIDUsage_Sim_Weapons: self = .weapons
		case kHIDUsage_Sim_WingFlaps: self = .wingFlaps
		case kHIDUsage_Sim_Accelerator: self = .accelerator
		case kHIDUsage_Sim_Brake: self = .brake
		case kHIDUsage_Sim_Clutch: self = .clutch
		case kHIDUsage_Sim_Shifter: self = .shifter
		case kHIDUsage_Sim_Steering: self = .steering
		case kHIDUsage_Sim_TurretDirection: self = .turretDirection
		case kHIDUsage_Sim_BarrelElevation: self = .barrelElevation
		case kHIDUsage_Sim_DivePlane: self = .divePlane
		case kHIDUsage_Sim_Ballast: self = .ballast
		case kHIDUsage_Sim_BicycleCrank: self = .bicycleCrank
		case kHIDUsage_Sim_HandleBars: self = .handleBars
		case kHIDUsage_Sim_FrontBrake: self = .frontBrake
		case kHIDUsage_Sim_RearBrake: self = .rearBrake
		/* 0xD1 - 0xFFFF Reserved */
		case kHIDUsage_Sim_Reserved: self = .reserved(kHIDUsage_Sim_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/**
 VR Page (0x03)
 Virtual Reality controls depend on designators to identify the individual controls. Most of the following are
 usages are applied to the collections of entities that comprise the actual device.
 */
public enum VRUsage: IUsagePageUsage
{
	case undefined
	case belt /* Application Collection */
	case bodySuit /* Application Collection */
	case flexor /* Physical Collection */
	case glove /* Application Collection */
	case headTracker /* Physical Collection */
	case headMountedDisplay /* Application Collection */
	case handTracker /* Application Collection */
	case oculometer /* Application Collection */
	case vest /* Application Collection */
	case animatronicDevice /* Application Collection */
	/* 0x0B - 0x1F Reserved */
	case stereoEnable /* On/Off Control */
	case displayEnable /* On/Off Control */
	/* 0x22 - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_VR, kHIDUsage_Undefined)
		case .belt: return (kHIDPage_VR, kHIDUsage_VR_Belt) /* Application Collection */
		case .bodySuit: return (kHIDPage_VR, kHIDUsage_VR_BodySuit) /* Application Collection */
		case .flexor: return (kHIDPage_VR, kHIDUsage_VR_Flexor) /* Physical Collection */
		case .glove: return (kHIDPage_VR, kHIDUsage_VR_Glove) /* Application Collection */
		case .headTracker: return (kHIDPage_VR, kHIDUsage_VR_HeadTracker) /* Physical Collection */
		case .headMountedDisplay: return (kHIDPage_VR, kHIDUsage_VR_HeadMountedDisplay) /* Application Collection */
		case .handTracker: return (kHIDPage_VR, kHIDUsage_VR_HandTracker) /* Application Collection */
		case .oculometer: return (kHIDPage_VR, kHIDUsage_VR_Oculometer) /* Application Collection */
		case .vest: return (kHIDPage_VR, kHIDUsage_VR_Vest) /* Application Collection */
		case .animatronicDevice: return (kHIDPage_VR, kHIDUsage_VR_AnimatronicDevice) /* Application Collection */
		/* 0x0B - 0x1F Reserved */
		case .stereoEnable: return (kHIDPage_VR, kHIDUsage_VR_StereoEnable) /* On/Off Control */
		case .displayEnable: return (kHIDPage_VR, kHIDUsage_VR_DisplayEnable) /* On/Off Control */
		/* 0x22 - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_VR, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_VR_Belt: self = .belt
		case kHIDUsage_VR_BodySuit: self = .bodySuit
		case kHIDUsage_VR_Flexor: self = .flexor
		case kHIDUsage_VR_Glove: self = .glove
		case kHIDUsage_VR_HeadTracker: self = .headTracker
		case kHIDUsage_VR_HeadMountedDisplay: self = .headMountedDisplay
		case kHIDUsage_VR_HandTracker: self = .handTracker
		case kHIDUsage_VR_Oculometer: self = .oculometer
		case kHIDUsage_VR_Vest: self = .vest
		case kHIDUsage_VR_AnimatronicDevice: self = .animatronicDevice
		/* 0x0B - 0x1F Reserved */
		case kHIDUsage_VR_StereoEnable: self = .stereoEnable
		case kHIDUsage_VR_DisplayEnable: self = .displayEnable
		/* 0x22 - 0xFFFF Reserved */
		case kHIDUsage_VR_Reserved: self = .reserved(kHIDUsage_VR_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/** Sport Page (0x04) */
public enum SportUsage: IUsagePageUsage
{
	case undefined
	case baseballBat /* Application Collection */
	case golfClub /* Application Collection */
	case rowingMachine /* Application Collection */
	case treadmill /* Application Collection */
	/* 0x05 - 0x2F Reserved */
	case oar /* Dynamic Value */
	case slope /* Dynamic Value */
	case rate /* Dynamic Value */
	case stickSpeed /* Dynamic Value */
	case stickFaceAngle /* Dynamic Value */
	case stickHeelOrToe /* Dynamic Value */
	case stickFollowThrough /* Dynamic Value */
	case stickTempo /* Dynamic Value */
	case stickType /* Named Array */
	case stickHeight /* Dynamic Value */
	/* 0x3A - 0x4F Reserved */
	case putter /* Selector */
	case oneIron /* Selector */
	case twoIron /* Selector */
	case threeIron /* Selector */
	case fourIron /* Selector */
	case fiveIron /* Selector */
	case sixIron /* Selector */
	case sevenIron /* Selector */
	case eightIron /* Selector */
	case nineIron /* Selector */
	case tenIron /* Selector */
	case elevenIron /* Selector */
	case sandWedge /* Selector */
	case loftWedge /* Selector */
	case powerWedge /* Selector */
	case oneWood /* Selector */
	case threeWood /* Selector */
	case fiveWood /* Selector */
	case sevenWood /* Selector */
	case nineWood /* Selector */
	/* 0x64 - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Sport, kHIDUsage_Undefined)
		case .baseballBat: return (kHIDPage_Sport, kHIDUsage_Sprt_BaseballBat) /* Application Collection */
		case .golfClub: return (kHIDPage_Sport, kHIDUsage_Sprt_GolfClub) /* Application Collection */
		case .rowingMachine: return (kHIDPage_Sport, kHIDUsage_Sprt_RowingMachine) /* Application Collection */
		case .treadmill: return (kHIDPage_Sport, kHIDUsage_Sprt_Treadmill) /* Application Collection */
		/* 0x05 - 0x2F Reserved */
		case .oar: return (kHIDPage_Sport, kHIDUsage_Sprt_Oar) /* Dynamic Value */
		case .slope: return (kHIDPage_Sport, kHIDUsage_Sprt_Slope) /* Dynamic Value */
		case .rate: return (kHIDPage_Sport, kHIDUsage_Sprt_Rate) /* Dynamic Value */
		case .stickSpeed: return (kHIDPage_Sport, kHIDUsage_Sprt_StickSpeed) /* Dynamic Value */
		case .stickFaceAngle: return (kHIDPage_Sport, kHIDUsage_Sprt_StickFaceAngle) /* Dynamic Value */
		case .stickHeelOrToe: return (kHIDPage_Sport, kHIDUsage_Sprt_StickHeelOrToe) /* Dynamic Value */
		case .stickFollowThrough: return (kHIDPage_Sport, kHIDUsage_Sprt_StickFollowThrough) /* Dynamic Value */
		case .stickTempo: return (kHIDPage_Sport, kHIDUsage_Sprt_StickTempo) /* Dynamic Value */
		case .stickType: return (kHIDPage_Sport, kHIDUsage_Sprt_StickType) /* Named Array */
		case .stickHeight: return (kHIDPage_Sport, kHIDUsage_Sprt_StickHeight) /* Dynamic Value */
		/* 0x3A - 0x4F Reserved */
		case .putter: return (kHIDPage_Sport, kHIDUsage_Sprt_Putter) /* Selector */
		case .oneIron: return (kHIDPage_Sport, kHIDUsage_Sprt_1Iron) /* Selector */
		case .twoIron: return (kHIDPage_Sport, kHIDUsage_Sprt_2Iron) /* Selector */
		case .threeIron: return (kHIDPage_Sport, kHIDUsage_Sprt_3Iron) /* Selector */
		case .fourIron: return (kHIDPage_Sport, kHIDUsage_Sprt_4Iron) /* Selector */
		case .fiveIron: return (kHIDPage_Sport, kHIDUsage_Sprt_5Iron) /* Selector */
		case .sixIron: return (kHIDPage_Sport, kHIDUsage_Sprt_6Iron) /* Selector */
		case .sevenIron: return (kHIDPage_Sport, kHIDUsage_Sprt_7Iron) /* Selector */
		case .eightIron: return (kHIDPage_Sport, kHIDUsage_Sprt_8Iron) /* Selector */
		case .nineIron: return (kHIDPage_Sport, kHIDUsage_Sprt_9Iron) /* Selector */
		case .tenIron: return (kHIDPage_Sport, kHIDUsage_Sprt_10Iron) /* Selector */
		case .elevenIron: return (kHIDPage_Sport, kHIDUsage_Sprt_11Iron) /* Selector */
		case .sandWedge: return (kHIDPage_Sport, kHIDUsage_Sprt_SandWedge) /* Selector */
		case .loftWedge: return (kHIDPage_Sport, kHIDUsage_Sprt_LoftWedge) /* Selector */
		case .powerWedge: return (kHIDPage_Sport, kHIDUsage_Sprt_PowerWedge) /* Selector */
		case .oneWood: return (kHIDPage_Sport, kHIDUsage_Sprt_1Wood) /* Selector */
		case .threeWood: return (kHIDPage_Sport, kHIDUsage_Sprt_3Wood) /* Selector */
		case .fiveWood: return (kHIDPage_Sport, kHIDUsage_Sprt_5Wood) /* Selector */
		case .sevenWood: return (kHIDPage_Sport, kHIDUsage_Sprt_7Wood) /* Selector */
		case .nineWood: return (kHIDPage_Sport, kHIDUsage_Sprt_9Wood) /* Selector */
			/* 0x64 - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_Sport, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_Sprt_BaseballBat: self = .baseballBat
		case kHIDUsage_Sprt_GolfClub: self = .golfClub
		case kHIDUsage_Sprt_RowingMachine: self = .rowingMachine
		case kHIDUsage_Sprt_Treadmill: self = .treadmill
		/* 0x05 - 0x2F Reserved */
		case kHIDUsage_Sprt_Oar: self = .oar
		case kHIDUsage_Sprt_Slope: self = .slope
		case kHIDUsage_Sprt_Rate: self = .rate
		case kHIDUsage_Sprt_StickSpeed: self = .stickSpeed
		case kHIDUsage_Sprt_StickFaceAngle: self = .stickFaceAngle
		case kHIDUsage_Sprt_StickHeelOrToe: self = .stickHeelOrToe
		case kHIDUsage_Sprt_StickFollowThrough: self = .stickFollowThrough
		case kHIDUsage_Sprt_StickTempo: self = .stickTempo
		case kHIDUsage_Sprt_StickType: self = .stickType
		case kHIDUsage_Sprt_StickHeight: self = .stickHeight
		/* 0x3A - 0x4F Reserved */
		case kHIDUsage_Sprt_Putter: self = .putter
		case kHIDUsage_Sprt_1Iron: self = .oneIron
		case kHIDUsage_Sprt_2Iron: self = .twoIron
		case kHIDUsage_Sprt_3Iron: self = .threeIron
		case kHIDUsage_Sprt_4Iron: self = .fourIron
		case kHIDUsage_Sprt_5Iron: self = .fiveIron
		case kHIDUsage_Sprt_6Iron: self = .sixIron
		case kHIDUsage_Sprt_7Iron: self = .sevenIron
		case kHIDUsage_Sprt_8Iron: self = .eightIron
		case kHIDUsage_Sprt_9Iron: self = .nineIron
		case kHIDUsage_Sprt_10Iron: self = .tenIron
		case kHIDUsage_Sprt_11Iron: self = .elevenIron
		case kHIDUsage_Sprt_SandWedge: self = .sandWedge
		case kHIDUsage_Sprt_LoftWedge: self = .loftWedge
		case kHIDUsage_Sprt_PowerWedge: self = .powerWedge
		case kHIDUsage_Sprt_1Wood: self = .oneWood
		case kHIDUsage_Sprt_3Wood: self = .threeWood
		case kHIDUsage_Sprt_5Wood: self = .fiveWood
		case kHIDUsage_Sprt_7Wood: self = .sevenWood
		case kHIDUsage_Sprt_9Wood: self = .nineWood
		/* 0x64 - 0xFFFF Reserved */
		case kHIDUsage_Sprt_Reserved: self = .reserved(kHIDUsage_Sprt_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/** Game Page (0x05) */
public enum GameUsage: IUsagePageUsage
{
	case undefined
	case threeDGameController /* Application Collection */
	case pinballDevice /* Application Collection */
	case gunDevice /* Application Collection */
	/* 0x04 - 0x1F Reserved */
	case pointofView /* Physical Collection */
	case turnRightOrLeft /* Dynamic Value */
	case pitchUpOrDown /* Dynamic Value */
	case rollRightOrLeft /* Dynamic Value */
	case moveRightOrLeft /* Dynamic Value */
	case moveForwardOrBackward /* Dynamic Value */
	case moveUpOrDown /* Dynamic Value */
	case leanRightOrLeft /* Dynamic Value */
	case leanForwardOrBackward /* Dynamic Value */
	case heightOfPOV /* Dynamic Value */
	case flipper /* Momentary Control */
	case secondaryFlipper /* Momentary Control */
	case bump /* Momentary Control */
	case newGame /* One-Shot Control */
	case shootBall /* One-Shot Control */
	case player /* One-Shot Control */
	case gunBolt /* On/Off Control */
	case gunClip /* On/Off Control */
	case gun /* Selector */
	case gunSingleShot /* Selector */
	case gunBurst /* Selector */
	case gunAutomatic /* Selector */
	case gunSafety /* On/Off Control */
	case gamepadFireOrJump /* Logical Collection */
	case gamepadTrigger /* Logical Collection */
	/* 0x3A - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Game, kHIDUsage_Undefined)
		case .threeDGameController: return (kHIDPage_Game, kHIDUsage_Game_3DGameController) /* Application Collection */
		case .pinballDevice: return (kHIDPage_Game, kHIDUsage_Game_PinballDevice) /* Application Collection */
		case .gunDevice: return (kHIDPage_Game, kHIDUsage_Game_GunDevice) /* Application Collection */
		/* 0x04 - 0x1F Reserved */
		case .pointofView: return (kHIDPage_Game, kHIDUsage_Game_PointofView) /* Physical Collection */
		case .turnRightOrLeft: return (kHIDPage_Game, kHIDUsage_Game_TurnRightOrLeft) /* Dynamic Value */
		case .pitchUpOrDown: return (kHIDPage_Game, kHIDUsage_Game_PitchUpOrDown) /* Dynamic Value */
		case .rollRightOrLeft: return (kHIDPage_Game, kHIDUsage_Game_RollRightOrLeft) /* Dynamic Value */
		case .moveRightOrLeft: return (kHIDPage_Game, kHIDUsage_Game_MoveRightOrLeft) /* Dynamic Value */
		case .moveForwardOrBackward: return (kHIDPage_Game, kHIDUsage_Game_MoveForwardOrBackward) /* Dynamic Value */
		case .moveUpOrDown: return (kHIDPage_Game, kHIDUsage_Game_MoveUpOrDown) /* Dynamic Value */
		case .leanRightOrLeft: return (kHIDPage_Game, kHIDUsage_Game_LeanRightOrLeft) /* Dynamic Value */
		case .leanForwardOrBackward: return (kHIDPage_Game, kHIDUsage_Game_LeanForwardOrBackward) /* Dynamic Value */
		case .heightOfPOV: return (kHIDPage_Game, kHIDUsage_Game_HeightOfPOV) /* Dynamic Value */
		case .flipper: return (kHIDPage_Game, kHIDUsage_Game_Flipper) /* Momentary Control */
		case .secondaryFlipper: return (kHIDPage_Game, kHIDUsage_Game_SecondaryFlipper) /* Momentary Control */
		case .bump: return (kHIDPage_Game, kHIDUsage_Game_Bump) /* Momentary Control */
		case .newGame: return (kHIDPage_Game, kHIDUsage_Game_NewGame) /* One-Shot Control */
		case .shootBall: return (kHIDPage_Game, kHIDUsage_Game_ShootBall) /* One-Shot Control */
		case .player: return (kHIDPage_Game, kHIDUsage_Game_Player) /* One-Shot Control */
		case .gunBolt: return (kHIDPage_Game, kHIDUsage_Game_GunBolt) /* On/Off Control */
		case .gunClip: return (kHIDPage_Game, kHIDUsage_Game_GunClip) /* On/Off Control */
		case .gun: return (kHIDPage_Game, kHIDUsage_Game_Gun) /* Selector */
		case .gunSingleShot: return (kHIDPage_Game, kHIDUsage_Game_GunSingleShot) /* Selector */
		case .gunBurst: return (kHIDPage_Game, kHIDUsage_Game_GunBurst) /* Selector */
		case .gunAutomatic: return (kHIDPage_Game, kHIDUsage_Game_GunAutomatic) /* Selector */
		case .gunSafety: return (kHIDPage_Game, kHIDUsage_Game_GunSafety) /* On/Off Control */
		case .gamepadFireOrJump: return (kHIDPage_Game, kHIDUsage_Game_GamepadFireOrJump) /* Logical Collection */
		case .gamepadTrigger: return (kHIDPage_Game, kHIDUsage_Game_GamepadTrigger) /* Logical Collection */
		/* 0x3A - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_Game, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_Game_3DGameController: self = .threeDGameController
		case kHIDUsage_Game_PinballDevice: self = .pinballDevice
		case kHIDUsage_Game_GunDevice: self = .gunDevice
		/* 0x04 - 0x1F Reserved */
		case kHIDUsage_Game_PointofView: self = .pointofView
		case kHIDUsage_Game_TurnRightOrLeft: self = .turnRightOrLeft
		case kHIDUsage_Game_PitchUpOrDown: self = .pitchUpOrDown
		case kHIDUsage_Game_RollRightOrLeft: self = .rollRightOrLeft
		case kHIDUsage_Game_MoveRightOrLeft: self = .moveRightOrLeft
		case kHIDUsage_Game_MoveForwardOrBackward: self = .moveForwardOrBackward
		case kHIDUsage_Game_MoveUpOrDown: self = .moveUpOrDown
		case kHIDUsage_Game_LeanRightOrLeft: self = .leanRightOrLeft
		case kHIDUsage_Game_LeanForwardOrBackward: self = .leanForwardOrBackward
		case kHIDUsage_Game_HeightOfPOV: self = .heightOfPOV
		case kHIDUsage_Game_Flipper: self = .flipper
		case kHIDUsage_Game_SecondaryFlipper: self = .secondaryFlipper
		case kHIDUsage_Game_Bump: self = .bump
		case kHIDUsage_Game_NewGame: self = .newGame
		case kHIDUsage_Game_ShootBall: self = .shootBall
		case kHIDUsage_Game_Player: self = .player
		case kHIDUsage_Game_GunBolt: self = .gunBolt
		case kHIDUsage_Game_GunClip: self = .gunClip
		case kHIDUsage_Game_Gun: self = .gun
		case kHIDUsage_Game_GunSingleShot: self = .gunSingleShot
		case kHIDUsage_Game_GunBurst: self = .gunBurst
		case kHIDUsage_Game_GunAutomatic: self = .gunAutomatic
		case kHIDUsage_Game_GunSafety: self = .gunSafety
		case kHIDUsage_Game_GamepadFireOrJump: self = .gamepadFireOrJump
		case kHIDUsage_Game_GamepadTrigger: self = .gamepadTrigger
		/* 0x3A - 0xFFFF Reserved */
		case kHIDUsage_Game_Reserved: self = .reserved(kHIDUsage_Game_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/** Generic Device Controls (0x0g) */
public enum GenDevControlsUsage: IUsagePageUsage {
	case undefined
	case backgroundControls
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_GenericDeviceControls, kHIDUsage_Undefined);
		case .backgroundControls: return (kHIDPage_GenericDeviceControls, kHIDUsage_GenDevControls_BackgroundControls)
		case .reserved(let val): return (kHIDPage_GenericDeviceControls, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case 0: self = .undefined
		case kHIDUsage_GenDevControls_BackgroundControls: self = .backgroundControls
		default: self = .reserved(usage)
		}
	}
}

/**
 KeyboardOrKeypad Page (0x07)

 This section is the Usage Page for key codes to be used in implementing a USB keyboard. A Boot Keyboard (84-, 101- or 104-key) should at a minimum support all associated usage codes as indicated in the 'Boot' column below.

 The usage type of all key codes is Selectors (Sel), except for the modifier keys Keyboard Left Control (0x224) to Keyboard Right GUI (0x231) which are Dynamic Flags (DV).

 Note: A general note on Usages and languages: Due to the variation of keyboards from language to language, it is not feasible to specify exact key mappings for every language. Where this list is not specific for a key function in a language, the closest equivalent key position should be used, so that a keyboard may be modified for a different language by simply printing different keycaps. One example is the Y key on a North American keyboard. In Germany this is typically Z. Rather than changing the keyboard firmware to put the Z Usage into that place in the descriptor list, the vendor should use the Y Usage on both the North American and German keyboards. This continues to be the existing practice in the industry, in order to minimize the number of changes to the electronics to accommodate otherlanguages.
 */
public enum KeyboardOrKeypadUsage: IUsagePageUsage
{
	case undefined
	case keyboardErrorRollOver /* ErrorRollOver */
	case keyboardPOSTFail /* POSTFail */
	case keyboardErrorUndefined /* ErrorUndefined */
	case keyboardA /* a or A */
	case keyboardB /* b or B */
	case keyboardC /* c or C */
	case keyboardD /* d or D */
	case keyboardE /* e or E */
	case keyboardF /* f or F */
	case keyboardG /* g or G */
	case keyboardH /* h or H */
	case keyboardI /* i or I */
	case keyboardJ /* j or J */
	case keyboardK /* k or K */
	case keyboardL /* l or L */
	case keyboardM /* m or M */
	case keyboardN /* n or N */
	case keyboardO /* o or O */
	case keyboardP /* p or P */
	case keyboardQ /* q or Q */
	case keyboardR /* r or R */
	case keyboardS /* s or S */
	case keyboardT /* t or T */
	case keyboardU /* u or U */
	case keyboardV /* v or V */
	case keyboardW /* w or W */
	case keyboardX /* x or X */
	case keyboardY /* y or Y */
	case keyboardZ /* z or Z */
	case keyboard1 /* 1 or ! */
	case keyboard2 /* 2 or @ */
	case keyboard3 /* 3 or # */
	case keyboard4 /* 4 or $ */
	case keyboard5 /* 5 or % */
	case keyboard6 /* 6 or ^ */
	case keyboard7 /* 7 or & */
	case keyboard8 /* 8 or * */
	case keyboard9 /* 9 or ( */
	case keyboard0 /* 0 or ) */
	case keyboardReturnOrEnter /* Return (Enter) */
	case keyboardEscape /* Escape */
	case keyboardDeleteOrBackspace /* Delete (Backspace) */
	case keyboardTab /* Tab */
	case keyboardSpacebar /* Spacebar */
	case keyboardHyphen /* - or _ */
	case keyboardEqualSign /* = or + */
	case keyboardOpenBracket /* [ or { */
	case keyboardCloseBracket /* ] or } */
	case keyboardBackslash /* \ or | */
	case keyboardNonUSPound /* Non-US # or _ */
	case keyboardSemicolon /* ; or : */
	case keyboardQuote /* ' or " */
	case keyboardGraveAccentAndTilde /* Grave Accent and Tilde */
	case keyboardComma /* , or < */
	case keyboardPeriod /* . or > */
	case keyboardSlash /* / or ? */
	case keyboardCapsLock /* Caps Lock */
	case keyboardF1 /* F1 */
	case keyboardF2 /* F2 */
	case keyboardF3 /* F3 */
	case keyboardF4 /* F4 */
	case keyboardF5 /* F5 */
	case keyboardF6 /* F6 */
	case keyboardF7 /* F7 */
	case keyboardF8 /* F8 */
	case keyboardF9 /* F9 */
	case keyboardF10 /* F10 */
	case keyboardF11 /* F11 */
	case keyboardF12 /* F12 */
	case keyboardPrintScreen /* Print Screen */
	case keyboardScrollLock /* Scroll Lock */
	case keyboardPause /* Pause */
	case keyboardInsert /* Insert */
	case keyboardHome /* Home */
	case keyboardPageUp /* Page Up */
	case keyboardDeleteForward /* Delete Forward */
	case keyboardEnd /* End */
	case keyboardPageDown /* Page Down */
	case keyboardRightArrow /* Right Arrow */
	case keyboardLeftArrow /* Left Arrow */
	case keyboardDownArrow /* Down Arrow */
	case keyboardUpArrow /* Up Arrow */
	case keypadNumLock /* Keypad NumLock or Clear */
	case keypadSlash /* Keypad / */
	case keypadAsterisk /* Keypad * */
	case keypadHyphen /* Keypad - */
	case keypadPlus /* Keypad + */
	case keypadEnter /* Keypad Enter */
	case keypad1 /* Keypad 1 or End */
	case keypad2 /* Keypad 2 or Down Arrow */
	case keypad3 /* Keypad 3 or Page Down */
	case keypad4 /* Keypad 4 or Left Arrow */
	case keypad5 /* Keypad 5 */
	case keypad6 /* Keypad 6 or Right Arrow */
	case keypad7 /* Keypad 7 or Home */
	case keypad8 /* Keypad 8 or Up Arrow */
	case keypad9 /* Keypad 9 or Page Up */
	case keypad0 /* Keypad 0 or Insert */
	case keypadPeriod /* Keypad . or Delete */
	case keyboardNonUSBackslash /* Non-US \ or | */
	case keyboardApplication /* Application */
	case keyboardPower /* Power */
	case keypadEqualSign /* Keypad = */
	case keyboardF13 /* F13 */
	case keyboardF14 /* F14 */
	case keyboardF15 /* F15 */
	case keyboardF16 /* F16 */
	case keyboardF17 /* F17 */
	case keyboardF18 /* F18 */
	case keyboardF19 /* F19 */
	case keyboardF20 /* F20 */
	case keyboardF21 /* F21 */
	case keyboardF22 /* F22 */
	case keyboardF23 /* F23 */
	case keyboardF24 /* F24 */
	case keyboardExecute /* Execute */
	case keyboardHelp /* Help */
	case keyboardMenu /* Menu */
	case keyboardSelect /* Select */
	case keyboardStop /* Stop */
	case keyboardAgain /* Again */
	case keyboardUndo /* Undo */
	case keyboardCut /* Cut */
	case keyboardCopy /* Copy */
	case keyboardPaste /* Paste */
	case keyboardFind /* Find */
	case keyboardMute /* Mute */
	case keyboardVolumeUp /* Volume Up */
	case keyboardVolumeDown /* Volume Down */
	case keyboardLockingCapsLock /* Locking Caps Lock */
	case keyboardLockingNumLock /* Locking Num Lock */
	case keyboardLockingScrollLock /* Locking Scroll Lock */
	case keypadComma /* Keypad Comma */
	case keypadEqualSignAS400 /* Keypad Equal Sign for AS/400 */
	case keyboardInternational1 /* International1 */
	case keyboardInternational2 /* International2 */
	case keyboardInternational3 /* International3 */
	case keyboardInternational4 /* International4 */
	case keyboardInternational5 /* International5 */
	case keyboardInternational6 /* International6 */
	case keyboardInternational7 /* International7 */
	case keyboardInternational8 /* International8 */
	case keyboardInternational9 /* International9 */
	case keyboardLANG1 /* LANG1 */
	case keyboardLANG2 /* LANG2 */
	case keyboardLANG3 /* LANG3 */
	case keyboardLANG4 /* LANG4 */
	case keyboardLANG5 /* LANG5 */
	case keyboardLANG6 /* LANG6 */
	case keyboardLANG7 /* LANG7 */
	case keyboardLANG8 /* LANG8 */
	case keyboardLANG9 /* LANG9 */
	case keyboardAlternateErase /* AlternateErase */
	case keyboardSysReqOrAttention /* SysReq/Attention */
	case keyboardCancel /* Cancel */
	case keyboardClear /* Clear */
	case keyboardPrior /* Prior */
	case keyboardReturn /* Return */
	case keyboardSeparator /* Separator */
	case keyboardOut /* Out */
	case keyboardOper /* Oper */
	case keyboardClearOrAgain /* Clear/Again */
	case keyboardCrSelOrProps /* CrSel/Props */
	case keyboardExSel /* ExSel */
	/* 0xA5-0xDF Reserved */
	case keyboardLeftControl /* Left Control */
	case keyboardLeftShift /* Left Shift */
	case keyboardLeftAlt /* Left Alt */
	case keyboardLeftGUI /* Left GUI */
	case keyboardRightControl /* Right Control */
	case keyboardRightShift /* Right Shift */
	case keyboardRightAlt /* Right Alt */
	case keyboardRightGUI /* Right GUI */
	/* 0xE8-0xFFFF Reserved */
	case keyboard_Reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Undefined)
		case .keyboardErrorRollOver: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardErrorRollOver) /* ErrorRollOver */
		case .keyboardPOSTFail: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPOSTFail) /* POSTFail */
		case .keyboardErrorUndefined: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardErrorUndefined) /* ErrorUndefined */
		case .keyboardA: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardA) /* a or A */
		case .keyboardB: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardB) /* b or B */
		case .keyboardC: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardC) /* c or C */
		case .keyboardD: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardD) /* d or D */
		case .keyboardE: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardE) /* e or E */
		case .keyboardF: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF) /* f or F */
		case .keyboardG: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardG) /* g or G */
		case .keyboardH: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardH) /* h or H */
		case .keyboardI: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardI) /* i or I */
		case .keyboardJ: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardJ) /* j or J */
		case .keyboardK: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardK) /* k or K */
		case .keyboardL: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardL) /* l or L */
		case .keyboardM: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardM) /* m or M */
		case .keyboardN: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardN) /* n or N */
		case .keyboardO: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardO) /* o or O */
		case .keyboardP: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardP) /* p or P */
		case .keyboardQ: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardQ) /* q or Q */
		case .keyboardR: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardR) /* r or R */
		case .keyboardS: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardS) /* s or S */
		case .keyboardT: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardT) /* t or T */
		case .keyboardU: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardU) /* u or U */
		case .keyboardV: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardV) /* v or V */
		case .keyboardW: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardW) /* w or W */
		case .keyboardX: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardX) /* x or X */
		case .keyboardY: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardY) /* y or Y */
		case .keyboardZ: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardZ) /* z or Z */
		case .keyboard1: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard1) /* 1 or ! */
		case .keyboard2: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard2) /* 2 or @ */
		case .keyboard3: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard3) /* 3 or # */
		case .keyboard4: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard4) /* 4 or $ */
		case .keyboard5: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard5) /* 5 or % */
		case .keyboard6: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard6) /* 6 or ^ */
		case .keyboard7: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard7) /* 7 or & */
		case .keyboard8: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard8) /* 8 or * */
		case .keyboard9: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard9) /* 9 or ( */
		case .keyboard0: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keyboard0) /* 0 or ) */
		case .keyboardReturnOrEnter: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardReturnOrEnter) /* Return (Enter) */
		case .keyboardEscape: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardEscape) /* Escape */
		case .keyboardDeleteOrBackspace: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardDeleteOrBackspace) /* Delete (Backspace) */
		case .keyboardTab: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardTab) /* Tab */
		case .keyboardSpacebar: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardSpacebar) /* Spacebar */
		case .keyboardHyphen: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardHyphen) /* - or _ */
		case .keyboardEqualSign: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardEqualSign) /* = or + */
		case .keyboardOpenBracket: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardOpenBracket) /* [ or { */
		case .keyboardCloseBracket: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardCloseBracket) /* ] or } */
		case .keyboardBackslash: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardBackslash) /* \ or | */
		case .keyboardNonUSPound: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardNonUSPound) /* Non-US # or _ */
		case .keyboardSemicolon: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardSemicolon) /* ; or : */
		case .keyboardQuote: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardQuote) /* ' or " */
		case .keyboardGraveAccentAndTilde: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardGraveAccentAndTilde) /* Grave Accent and Tilde */
		case .keyboardComma: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardComma) /* , or < */
		case .keyboardPeriod: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPeriod) /* . or > */
		case .keyboardSlash: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardSlash) /* / or ? */
		case .keyboardCapsLock: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardCapsLock) /* Caps Lock */
		case .keyboardF1: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF1) /* F1 */
		case .keyboardF2: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF2) /* F2 */
		case .keyboardF3: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF3) /* F3 */
		case .keyboardF4: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF4) /* F4 */
		case .keyboardF5: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF5) /* F5 */
		case .keyboardF6: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF6) /* F6 */
		case .keyboardF7: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF7) /* F7 */
		case .keyboardF8: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF8) /* F8 */
		case .keyboardF9: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF9) /* F9 */
		case .keyboardF10: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF10) /* F10 */
		case .keyboardF11: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF11) /* F11 */
		case .keyboardF12: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF12) /* F12 */
		case .keyboardPrintScreen: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPrintScreen) /* Print Screen */
		case .keyboardScrollLock: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardScrollLock) /* Scroll Lock */
		case .keyboardPause: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPause) /* Pause */
		case .keyboardInsert: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInsert) /* Insert */
		case .keyboardHome: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardHome) /* Home */
		case .keyboardPageUp: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPageUp) /* Page Up */
		case .keyboardDeleteForward: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardDeleteForward) /* Delete Forward */
		case .keyboardEnd: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardEnd) /* End */
		case .keyboardPageDown: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPageDown) /* Page Down */
		case .keyboardRightArrow: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardRightArrow) /* Right Arrow */
		case .keyboardLeftArrow: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLeftArrow) /* Left Arrow */
		case .keyboardDownArrow: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardDownArrow) /* Down Arrow */
		case .keyboardUpArrow: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardUpArrow) /* Up Arrow */
		case .keypadNumLock: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadNumLock) /* Keypad NumLock or Clear */
		case .keypadSlash: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadSlash) /* Keypad / */
		case .keypadAsterisk: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadAsterisk) /* Keypad * */
		case .keypadHyphen: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadHyphen) /* Keypad - */
		case .keypadPlus: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadPlus) /* Keypad + */
		case .keypadEnter: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadEnter) /* Keypad Enter */
		case .keypad1: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad1) /* Keypad 1 or End */
		case .keypad2: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad2) /* Keypad 2 or Down Arrow */
		case .keypad3: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad3) /* Keypad 3 or Page Down */
		case .keypad4: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad4) /* Keypad 4 or Left Arrow */
		case .keypad5: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad5) /* Keypad 5 */
		case .keypad6: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad6) /* Keypad 6 or Right Arrow */
		case .keypad7: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad7) /* Keypad 7 or Home */
		case .keypad8: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad8) /* Keypad 8 or Up Arrow */
		case .keypad9: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad9) /* Keypad 9 or Page Up */
		case .keypad0: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_Keypad0) /* Keypad 0 or Insert */
		case .keypadPeriod: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadPeriod) /* Keypad . or Delete */
		case .keyboardNonUSBackslash: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardNonUSBackslash) /* Non-US \ or | */
		case .keyboardApplication: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardApplication) /* Application */
		case .keyboardPower: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPower) /* Power */
		case .keypadEqualSign: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadEqualSign) /* Keypad = */
		case .keyboardF13: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF13) /* F13 */
		case .keyboardF14: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF14) /* F14 */
		case .keyboardF15: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF15) /* F15 */
		case .keyboardF16: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF16) /* F16 */
		case .keyboardF17: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF17) /* F17 */
		case .keyboardF18: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF18) /* F18 */
		case .keyboardF19: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF19) /* F19 */
		case .keyboardF20: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF20) /* F20 */
		case .keyboardF21: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF21) /* F21 */
		case .keyboardF22: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF22) /* F22 */
		case .keyboardF23: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF23) /* F23 */
		case .keyboardF24: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardF24) /* F24 */
		case .keyboardExecute: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardExecute) /* Execute */
		case .keyboardHelp: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardHelp) /* Help */
		case .keyboardMenu: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardMenu) /* Menu */
		case .keyboardSelect: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardSelect) /* Select */
		case .keyboardStop: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardStop) /* Stop */
		case .keyboardAgain: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardAgain) /* Again */
		case .keyboardUndo: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardUndo) /* Undo */
		case .keyboardCut: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardCut) /* Cut */
		case .keyboardCopy: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardCopy) /* Copy */
		case .keyboardPaste: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPaste) /* Paste */
		case .keyboardFind: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardFind) /* Find */
		case .keyboardMute: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardMute) /* Mute */
		case .keyboardVolumeUp: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardVolumeUp) /* Volume Up */
		case .keyboardVolumeDown: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardVolumeDown) /* Volume Down */
		case .keyboardLockingCapsLock: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLockingCapsLock) /* Locking Caps Lock */
		case .keyboardLockingNumLock: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLockingNumLock) /* Locking Num Lock */
		case .keyboardLockingScrollLock: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLockingScrollLock) /* Locking Scroll Lock */
		case .keypadComma: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadComma) /* Keypad Comma */
		case .keypadEqualSignAS400: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeypadEqualSignAS400) /* Keypad Equal Sign for AS/400 */
		case .keyboardInternational1: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational1) /* International1 */
		case .keyboardInternational2: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational2) /* International2 */
		case .keyboardInternational3: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational3) /* International3 */
		case .keyboardInternational4: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational4) /* International4 */
		case .keyboardInternational5: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational5) /* International5 */
		case .keyboardInternational6: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational6) /* International6 */
		case .keyboardInternational7: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational7) /* International7 */
		case .keyboardInternational8: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational8) /* International8 */
		case .keyboardInternational9: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardInternational9) /* International9 */
		case .keyboardLANG1: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG1) /* LANG1 */
		case .keyboardLANG2: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG2) /* LANG2 */
		case .keyboardLANG3: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG3) /* LANG3 */
		case .keyboardLANG4: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG4) /* LANG4 */
		case .keyboardLANG5: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG5) /* LANG5 */
		case .keyboardLANG6: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG6) /* LANG6 */
		case .keyboardLANG7: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG7) /* LANG7 */
		case .keyboardLANG8: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG8) /* LANG8 */
		case .keyboardLANG9: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLANG9) /* LANG9 */
		case .keyboardAlternateErase: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardAlternateErase) /* AlternateErase */
		case .keyboardSysReqOrAttention: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardSysReqOrAttention) /* SysReq/Attention */
		case .keyboardCancel: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardCancel) /* Cancel */
		case .keyboardClear: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardClear) /* Clear */
		case .keyboardPrior: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardPrior) /* Prior */
		case .keyboardReturn: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardReturn) /* Return */
		case .keyboardSeparator: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardSeparator) /* Separator */
		case .keyboardOut: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardOut) /* Out */
		case .keyboardOper: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardOper) /* Oper */
		case .keyboardClearOrAgain: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardClearOrAgain) /* Clear/Again */
		case .keyboardCrSelOrProps: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardCrSelOrProps) /* CrSel/Props */
		case .keyboardExSel: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardExSel) /* ExSel */
		/* 0xA5-0xDF Reserved */
		case .keyboardLeftControl: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLeftControl) /* Left Control */
		case .keyboardLeftShift: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLeftShift) /* Left Shift */
		case .keyboardLeftAlt: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLeftAlt) /* Left Alt */
		case .keyboardLeftGUI: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardLeftGUI) /* Left GUI */
		case .keyboardRightControl: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardRightControl) /* Right Control */
		case .keyboardRightShift: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardRightShift) /* Right Shift */
		case .keyboardRightAlt: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardRightAlt) /* Right Alt */
		case .keyboardRightGUI: return (kHIDPage_KeyboardOrKeypad, kHIDUsage_KeyboardRightGUI) /* Right GUI */
		/* 0xE8-0xFFFF Reserved */
		case .keyboard_Reserved(let val): return (kHIDPage_KeyboardOrKeypad, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_KeyboardErrorRollOver: self = .keyboardErrorRollOver
		case kHIDUsage_KeyboardPOSTFail: self = .keyboardPOSTFail
		case kHIDUsage_KeyboardErrorUndefined: self = .keyboardErrorUndefined
		case kHIDUsage_KeyboardA: self = .keyboardA
		case kHIDUsage_KeyboardB: self = .keyboardB
		case kHIDUsage_KeyboardC: self = .keyboardC
		case kHIDUsage_KeyboardD: self = .keyboardD
		case kHIDUsage_KeyboardE: self = .keyboardE
		case kHIDUsage_KeyboardF: self = .keyboardF
		case kHIDUsage_KeyboardG: self = .keyboardG
		case kHIDUsage_KeyboardH: self = .keyboardH
		case kHIDUsage_KeyboardI: self = .keyboardI
		case kHIDUsage_KeyboardJ: self = .keyboardJ
		case kHIDUsage_KeyboardK: self = .keyboardK
		case kHIDUsage_KeyboardL: self = .keyboardL
		case kHIDUsage_KeyboardM: self = .keyboardM
		case kHIDUsage_KeyboardN: self = .keyboardN
		case kHIDUsage_KeyboardO: self = .keyboardO
		case kHIDUsage_KeyboardP: self = .keyboardP
		case kHIDUsage_KeyboardQ: self = .keyboardQ
		case kHIDUsage_KeyboardR: self = .keyboardR
		case kHIDUsage_KeyboardS: self = .keyboardS
		case kHIDUsage_KeyboardT: self = .keyboardT
		case kHIDUsage_KeyboardU: self = .keyboardU
		case kHIDUsage_KeyboardV: self = .keyboardV
		case kHIDUsage_KeyboardW: self = .keyboardW
		case kHIDUsage_KeyboardX: self = .keyboardX
		case kHIDUsage_KeyboardY: self = .keyboardY
		case kHIDUsage_KeyboardZ: self = .keyboardZ
		case kHIDUsage_Keyboard1: self = .keyboard1
		case kHIDUsage_Keyboard2: self = .keyboard2
		case kHIDUsage_Keyboard3: self = .keyboard3
		case kHIDUsage_Keyboard4: self = .keyboard4
		case kHIDUsage_Keyboard5: self = .keyboard5
		case kHIDUsage_Keyboard6: self = .keyboard6
		case kHIDUsage_Keyboard7: self = .keyboard7
		case kHIDUsage_Keyboard8: self = .keyboard8
		case kHIDUsage_Keyboard9: self = .keyboard9
		case kHIDUsage_Keyboard0: self = .keyboard0
		case kHIDUsage_KeyboardReturnOrEnter: self = .keyboardReturnOrEnter
		case kHIDUsage_KeyboardEscape: self = .keyboardEscape
		case kHIDUsage_KeyboardDeleteOrBackspace: self = .keyboardDeleteOrBackspace
		case kHIDUsage_KeyboardTab: self = .keyboardTab
		case kHIDUsage_KeyboardSpacebar: self = .keyboardSpacebar
		case kHIDUsage_KeyboardHyphen: self = .keyboardHyphen
		case kHIDUsage_KeyboardEqualSign: self = .keyboardEqualSign
		case kHIDUsage_KeyboardOpenBracket: self = .keyboardOpenBracket
		case kHIDUsage_KeyboardCloseBracket: self = .keyboardCloseBracket
		case kHIDUsage_KeyboardBackslash: self = .keyboardBackslash
		case kHIDUsage_KeyboardNonUSPound: self = .keyboardNonUSPound
		case kHIDUsage_KeyboardSemicolon: self = .keyboardSemicolon
		case kHIDUsage_KeyboardQuote: self = .keyboardQuote
		case kHIDUsage_KeyboardGraveAccentAndTilde: self = .keyboardGraveAccentAndTilde
		case kHIDUsage_KeyboardComma: self = .keyboardComma
		case kHIDUsage_KeyboardPeriod: self = .keyboardPeriod
		case kHIDUsage_KeyboardSlash: self = .keyboardSlash
		case kHIDUsage_KeyboardCapsLock: self = .keyboardCapsLock
		case kHIDUsage_KeyboardF1: self = .keyboardF1
		case kHIDUsage_KeyboardF2: self = .keyboardF2
		case kHIDUsage_KeyboardF3: self = .keyboardF3
		case kHIDUsage_KeyboardF4: self = .keyboardF4
		case kHIDUsage_KeyboardF5: self = .keyboardF5
		case kHIDUsage_KeyboardF6: self = .keyboardF6
		case kHIDUsage_KeyboardF7: self = .keyboardF7
		case kHIDUsage_KeyboardF8: self = .keyboardF8
		case kHIDUsage_KeyboardF9: self = .keyboardF9
		case kHIDUsage_KeyboardF10: self = .keyboardF10
		case kHIDUsage_KeyboardF11: self = .keyboardF11
		case kHIDUsage_KeyboardF12: self = .keyboardF12
		case kHIDUsage_KeyboardPrintScreen: self = .keyboardPrintScreen
		case kHIDUsage_KeyboardScrollLock: self = .keyboardScrollLock
		case kHIDUsage_KeyboardPause: self = .keyboardPause
		case kHIDUsage_KeyboardInsert: self = .keyboardInsert
		case kHIDUsage_KeyboardHome: self = .keyboardHome
		case kHIDUsage_KeyboardPageUp: self = .keyboardPageUp
		case kHIDUsage_KeyboardDeleteForward: self = .keyboardDeleteForward
		case kHIDUsage_KeyboardEnd: self = .keyboardEnd
		case kHIDUsage_KeyboardPageDown: self = .keyboardPageDown
		case kHIDUsage_KeyboardRightArrow: self = .keyboardRightArrow
		case kHIDUsage_KeyboardLeftArrow: self = .keyboardLeftArrow
		case kHIDUsage_KeyboardDownArrow: self = .keyboardDownArrow
		case kHIDUsage_KeyboardUpArrow: self = .keyboardUpArrow
		case kHIDUsage_KeypadNumLock: self = .keypadNumLock
		case kHIDUsage_KeypadSlash: self = .keypadSlash
		case kHIDUsage_KeypadAsterisk: self = .keypadAsterisk
		case kHIDUsage_KeypadHyphen: self = .keypadHyphen
		case kHIDUsage_KeypadPlus: self = .keypadPlus
		case kHIDUsage_KeypadEnter: self = .keypadEnter
		case kHIDUsage_Keypad1: self = .keypad1
		case kHIDUsage_Keypad2: self = .keypad2
		case kHIDUsage_Keypad3: self = .keypad3
		case kHIDUsage_Keypad4: self = .keypad4
		case kHIDUsage_Keypad5: self = .keypad5
		case kHIDUsage_Keypad6: self = .keypad6
		case kHIDUsage_Keypad7: self = .keypad7
		case kHIDUsage_Keypad8: self = .keypad8
		case kHIDUsage_Keypad9: self = .keypad9
		case kHIDUsage_Keypad0: self = .keypad0
		case kHIDUsage_KeypadPeriod: self = .keypadPeriod
		case kHIDUsage_KeyboardNonUSBackslash: self = .keyboardNonUSBackslash
		case kHIDUsage_KeyboardApplication: self = .keyboardApplication
		case kHIDUsage_KeyboardPower: self = .keyboardPower
		case kHIDUsage_KeypadEqualSign: self = .keypadEqualSign
		case kHIDUsage_KeyboardF13: self = .keyboardF13
		case kHIDUsage_KeyboardF14: self = .keyboardF14
		case kHIDUsage_KeyboardF15: self = .keyboardF15
		case kHIDUsage_KeyboardF16: self = .keyboardF16
		case kHIDUsage_KeyboardF17: self = .keyboardF17
		case kHIDUsage_KeyboardF18: self = .keyboardF18
		case kHIDUsage_KeyboardF19: self = .keyboardF19
		case kHIDUsage_KeyboardF20: self = .keyboardF20
		case kHIDUsage_KeyboardF21: self = .keyboardF21
		case kHIDUsage_KeyboardF22: self = .keyboardF22
		case kHIDUsage_KeyboardF23: self = .keyboardF23
		case kHIDUsage_KeyboardF24: self = .keyboardF24
		case kHIDUsage_KeyboardExecute: self = .keyboardExecute
		case kHIDUsage_KeyboardHelp: self = .keyboardHelp
		case kHIDUsage_KeyboardMenu: self = .keyboardMenu
		case kHIDUsage_KeyboardSelect: self = .keyboardSelect
		case kHIDUsage_KeyboardStop: self = .keyboardStop
		case kHIDUsage_KeyboardAgain: self = .keyboardAgain
		case kHIDUsage_KeyboardUndo: self = .keyboardUndo
		case kHIDUsage_KeyboardCut: self = .keyboardCut
		case kHIDUsage_KeyboardCopy: self = .keyboardCopy
		case kHIDUsage_KeyboardPaste: self = .keyboardPaste
		case kHIDUsage_KeyboardFind: self = .keyboardFind
		case kHIDUsage_KeyboardMute: self = .keyboardMute
		case kHIDUsage_KeyboardVolumeUp: self = .keyboardVolumeUp
		case kHIDUsage_KeyboardVolumeDown: self = .keyboardVolumeDown
		case kHIDUsage_KeyboardLockingCapsLock: self = .keyboardLockingCapsLock
		case kHIDUsage_KeyboardLockingNumLock: self = .keyboardLockingNumLock
		case kHIDUsage_KeyboardLockingScrollLock: self = .keyboardLockingScrollLock
		case kHIDUsage_KeypadComma: self = .keypadComma
		case kHIDUsage_KeypadEqualSignAS400: self = .keypadEqualSignAS400
		case kHIDUsage_KeyboardInternational1: self = .keyboardInternational1
		case kHIDUsage_KeyboardInternational2: self = .keyboardInternational2
		case kHIDUsage_KeyboardInternational3: self = .keyboardInternational3
		case kHIDUsage_KeyboardInternational4: self = .keyboardInternational4
		case kHIDUsage_KeyboardInternational5: self = .keyboardInternational5
		case kHIDUsage_KeyboardInternational6: self = .keyboardInternational6
		case kHIDUsage_KeyboardInternational7: self = .keyboardInternational7
		case kHIDUsage_KeyboardInternational8: self = .keyboardInternational8
		case kHIDUsage_KeyboardInternational9: self = .keyboardInternational9
		case kHIDUsage_KeyboardLANG1: self = .keyboardLANG1
		case kHIDUsage_KeyboardLANG2: self = .keyboardLANG2
		case kHIDUsage_KeyboardLANG3: self = .keyboardLANG3
		case kHIDUsage_KeyboardLANG4: self = .keyboardLANG4
		case kHIDUsage_KeyboardLANG5: self = .keyboardLANG5
		case kHIDUsage_KeyboardLANG6: self = .keyboardLANG6
		case kHIDUsage_KeyboardLANG7: self = .keyboardLANG7
		case kHIDUsage_KeyboardLANG8: self = .keyboardLANG8
		case kHIDUsage_KeyboardLANG9: self = .keyboardLANG9
		case kHIDUsage_KeyboardAlternateErase: self = .keyboardAlternateErase
		case kHIDUsage_KeyboardSysReqOrAttention: self = .keyboardSysReqOrAttention
		case kHIDUsage_KeyboardCancel: self = .keyboardCancel
		case kHIDUsage_KeyboardClear: self = .keyboardClear
		case kHIDUsage_KeyboardPrior: self = .keyboardPrior
		case kHIDUsage_KeyboardReturn: self = .keyboardReturn
		case kHIDUsage_KeyboardSeparator: self = .keyboardSeparator
		case kHIDUsage_KeyboardOut: self = .keyboardOut
		case kHIDUsage_KeyboardOper: self = .keyboardOper
		case kHIDUsage_KeyboardClearOrAgain: self = .keyboardClearOrAgain
		case kHIDUsage_KeyboardCrSelOrProps: self = .keyboardCrSelOrProps
		case kHIDUsage_KeyboardExSel: self = .keyboardExSel
		/* 0xA5-0xDF Reserved */
		case kHIDUsage_KeyboardLeftControl: self = .keyboardLeftControl
		case kHIDUsage_KeyboardLeftShift: self = .keyboardLeftShift
		case kHIDUsage_KeyboardLeftAlt: self = .keyboardLeftAlt
		case kHIDUsage_KeyboardLeftGUI: self = .keyboardLeftGUI
		case kHIDUsage_KeyboardRightControl: self = .keyboardRightControl
		case kHIDUsage_KeyboardRightShift: self = .keyboardRightShift
		case kHIDUsage_KeyboardRightAlt: self = .keyboardRightAlt
		case kHIDUsage_KeyboardRightGUI: self = .keyboardRightGUI
		/* 0xE8-0xFFFF Reserved */
		case kHIDUsage_Keyboard_Reserved: self = .keyboard_Reserved(kHIDUsage_Keyboard_Reserved)
		default: self = .keyboard_Reserved(usage)
		}
	}
}

/**
 LEDs Page (0x08)

 An LED or indicator is implemented as an On/Off Control (OOF) using the 'Single button toggle' mode, where a value of 1 will turn on the indicator, and a value of 0 will turn it off. The exceptions are described below.
 */
public enum LEDsUsage: IUsagePageUsage
{
	case undefined
	case numLock /* On/Off Control */
	case capsLock /* On/Off Control */
	case scrollLock /* On/Off Control */
	case compose /* On/Off Control */
	case kana /* On/Off Control */
	case power /* On/Off Control */
	case shift /* On/Off Control */
	case doNotDisturb /* On/Off Control */
	case mute /* On/Off Control */
	case toneEnable /* On/Off Control */
	case highCutFilter /* On/Off Control */
	case lowCutFilter /* On/Off Control */
	case equalizerEnable /* On/Off Control */
	case soundFieldOn /* On/Off Control */
	case surroundOn /* On/Off Control */
	case ledRepeat /* On/Off Control */
	case stereo /* On/Off Control */
	case samplingRateDetect /* On/Off Control */
	case spinning /* On/Off Control */
	case cav /* On/Off Control */
	case clv /* On/Off Control */
	case recordingFormatDetect /* On/Off Control */
	case offHook /* On/Off Control */
	case ring /* On/Off Control */
	case messageWaiting /* On/Off Control */
	case dataMode /* On/Off Control */
	case batteryOperation /* On/Off Control */
	case batteryOK /* On/Off Control */
	case batteryLow /* On/Off Control */
	case speaker /* On/Off Control */
	case headSet /* On/Off Control */
	case hold /* On/Off Control */
	case microphone /* On/Off Control */
	case coverage /* On/Off Control */
	case nightMode /* On/Off Control */
	case sendCalls /* On/Off Control */
	case callPickup /* On/Off Control */
	case conference /* On/Off Control */
	case standBy /* On/Off Control */
	case cameraOn /* On/Off Control */
	case cameraOff /* On/Off Control */
	case onLine /* On/Off Control */
	case offLine /* On/Off Control */
	case busy /* On/Off Control */
	case ready /* On/Off Control */
	case paperOut /* On/Off Control */
	case paperJam /* On/Off Control */
	case remote /* On/Off Control */
	case forward /* On/Off Control */
	case reverse /* On/Off Control */
	case stop /* On/Off Control */
	case rewind /* On/Off Control */
	case fastForward /* On/Off Control */
	case play /* On/Off Control */
	case pause /* On/Off Control */
	case record /* On/Off Control */
	case error /* On/Off Control */
	case usage /* Selector */
	case usageInUseIndicator /* Usage Switch */
	case usageMultiModeIndicator /* Usage Modifier */
	case indicatorOn /* Selector */
	case indicatorFlash /* Selector */
	case indicatorSlowBlink /* Selector */
	case indicatorFastBlink /* Selector */
	case indicatorOff /* Selector */
	case flashOnTime /* Dynamic Value */
	case slowBlinkOnTime /* Dynamic Value */
	case slowBlinkOffTime /* Dynamic Value */
	case fastBlinkOnTime /* Dynamic Value */
	case fastBlinkOffTime /* Dynamic Value */
	case usageIndicatorColor /* Usage Modifier */
	case indicatorRed /* Selector */
	case indicatorGreen /* Selector */
	case indicatorAmber /* Selector */
	case genericIndicator /* On/Off Control */
	case systemSuspend /* On/Off Control */
	case externalPowerConnected /* On/Off Control */
	case playerIndicator /* Collection Logical */
	case player1 /* Selector */
	case player2 /* Selector */
	case player3 /* Selector */
	case player4 /* Selector */
	case player5 /* Selector */
	case player6 /* Selector */
	case player7 /* Selector */
	case player8 /* Selector */
	/* 0x57 - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_LEDs, kHIDUsage_Undefined)
		case .numLock: return (kHIDPage_LEDs, kHIDUsage_LED_NumLock) /* On/Off Control */
		case .capsLock: return (kHIDPage_LEDs, kHIDUsage_LED_CapsLock) /* On/Off Control */
		case .scrollLock: return (kHIDPage_LEDs, kHIDUsage_LED_ScrollLock) /* On/Off Control */
		case .compose: return (kHIDPage_LEDs, kHIDUsage_LED_Compose) /* On/Off Control */
		case .kana: return (kHIDPage_LEDs, kHIDUsage_LED_Kana) /* On/Off Control */
		case .power: return (kHIDPage_LEDs, kHIDUsage_LED_Power) /* On/Off Control */
		case .shift: return (kHIDPage_LEDs, kHIDUsage_LED_Shift) /* On/Off Control */
		case .doNotDisturb: return (kHIDPage_LEDs, kHIDUsage_LED_DoNotDisturb) /* On/Off Control */
		case .mute: return (kHIDPage_LEDs, kHIDUsage_LED_Mute) /* On/Off Control */
		case .toneEnable: return (kHIDPage_LEDs, kHIDUsage_LED_ToneEnable) /* On/Off Control */
		case .highCutFilter: return (kHIDPage_LEDs, kHIDUsage_LED_HighCutFilter) /* On/Off Control */
		case .lowCutFilter: return (kHIDPage_LEDs, kHIDUsage_LED_LowCutFilter) /* On/Off Control */
		case .equalizerEnable: return (kHIDPage_LEDs, kHIDUsage_LED_EqualizerEnable) /* On/Off Control */
		case .soundFieldOn: return (kHIDPage_LEDs, kHIDUsage_LED_SoundFieldOn) /* On/Off Control */
		case .surroundOn: return (kHIDPage_LEDs, kHIDUsage_LED_SurroundOn) /* On/Off Control */
		case .ledRepeat: return (kHIDPage_LEDs, kHIDUsage_LED_Repeat) /* On/Off Control */
		case .stereo: return (kHIDPage_LEDs, kHIDUsage_LED_Stereo) /* On/Off Control */
		case .samplingRateDetect: return (kHIDPage_LEDs, kHIDUsage_LED_SamplingRateDetect) /* On/Off Control */
		case .spinning: return (kHIDPage_LEDs, kHIDUsage_LED_Spinning) /* On/Off Control */
		case .cav: return (kHIDPage_LEDs, kHIDUsage_LED_CAV) /* On/Off Control */
		case .clv: return (kHIDPage_LEDs, kHIDUsage_LED_CLV) /* On/Off Control */
		case .recordingFormatDetect: return (kHIDPage_LEDs, kHIDUsage_LED_RecordingFormatDetect) /* On/Off Control */
		case .offHook: return (kHIDPage_LEDs, kHIDUsage_LED_OffHook) /* On/Off Control */
		case .ring: return (kHIDPage_LEDs, kHIDUsage_LED_Ring) /* On/Off Control */
		case .messageWaiting: return (kHIDPage_LEDs, kHIDUsage_LED_MessageWaiting) /* On/Off Control */
		case .dataMode: return (kHIDPage_LEDs, kHIDUsage_LED_DataMode) /* On/Off Control */
		case .batteryOperation: return (kHIDPage_LEDs, kHIDUsage_LED_BatteryOperation) /* On/Off Control */
		case .batteryOK: return (kHIDPage_LEDs, kHIDUsage_LED_BatteryOK) /* On/Off Control */
		case .batteryLow: return (kHIDPage_LEDs, kHIDUsage_LED_BatteryLow) /* On/Off Control */
		case .speaker: return (kHIDPage_LEDs, kHIDUsage_LED_Speaker) /* On/Off Control */
		case .headSet: return (kHIDPage_LEDs, kHIDUsage_LED_HeadSet) /* On/Off Control */
		case .hold: return (kHIDPage_LEDs, kHIDUsage_LED_Hold) /* On/Off Control */
		case .microphone: return (kHIDPage_LEDs, kHIDUsage_LED_Microphone) /* On/Off Control */
		case .coverage: return (kHIDPage_LEDs, kHIDUsage_LED_Coverage) /* On/Off Control */
		case .nightMode: return (kHIDPage_LEDs, kHIDUsage_LED_NightMode) /* On/Off Control */
		case .sendCalls: return (kHIDPage_LEDs, kHIDUsage_LED_SendCalls) /* On/Off Control */
		case .callPickup: return (kHIDPage_LEDs, kHIDUsage_LED_CallPickup) /* On/Off Control */
		case .conference: return (kHIDPage_LEDs, kHIDUsage_LED_Conference) /* On/Off Control */
		case .standBy: return (kHIDPage_LEDs, kHIDUsage_LED_StandBy) /* On/Off Control */
		case .cameraOn: return (kHIDPage_LEDs, kHIDUsage_LED_CameraOn) /* On/Off Control */
		case .cameraOff: return (kHIDPage_LEDs, kHIDUsage_LED_CameraOff) /* On/Off Control */
		case .onLine: return (kHIDPage_LEDs, kHIDUsage_LED_OnLine) /* On/Off Control */
		case .offLine: return (kHIDPage_LEDs, kHIDUsage_LED_OffLine) /* On/Off Control */
		case .busy: return (kHIDPage_LEDs, kHIDUsage_LED_Busy) /* On/Off Control */
		case .ready: return (kHIDPage_LEDs, kHIDUsage_LED_Ready) /* On/Off Control */
		case .paperOut: return (kHIDPage_LEDs, kHIDUsage_LED_PaperOut) /* On/Off Control */
		case .paperJam: return (kHIDPage_LEDs, kHIDUsage_LED_PaperJam) /* On/Off Control */
		case .remote: return (kHIDPage_LEDs, kHIDUsage_LED_Remote) /* On/Off Control */
		case .forward: return (kHIDPage_LEDs, kHIDUsage_LED_Forward) /* On/Off Control */
		case .reverse: return (kHIDPage_LEDs, kHIDUsage_LED_Reverse) /* On/Off Control */
		case .stop: return (kHIDPage_LEDs, kHIDUsage_LED_Stop) /* On/Off Control */
		case .rewind: return (kHIDPage_LEDs, kHIDUsage_LED_Rewind) /* On/Off Control */
		case .fastForward: return (kHIDPage_LEDs, kHIDUsage_LED_FastForward) /* On/Off Control */
		case .play: return (kHIDPage_LEDs, kHIDUsage_LED_Play) /* On/Off Control */
		case .pause: return (kHIDPage_LEDs, kHIDUsage_LED_Pause) /* On/Off Control */
		case .record: return (kHIDPage_LEDs, kHIDUsage_LED_Record) /* On/Off Control */
		case .error: return (kHIDPage_LEDs, kHIDUsage_LED_Error) /* On/Off Control */
		case .usage: return (kHIDPage_LEDs, kHIDUsage_LED_Usage) /* Selector */
		case .usageInUseIndicator: return (kHIDPage_LEDs, kHIDUsage_LED_UsageInUseIndicator) /* Usage Switch */
		case .usageMultiModeIndicator: return (kHIDPage_LEDs, kHIDUsage_LED_UsageMultiModeIndicator) /* Usage Modifier */
		case .indicatorOn: return (kHIDPage_LEDs, kHIDUsage_LED_IndicatorOn) /* Selector */
		case .indicatorFlash: return (kHIDPage_LEDs, kHIDUsage_LED_IndicatorFlash) /* Selector */
		case .indicatorSlowBlink: return (kHIDPage_LEDs, kHIDUsage_LED_IndicatorSlowBlink) /* Selector */
		case .indicatorFastBlink: return (kHIDPage_LEDs, kHIDUsage_LED_IndicatorFastBlink) /* Selector */
		case .indicatorOff: return (kHIDPage_LEDs, kHIDUsage_LED_IndicatorOff) /* Selector */
		case .flashOnTime: return (kHIDPage_LEDs, kHIDUsage_LED_FlashOnTime) /* Dynamic Value */
		case .slowBlinkOnTime: return (kHIDPage_LEDs, kHIDUsage_LED_SlowBlinkOnTime) /* Dynamic Value */
		case .slowBlinkOffTime: return (kHIDPage_LEDs, kHIDUsage_LED_SlowBlinkOffTime) /* Dynamic Value */
		case .fastBlinkOnTime: return (kHIDPage_LEDs, kHIDUsage_LED_FastBlinkOnTime) /* Dynamic Value */
		case .fastBlinkOffTime: return (kHIDPage_LEDs, kHIDUsage_LED_FastBlinkOffTime) /* Dynamic Value */
		case .usageIndicatorColor: return (kHIDPage_LEDs, kHIDUsage_LED_UsageIndicatorColor) /* Usage Modifier */
		case .indicatorRed: return (kHIDPage_LEDs, kHIDUsage_LED_IndicatorRed) /* Selector */
		case .indicatorGreen: return (kHIDPage_LEDs, kHIDUsage_LED_IndicatorGreen) /* Selector */
		case .indicatorAmber: return (kHIDPage_LEDs, kHIDUsage_LED_IndicatorAmber) /* Selector */
		case .genericIndicator: return (kHIDPage_LEDs, kHIDUsage_LED_GenericIndicator) /* On/Off Control */
		case .systemSuspend: return (kHIDPage_LEDs, kHIDUsage_LED_SystemSuspend) /* On/Off Control */
		case .externalPowerConnected: return (kHIDPage_LEDs, kHIDUsage_LED_ExternalPowerConnected) /* On/Off Control */
		case .playerIndicator: return (kHIDPage_LEDs, kHIDUsage_LED_PlayerIndicator) /* Collection Logical */
		case .player1: return (kHIDPage_LEDs, kHIDUsage_LED_Player1) /* Selector */
		case .player2: return (kHIDPage_LEDs, kHIDUsage_LED_Player2) /* Selector */
		case .player3: return (kHIDPage_LEDs, kHIDUsage_LED_Player3) /* Selector */
		case .player4: return (kHIDPage_LEDs, kHIDUsage_LED_Player4) /* Selector */
		case .player5: return (kHIDPage_LEDs, kHIDUsage_LED_Player5) /* Selector */
		case .player6: return (kHIDPage_LEDs, kHIDUsage_LED_Player6) /* Selector */
		case .player7: return (kHIDPage_LEDs, kHIDUsage_LED_Player7) /* Selector */
		case .player8: return (kHIDPage_LEDs, kHIDUsage_LED_Player8) /* Selector */
		/* 0x57 - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_LEDs, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_LED_NumLock: self = .numLock
		case kHIDUsage_LED_CapsLock: self = .capsLock
		case kHIDUsage_LED_ScrollLock: self = .scrollLock
		case kHIDUsage_LED_Compose: self = .compose
		case kHIDUsage_LED_Kana: self = .kana
		case kHIDUsage_LED_Power: self = .power
		case kHIDUsage_LED_Shift: self = .shift
		case kHIDUsage_LED_DoNotDisturb: self = .doNotDisturb
		case kHIDUsage_LED_Mute: self = .mute
		case kHIDUsage_LED_ToneEnable: self = .toneEnable
		case kHIDUsage_LED_HighCutFilter: self = .highCutFilter
		case kHIDUsage_LED_LowCutFilter: self = .lowCutFilter
		case kHIDUsage_LED_EqualizerEnable: self = .equalizerEnable
		case kHIDUsage_LED_SoundFieldOn: self = .soundFieldOn
		case kHIDUsage_LED_SurroundOn: self = .surroundOn
		case kHIDUsage_LED_Repeat: self = .ledRepeat
		case kHIDUsage_LED_Stereo: self = .stereo
		case kHIDUsage_LED_SamplingRateDetect: self = .samplingRateDetect
		case kHIDUsage_LED_Spinning: self = .spinning
		case kHIDUsage_LED_CAV: self = .cav
		case kHIDUsage_LED_CLV: self = .clv
		case kHIDUsage_LED_RecordingFormatDetect: self = .recordingFormatDetect
		case kHIDUsage_LED_OffHook: self = .offHook
		case kHIDUsage_LED_Ring: self = .ring
		case kHIDUsage_LED_MessageWaiting: self = .messageWaiting
		case kHIDUsage_LED_DataMode: self = .dataMode
		case kHIDUsage_LED_BatteryOperation: self = .batteryOperation
		case kHIDUsage_LED_BatteryOK: self = .batteryOK
		case kHIDUsage_LED_BatteryLow: self = .batteryLow
		case kHIDUsage_LED_Speaker: self = .speaker
		case kHIDUsage_LED_HeadSet: self = .headSet
		case kHIDUsage_LED_Hold: self = .hold
		case kHIDUsage_LED_Microphone: self = .microphone
		case kHIDUsage_LED_Coverage: self = .coverage
		case kHIDUsage_LED_NightMode: self = .nightMode
		case kHIDUsage_LED_SendCalls: self = .sendCalls
		case kHIDUsage_LED_CallPickup: self = .callPickup
		case kHIDUsage_LED_Conference: self = .conference
		case kHIDUsage_LED_StandBy: self = .standBy
		case kHIDUsage_LED_CameraOn: self = .cameraOn
		case kHIDUsage_LED_CameraOff: self = .cameraOff
		case kHIDUsage_LED_OnLine: self = .onLine
		case kHIDUsage_LED_OffLine: self = .offLine
		case kHIDUsage_LED_Busy: self = .busy
		case kHIDUsage_LED_Ready: self = .ready
		case kHIDUsage_LED_PaperOut: self = .paperOut
		case kHIDUsage_LED_PaperJam: self = .paperJam
		case kHIDUsage_LED_Remote: self = .remote
		case kHIDUsage_LED_Forward: self = .forward
		case kHIDUsage_LED_Reverse: self = .reverse
		case kHIDUsage_LED_Stop: self = .stop
		case kHIDUsage_LED_Rewind: self = .rewind
		case kHIDUsage_LED_FastForward: self = .fastForward
		case kHIDUsage_LED_Play: self = .play
		case kHIDUsage_LED_Pause: self = .pause
		case kHIDUsage_LED_Record: self = .record
		case kHIDUsage_LED_Error: self = .error
		case kHIDUsage_LED_Usage: self = .usage
		case kHIDUsage_LED_UsageInUseIndicator: self = .usageInUseIndicator
		case kHIDUsage_LED_UsageMultiModeIndicator: self = .usageMultiModeIndicator
		case kHIDUsage_LED_IndicatorOn: self = .indicatorOn
		case kHIDUsage_LED_IndicatorFlash: self = .indicatorFlash
		case kHIDUsage_LED_IndicatorSlowBlink: self = .indicatorSlowBlink
		case kHIDUsage_LED_IndicatorFastBlink: self = .indicatorFastBlink
		case kHIDUsage_LED_IndicatorOff: self = .indicatorOff
		case kHIDUsage_LED_FlashOnTime: self = .flashOnTime
		case kHIDUsage_LED_SlowBlinkOnTime: self = .slowBlinkOnTime
		case kHIDUsage_LED_SlowBlinkOffTime: self = .slowBlinkOffTime
		case kHIDUsage_LED_FastBlinkOnTime: self = .fastBlinkOnTime
		case kHIDUsage_LED_FastBlinkOffTime: self = .fastBlinkOffTime
		case kHIDUsage_LED_UsageIndicatorColor: self = .usageIndicatorColor
		case kHIDUsage_LED_IndicatorRed: self = .indicatorRed
		case kHIDUsage_LED_IndicatorGreen: self = .indicatorGreen
		case kHIDUsage_LED_IndicatorAmber: self = .indicatorAmber
		case kHIDUsage_LED_GenericIndicator: self = .genericIndicator
		case kHIDUsage_LED_SystemSuspend: self = .systemSuspend
		case kHIDUsage_LED_ExternalPowerConnected: self = .externalPowerConnected
		case kHIDUsage_LED_PlayerIndicator: self = .playerIndicator
		case kHIDUsage_LED_Player1: self = .player1
		case kHIDUsage_LED_Player2: self = .player2
		case kHIDUsage_LED_Player3: self = .player3
		case kHIDUsage_LED_Player4: self = .player4
		case kHIDUsage_LED_Player5: self = .player5
		case kHIDUsage_LED_Player6: self = .player6
		case kHIDUsage_LED_Player7: self = .player7
		case kHIDUsage_LED_Player8: self = .player8
		/* 0x57 - 0xFFFF Reserved */
		case kHIDUsage_LED_Reserved: self = .reserved(kHIDUsage_LED_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/**
 Button Page (0x09)

 The Button page is the first place an application should look for user selection controls. System graphical user interfaces typically employ a pointer and a set of hierarchical selectors to select, move and otherwise manipulate their environment. For these purposes the following assignment of significance can be applied to the Button usages:

 - Button 1, Primary Button. Used for object selecting, dragging, and double click activation. On MacOS, this is the only button. Microsoft operating systems call this a logical left button, because it is not necessarily physically located on the left of the pointing device.

 - Button 2, Secondary Button. Used by newer graphical user interfaces to browse object properties. Exposed by systems to applications that typically assign application-specific functionality.

 - Button 3, Tertiary Button. Optional control. Exposed to applications, but seldom assigned functionality due to prevalence of two- and one-button devices.

 - Buttons 4 -55. As the button number increases, its significance as a selector decreases.

 In many ways the assignment of button numbers is similar to the assignment of Effort in Physical descriptors. Button 1 would be used to define the button a finger rests on when the hand is in the 'at rest' position, that is, virtually no effort is required by the user to activate the button. Button values increment as the finger has to stretch to reach a control. See Section 6.2.3, 'Physical Descriptors,' in the HID Specification for methods of further qualifying buttons.
 */
public enum ButtonUsage: IUsagePageUsage
{
	case undefined
	case button1 /* (primary/trigger) */
	case button2 /* (secondary) */
	case button3 /* (tertiary) */
	case button(UInt16)
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Button, kHIDUsage_Undefined)
		case .button1: return (kHIDPage_Button, kHIDUsage_Button_1)
		case .button2: return (kHIDPage_Button, kHIDUsage_Button_2)
		case .button3: return (kHIDPage_Button, kHIDUsage_Button_3)
		case .button(let num): return (kHIDPage_Button, Int(num))
		case .reserved(let val): return (kHIDPage_Button, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_Button_1: self = .button1
		case kHIDUsage_Button_2: self = .button2
		case kHIDUsage_Button_3: self = .button3
		case let num where num <= Int(UInt16.max): self = .button(UInt16(num))
		default: self = .reserved(usage)
		}
	}
}

/**
 Ordinal Page (0x0A)

 The Ordinal page allows multiple instances of a control or sets of controls to be declared without requiring individual enumeration in the native usage page. For example, it is not necessary to declare usages of Pointer 1, Pointer 2, and so forth on the Generic Desktop page. When parsed, the ordinal instance number is, in essence, concatenated to the usages attached to the encompassing collection to create Pointer 1, Pointer 2, and so forth.

 For an example, see Section A.5, “Multiple Instances of a Control,” in Appendix A, “Usage Examples.” By convention, an Ordinal collection is placed inside the collection for which it is declaring multiple instances.

 Instances do not have to be identical.
 */
public enum OrdinalUsage: IUsagePageUsage
{
	case undefined
	case instance1 /* Usage Modifier */
	case instance2 /* Usage Modifier */
	case instance3 /* Usage Modifier */
	case instance4 /* Usage Modifier */
	case instance(UInt16) /* Usage Modifier */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Ordinal, kHIDUsage_Undefined)
		case .instance1: return (kHIDPage_Ordinal, kHIDUsage_Ord_Instance1) /* Usage Modifier */
		case .instance2: return (kHIDPage_Ordinal, kHIDUsage_Ord_Instance2) /* Usage Modifier */
		case .instance3: return (kHIDPage_Ordinal, kHIDUsage_Ord_Instance3) /* Usage Modifier */
		case .instance4: return (kHIDPage_Ordinal, kHIDUsage_Ord_Instance4) /* Usage Modifier */
		case .instance(let num): return (kHIDPage_Ordinal, Int(num)) /* Usage Modifier */
		case .reserved(let val): return (kHIDPage_Ordinal, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_Ord_Instance1: self = .instance1
		case kHIDUsage_Ord_Instance2: self = .instance2
		case kHIDUsage_Ord_Instance3: self = .instance3
		case kHIDUsage_Ord_Instance4: self = .instance4
		case let num where num <= Int(UInt16.max): self = .instance(UInt16(num))
		default: self = .reserved(usage)
		}
	}
}

/**
 Telephony Page (0x0B)

 This usage page defines the keytop and control usages for telephony devices.

 Indicators on a phone are handled by wrapping them in LED: Usage In Use Indicator and LED: Usage Selected Indicator usages. For example, a message-indicator LED would be identified by a Telephony: Message usage declared as a Feature or Output in a LED: Usage In Use Indicator collection.

 See Section 14, “Consumer Page (0x0C),” for audio volume and tone controls.
 */
public enum TelephonyUsage: IUsagePageUsage
{
	case undefined
	case phone /* Application Collection */
	case answeringMachine /* Application Collection */
	case messageControls /* Logical Collection */
	case handset /* Logical Collection */
	case headset /* Logical Collection */
	case telephonyKeyPad /* Named Array */
	case programmableButton /* Named Array */
	/* 0x08 - 0x1F Reserved */
	case hookSwitch /* On/Off Control */
	case flash /* Momentary Control */
	case feature /* One-Shot Control */
	case hold /* On/Off Control */
	case redial /* One-Shot Control */
	case transfer /* One-Shot Control */
	case drop /* One-Shot Control */
	case park /* On/Off Control */
	case forwardCalls /* On/Off Control */
	case alternateFunction /* Momentary Control */
	case line /* One-Shot Control */
	case speakerPhone /* On/Off Control */
	case conference /* On/Off Control */
	case ringEnable /* On/Off Control */
	case ring /* Selector */
	case phoneMute /* On/Off Control */
	case callerID /* Momentary Control */
	/* 0x31 - 0x4F Reserved */
	case speedDial /* One-Shot Control */
	case storeNumber /* One-Shot Control */
	case recallNumber /* One-Shot Control */
	case phoneDirectory /* On/Off Control */
	/* 0x54 - 0x6F Reserved */
	case voiceMail /* On/Off Control */
	case screenCalls /* On/Off Control */
	case doNotDisturb /* On/Off Control */
	case message /* One-Shot Control */
	case answerOnOrOff /* On/Off Control */
	/* 0x75 - 0x8F Reserved */
	case insideDialTone /* Momentary Control */
	case outsideDialTone /* Momentary Control */
	case insideRingTone /* Momentary Control */
	case outsideRingTone /* Momentary Control */
	case priorityRingTone /* Momentary Control */
	case insideRingback /* Momentary Control */
	case priorityRingback /* Momentary Control */
	case lineBusyTone /* Momentary Control */
	case reorderTone /* Momentary Control */
	case callWaitingTone /* Momentary Control */
	case confirmationTone1 /* Momentary Control */
	case confirmationTone2 /* Momentary Control */
	case tonesOff /* On/Off Control */
	case outsideRingback /* Momentary Control */
	/* 0x9E - 0xAF Reserved */
	case phoneKey0 /* Selector/One-Shot Control */
	case phoneKey1 /* Selector/One-Shot Control */
	case phoneKey2 /* Selector/One-Shot Control */
	case phoneKey3 /* Selector/One-Shot Control */
	case phoneKey4 /* Selector/One-Shot Control */
	case phoneKey5 /* Selector/One-Shot Control */
	case phoneKey6 /* Selector/One-Shot Control */
	case phoneKey7 /* Selector/One-Shot Control */
	case phoneKey8 /* Selector/One-Shot Control */
	case phoneKey9 /* Selector/One-Shot Control */
	case phoneKeyStar /* Selector/One-Shot Control */
	case phoneKeyPound /* Selector/One-Shot Control */
	case phoneKeyA /* Selector/One-Shot Control */
	case phoneKeyB /* Selector/One-Shot Control */
	case phoneKeyC /* Selector/One-Shot Control */
	case phoneKeyD /* Selector/One-Shot Control */
	/* 0xC0 - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Telephony, kHIDUsage_Undefined)
		case .phone: return (kHIDPage_Telephony, kHIDUsage_Tfon_Phone) /* Application Collection */
		case .answeringMachine: return (kHIDPage_Telephony, kHIDUsage_Tfon_AnsweringMachine) /* Application Collection */
		case .messageControls: return (kHIDPage_Telephony, kHIDUsage_Tfon_MessageControls) /* Logical Collection */
		case .handset: return (kHIDPage_Telephony, kHIDUsage_Tfon_Handset) /* Logical Collection */
		case .headset: return (kHIDPage_Telephony, kHIDUsage_Tfon_Headset) /* Logical Collection */
		case .telephonyKeyPad: return (kHIDPage_Telephony, kHIDUsage_Tfon_TelephonyKeyPad) /* Named Array */
		case .programmableButton: return (kHIDPage_Telephony, kHIDUsage_Tfon_ProgrammableButton) /* Named Array */
		/* 0x08 - 0x1F Reserved */
		case .hookSwitch: return (kHIDPage_Telephony, kHIDUsage_Tfon_HookSwitch) /* On/Off Control */
		case .flash: return (kHIDPage_Telephony, kHIDUsage_Tfon_Flash) /* Momentary Control */
		case .feature: return (kHIDPage_Telephony, kHIDUsage_Tfon_Feature) /* One-Shot Control */
		case .hold: return (kHIDPage_Telephony, kHIDUsage_Tfon_Hold) /* On/Off Control */
		case .redial: return (kHIDPage_Telephony, kHIDUsage_Tfon_Redial) /* One-Shot Control */
		case .transfer: return (kHIDPage_Telephony, kHIDUsage_Tfon_Transfer) /* One-Shot Control */
		case .drop: return (kHIDPage_Telephony, kHIDUsage_Tfon_Drop) /* One-Shot Control */
		case .park: return (kHIDPage_Telephony, kHIDUsage_Tfon_Park) /* On/Off Control */
		case .forwardCalls: return (kHIDPage_Telephony, kHIDUsage_Tfon_ForwardCalls) /* On/Off Control */
		case .alternateFunction: return (kHIDPage_Telephony, kHIDUsage_Tfon_AlternateFunction) /* Momentary Control */
		case .line: return (kHIDPage_Telephony, kHIDUsage_Tfon_Line) /* One-Shot Control */
		case .speakerPhone: return (kHIDPage_Telephony, kHIDUsage_Tfon_SpeakerPhone) /* On/Off Control */
		case .conference: return (kHIDPage_Telephony, kHIDUsage_Tfon_Conference) /* On/Off Control */
		case .ringEnable: return (kHIDPage_Telephony, kHIDUsage_Tfon_RingEnable) /* On/Off Control */
		case .ring: return (kHIDPage_Telephony, kHIDUsage_Tfon_Ring) /* Selector */
		case .phoneMute: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneMute) /* On/Off Control */
		case .callerID: return (kHIDPage_Telephony, kHIDUsage_Tfon_CallerID) /* Momentary Control */
		/* 0x31 - 0x4F Reserved */
		case .speedDial: return (kHIDPage_Telephony, kHIDUsage_Tfon_SpeedDial) /* One-Shot Control */
		case .storeNumber: return (kHIDPage_Telephony, kHIDUsage_Tfon_StoreNumber) /* One-Shot Control */
		case .recallNumber: return (kHIDPage_Telephony, kHIDUsage_Tfon_RecallNumber) /* One-Shot Control */
		case .phoneDirectory: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneDirectory) /* On/Off Control */
		/* 0x54 - 0x6F Reserved */
		case .voiceMail: return (kHIDPage_Telephony, kHIDUsage_Tfon_VoiceMail) /* On/Off Control */
		case .screenCalls: return (kHIDPage_Telephony, kHIDUsage_Tfon_ScreenCalls) /* On/Off Control */
		case .doNotDisturb: return (kHIDPage_Telephony, kHIDUsage_Tfon_DoNotDisturb) /* On/Off Control */
		case .message: return (kHIDPage_Telephony, kHIDUsage_Tfon_Message) /* One-Shot Control */
		case .answerOnOrOff: return (kHIDPage_Telephony, kHIDUsage_Tfon_AnswerOnOrOff) /* On/Off Control */
		/* 0x75 - 0x8F Reserved */
		case .insideDialTone: return (kHIDPage_Telephony, kHIDUsage_Tfon_InsideDialTone) /* Momentary Control */
		case .outsideDialTone: return (kHIDPage_Telephony, kHIDUsage_Tfon_OutsideDialTone) /* Momentary Control */
		case .insideRingTone: return (kHIDPage_Telephony, kHIDUsage_Tfon_InsideRingTone) /* Momentary Control */
		case .outsideRingTone: return (kHIDPage_Telephony, kHIDUsage_Tfon_OutsideRingTone) /* Momentary Control */
		case .priorityRingTone: return (kHIDPage_Telephony, kHIDUsage_Tfon_PriorityRingTone) /* Momentary Control */
		case .insideRingback: return (kHIDPage_Telephony, kHIDUsage_Tfon_InsideRingback) /* Momentary Control */
		case .priorityRingback: return (kHIDPage_Telephony, kHIDUsage_Tfon_PriorityRingback) /* Momentary Control */
		case .lineBusyTone: return (kHIDPage_Telephony, kHIDUsage_Tfon_LineBusyTone) /* Momentary Control */
		case .reorderTone: return (kHIDPage_Telephony, kHIDUsage_Tfon_ReorderTone) /* Momentary Control */
		case .callWaitingTone: return (kHIDPage_Telephony, kHIDUsage_Tfon_CallWaitingTone) /* Momentary Control */
		case .confirmationTone1: return (kHIDPage_Telephony, kHIDUsage_Tfon_ConfirmationTone1) /* Momentary Control */
		case .confirmationTone2: return (kHIDPage_Telephony, kHIDUsage_Tfon_ConfirmationTone2) /* Momentary Control */
		case .tonesOff: return (kHIDPage_Telephony, kHIDUsage_Tfon_TonesOff) /* On/Off Control */
		case .outsideRingback: return (kHIDPage_Telephony, kHIDUsage_Tfon_OutsideRingback) /* Momentary Control */
		/* 0x9E - 0xAF Reserved */
		case .phoneKey0: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey0) /* Selector/One-Shot Control */
		case .phoneKey1: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey1) /* Selector/One-Shot Control */
		case .phoneKey2: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey2) /* Selector/One-Shot Control */
		case .phoneKey3: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey3) /* Selector/One-Shot Control */
		case .phoneKey4: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey4) /* Selector/One-Shot Control */
		case .phoneKey5: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey5) /* Selector/One-Shot Control */
		case .phoneKey6: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey6) /* Selector/One-Shot Control */
		case .phoneKey7: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey7) /* Selector/One-Shot Control */
		case .phoneKey8: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey8) /* Selector/One-Shot Control */
		case .phoneKey9: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKey9) /* Selector/One-Shot Control */
		case .phoneKeyStar: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKeyStar) /* Selector/One-Shot Control */
		case .phoneKeyPound: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKeyPound) /* Selector/One-Shot Control */
		case .phoneKeyA: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKeyA) /* Selector/One-Shot Control */
		case .phoneKeyB: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKeyB) /* Selector/One-Shot Control */
		case .phoneKeyC: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKeyC) /* Selector/One-Shot Control */
		case .phoneKeyD: return (kHIDPage_Telephony, kHIDUsage_Tfon_PhoneKeyD) /* Selector/One-Shot Control */
		/* 0xC0 - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_Telephony, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_Tfon_Phone: self = .phone
		case kHIDUsage_Tfon_AnsweringMachine: self = .answeringMachine
		case kHIDUsage_Tfon_MessageControls: self = .messageControls
		case kHIDUsage_Tfon_Handset: self = .handset
		case kHIDUsage_Tfon_Headset: self = .headset
		case kHIDUsage_Tfon_TelephonyKeyPad: self = .telephonyKeyPad
		case kHIDUsage_Tfon_ProgrammableButton: self = .programmableButton
		/* 0x08 - 0x1F Reserved */
		case kHIDUsage_Tfon_HookSwitch: self = .hookSwitch
		case kHIDUsage_Tfon_Flash: self = .flash
		case kHIDUsage_Tfon_Feature: self = .feature
		case kHIDUsage_Tfon_Hold: self = .hold
		case kHIDUsage_Tfon_Redial: self = .redial
		case kHIDUsage_Tfon_Transfer: self = .transfer
		case kHIDUsage_Tfon_Drop: self = .drop
		case kHIDUsage_Tfon_Park: self = .park
		case kHIDUsage_Tfon_ForwardCalls: self = .forwardCalls
		case kHIDUsage_Tfon_AlternateFunction: self = .alternateFunction
		case kHIDUsage_Tfon_Line: self = .line
		case kHIDUsage_Tfon_SpeakerPhone: self = .speakerPhone
		case kHIDUsage_Tfon_Conference: self = .conference
		case kHIDUsage_Tfon_RingEnable: self = .ringEnable
		case kHIDUsage_Tfon_Ring: self = .ring
		case kHIDUsage_Tfon_PhoneMute: self = .phoneMute
		case kHIDUsage_Tfon_CallerID: self = .callerID
		/* 0x31 - 0x4F Reserved */
		case kHIDUsage_Tfon_SpeedDial: self = .speedDial
		case kHIDUsage_Tfon_StoreNumber: self = .storeNumber
		case kHIDUsage_Tfon_RecallNumber: self = .recallNumber
		case kHIDUsage_Tfon_PhoneDirectory: self = .phoneDirectory
		/* 0x54 - 0x6F Reserved */
		case kHIDUsage_Tfon_VoiceMail: self = .voiceMail
		case kHIDUsage_Tfon_ScreenCalls: self = .screenCalls
		case kHIDUsage_Tfon_DoNotDisturb: self = .doNotDisturb
		case kHIDUsage_Tfon_Message: self = .message
		case kHIDUsage_Tfon_AnswerOnOrOff: self = .answerOnOrOff
		/* 0x75 - 0x8F Reserved */
		case kHIDUsage_Tfon_InsideDialTone: self = .insideDialTone
		case kHIDUsage_Tfon_OutsideDialTone: self = .outsideDialTone
		case kHIDUsage_Tfon_InsideRingTone: self = .insideRingTone
		case kHIDUsage_Tfon_OutsideRingTone: self = .outsideRingTone
		case kHIDUsage_Tfon_PriorityRingTone: self = .priorityRingTone
		case kHIDUsage_Tfon_InsideRingback: self = .insideRingback
		case kHIDUsage_Tfon_PriorityRingback: self = .priorityRingback
		case kHIDUsage_Tfon_LineBusyTone: self = .lineBusyTone
		case kHIDUsage_Tfon_ReorderTone: self = .reorderTone
		case kHIDUsage_Tfon_CallWaitingTone: self = .callWaitingTone
		case kHIDUsage_Tfon_ConfirmationTone1: self = .confirmationTone1
		case kHIDUsage_Tfon_ConfirmationTone2: self = .confirmationTone2
		case kHIDUsage_Tfon_TonesOff: self = .tonesOff
		case kHIDUsage_Tfon_OutsideRingback: self = .outsideRingback
		/* 0x9E - 0xAF Reserved */
		case kHIDUsage_Tfon_PhoneKey0: self = .phoneKey0
		case kHIDUsage_Tfon_PhoneKey1: self = .phoneKey1
		case kHIDUsage_Tfon_PhoneKey2: self = .phoneKey2
		case kHIDUsage_Tfon_PhoneKey3: self = .phoneKey3
		case kHIDUsage_Tfon_PhoneKey4: self = .phoneKey4
		case kHIDUsage_Tfon_PhoneKey5: self = .phoneKey5
		case kHIDUsage_Tfon_PhoneKey6: self = .phoneKey6
		case kHIDUsage_Tfon_PhoneKey7: self = .phoneKey7
		case kHIDUsage_Tfon_PhoneKey8: self = .phoneKey8
		case kHIDUsage_Tfon_PhoneKey9: self = .phoneKey9
		case kHIDUsage_Tfon_PhoneKeyStar: self = .phoneKeyStar
		case kHIDUsage_Tfon_PhoneKeyPound: self = .phoneKeyPound
		case kHIDUsage_Tfon_PhoneKeyA: self = .phoneKeyA
		case kHIDUsage_Tfon_PhoneKeyB: self = .phoneKeyB
		case kHIDUsage_Tfon_PhoneKeyC: self = .phoneKeyC
		case kHIDUsage_Tfon_PhoneKeyD: self = .phoneKeyD
		/* 0xC0 - 0xFFFF Reserved */
		case kHIDUsage_TFon_Reserved: self = .reserved(kHIDUsage_TFon_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/**
 Consumer Page (0x0C)

 All controls on the Consumer page are application-specific. That is, they affect a specific device, not the system as a whole.
*/
public enum ConsumerUsage: IUsagePageUsage
{
	case undefined
	case consumerControl /* Application Collection */
	case numericKeyPad /* Named Array */
	case programmableButtons /* Named Array */
	case microphone /* Application Collection */
	case headphone /* Application Collection */
	case graphicEqualizer /* Application Collection */
	/* 0x07 - 0x1F Reserved */
	case plus10 /* One-Shot Control */
	case plus100 /* One-Shot Control */
	case amOrPM /* One-Shot Control */
	/* 0x23 - 0x3F Reserved */
	case power /* On/Off Control */
	case reset /* One-Shot Control */
	case sleep /* One-Shot Control */
	case sleepAfter /* One-Shot Control */
	case sleepMode /* Re-Trigger Control */
	case illumination /* On/Off Control */
	case functionButtons /* Named Array */
	/* 0x37 - 0x3F Reserved */
	case menu /* On/Off Control */
	case menuPick /* One-Shot Control */
	case menuUp /* One-Shot Control */
	case menuDown /* One-Shot Control */
	case menuLeft /* One-Shot Control */
	case menuRight /* One-Shot Control */
	case menuEscape /* One-Shot Control */
	case menuValueIncrease /* One-Shot Control */
	case menuValueDecrease /* One-Shot Control */
	/* 0x49 - 0x5F Reserved */
	case dataOnScreen /* On/Off Control */
	case closedCaption /* On/Off Control */
	case closedCaptionSelect /* Selector */
	case vCROrTV /* On/Off Control */
	case broadcastMode /* One-Shot Control */
	case snapshot /* One-Shot Control */
	case still /* One-Shot Control */
	case pictureInPictureToggle /* One-Shot Control */
	case pictureInPictureSwap /* One-Shot Control */
	case redMenuButton /* Momentary Control */
	case greenMenuButton /* Momentary Control */
	case blueMenuButton /* Momentary Control */
	case yellowMenuButton /* Momentary Control */
	case aspect /* One-shot Control */
	case threeDModeSelect /* One-shot Control */
	case displayBrightnessIncrement /* Re-Trigger Control */
	case displayBrightnessDecrement /* Re-Trigger Control */
	case displayBrightness /* Logical Collection */
	case displayBacklightToggle /* One Shot Control */
	case displayBrightnessMinimum /* One Shot Control */
	case displayBrightnessMaximum /* One Shot Control */
	case displayBrightnessSetAutoBrightness /* On Off Control */
	/* 0x76 - 0x7F Reserved */
	case selection /* Named Array */
	case assign /* Selector */
	case modeStep /* One-Shot Control */
	case recallLast /* One-Shot Control */
	case enterChannel /* One-Shot Control */
	case orderMovie /* One-Shot Control */
	case channel /* Linear Control */
	case mediaSelection /* Selector */
	case mediaSelectComputer /* Selector */
	case mediaSelectTV /* Selector */
	case mediaSelectWWW /* Selector */
	case mediaSelectDVD /* Selector */
	case mediaSelectTelephone /* Selector */
	case mediaSelectProgramGuide /* Selector */
	case mediaSelectVideoPhone /* Selector */
	case mediaSelectGames /* Selector */
	case mediaSelectMessages /* Selector */
	case mediaSelectCD /* Selector */
	case mediaSelectVCR /* Selector */
	case mediaSelectTuner /* Selector */
	case quit /* One-Shot Control */
	case help /* On/Off Control */
	case mediaSelectTape /* Selector */
	case mediaSelectCable /* Selector */
	case mediaSelectSatellite /* Selector */
	case mediaSelectSecurity /* Selector */
	case mediaSelectHome /* Selector */
	case mediaSelectCall /* Selector */
	case channelIncrement /* One-Shot Control */
	case channelDecrement /* One-Shot Control */
	case media /* Selector */
	/* 0x9F Reserved */
	case vcrPlus /* One-Shot Control */
	case once /* One-Shot Control */
	case daily /* One-Shot Control */
	case weekly /* One-Shot Control */
	case monthly /* One-Shot Control */
	/* 0xA5 - 0xAF Reserved */
	case play /* On/Off Control */
	case pause /* On/Off Control */
	case record /* On/Off Control */
	case fastForward /* On/Off Control */
	case rewind /* On/Off Control */
	case scanNextTrack /* One-Shot Control */
	case scanPreviousTrack /* One-Shot Control */
	case stop /* One-Shot Control */
	case eject /* One-Shot Control */
	case randomPlay /* On/Off Control */
	case selectDisc /* Named Array */
	case enterDisc /* Momentary Control */
	case csmrRepeat /* One-Shot Control */
	case tracking /* Linear Control */
	case trackNormal /* One-Shot Control */
	case slowTracking /* Linear Control */
	case frameForward /* Re-Trigger Control */
	case frameBack /* Re-Trigger Control */
	case mark /* One-Shot Control */
	case clearMark /* One-Shot Control */
	case repeatFromMark /* On/Off Control */
	case returnToMark /* One-Shot Control */
	case searchMarkForward /* One-Shot Control */
	case searchMarkBackwards /* One-Shot Control */
	case counterReset /* One-Shot Control */
	case showCounter /* One-Shot Control */
	case trackingIncrement /* Re-Trigger Control */
	case trackingDecrement /* Re-Trigger Control */
	case stopOrEject /* One-Shot Control */
	case playOrPause /* One-Shot Control */
	case playOrSkip /* One-Shot Control */
	case voiceCommand /* One-Shot Control */
	/* 0xCF - 0xDF Reserved */
	case volume /* Linear Control */
	case balance /* Linear Control */
	case mute /* On/Off Control */
	case bass /* Linear Control */
	case treble /* Linear Control */
	case bassBoost /* On/Off Control */
	case surroundMode /* One-Shot Control */
	case loudness /* On/Off Control */
	case mPX /* On/Off Control */
	case volumeIncrement /* Re-Trigger Control */
	case volumeDecrement /* Re-Trigger Control */
	/* 0xEB - 0xEF Reserved */
	case speed /* Selector */
	case playbackSpeed /* Named Array */
	case standardPlay /* Selector */
	case longPlay /* Selector */
	case extendedPlay /* Selector */
	case slow /* One-Shot Control */
	/* 0xF6 - 0xFF Reserved */
	case fanEnable /* On/Off Control */
	case fanSpeed /* Linear Control */
	case lightEnable /* On/Off Control */
	case lightIlluminationLevel /* Linear Control */
	case climateControlEnable /* On/Off Control */
	case roomTemperature /* Linear Control */
	case securityEnable /* On/Off Control */
	case fireAlarm /* One-Shot Control */
	case policeAlarm /* One-Shot Control */
	case proximity /* Linear Control */
	case motion /* One-Shot Control */
	case duressAlarm /* One-Shot Control */
	case holdupAlarm /* One-Shot Control */
	case medicalAlarm /* One-Shot Control */
	/* 0x10E - 0x14F Reserved */
	case balanceRight /* Re-Trigger Control */
	case balanceLeft /* Re-Trigger Control */
	case bassIncrement /* Re-Trigger Control */
	case bassDecrement /* Re-Trigger Control */
	case trebleIncrement /* Re-Trigger Control */
	case trebleDecrement /* Re-Trigger Control */
	/* 0x156 - 0x15F Reserved */
	case speakerSystem /* Logical Collection */
	case channelLeft /* Logical Collection */
	case channelRight /* Logical Collection */
	case channelCenter /* Logical Collection */
	case channelFront /* Logical Collection */
	case channelCenterFront /* Logical Collection */
	case channelSide /* Logical Collection */
	case channelSurround /* Logical Collection */
	case channelLowFrequencyEnhancement /* Logical Collection */
	case channelTop /* Logical Collection */
	case channelUnknown /* Logical Collection */
	/* 0x16B - 0x16F Reserved */
	case subChannel /* Linear Control */
	case subChannelIncrement /* One-Shot Control */
	case subChannelDecrement /* One-Shot Control */
	case alternateAudioIncrement /* One-Shot Control */
	case alternateAudioDecrement /* One-Shot Control */
	/* 0x175 - 0x17F Reserved */
	case applicationLaunchButtons /* Named Array */
	case alLaunchButtonConfigurationTool /* Selector */
	case alProgrammableButtonConfiguration /* Selector */
	case alConsumerControlConfiguration /* Selector */
	case alWordProcessor /* Selector */
	case alTextEditor /* Selector */
	case alSpreadsheet /* Selector */
	case alGraphicsEditor /* Selector */
	case alPresentationApp /* Selector */
	case alDatabaseApp /* Selector */
	case alEmailReader /* Selector */
	case alNewsreader /* Selector */
	case alVoicemail /* Selector */
	case alContactsOrAddressBook /* Selector */
	case alCalendarOrSchedule /* Selector */
	case alTaskOrProjectManager /* Selector */
	case alLogOrJournalOrTimecard /* Selector */
	case alCheckbookOrFinance /* Selector */
	case alCalculator /* Selector */
	case alAOrVCaptureOrPlayback /* Selector */
	case alLocalMachineBrowser /* Selector */
	case alLANOrWANBrowser /* Selector */
	case alInternetBrowser /* Selector */
	case alRemoteNetworkingOrISPConnect /* Selector */
	case alNetworkConference /* Selector */
	case alNetworkChat /* Selector */
	case alTelephonyOrDialer /* Selector */
	case alLogon /* Selector */
	case alLogoff /* Selector */
	case alLogonOrLogoff /* Selector */
	case alTerminalLockOrScreensaver /* Selector */
	case alControlPanel /* Selector */
	case alCommandLineProcessorOrRun /* Selector */
	case alProcessOrTaskManager /* Selector */
	case al /* Selector */
	case alNextTaskOrApplication /* Selector */
	case alPreviousTaskOrApplication /* Selector */
	case alPreemptiveHaltTaskOrApplication /* Selector */
	case alIntegratedHelpCenter /* Selector */
	case alDocuments /* Selector */
	case alThesaurus /* Selector */
	case alDictionary /* Selector */
	case alDesktop /* Selector */
	case alSpellCheck /* Selector */
	case alGrammerCheck /* Selector */
	case alWirelessStatus /* Selector */
	case alKeyboardLayout /* Selector */
	case alVirusProtection /* Selector */
	case alEncryption /* Selector */
	case alScreenSaver /* Selector */
	case alAlarms /* Selector */
	case alClock /* Selector */
	case alFileBrowser /* Selector */
	case alPowerStatus /* Selector */
	case alImageBrowser /* Selector */
	case alAudioBrowser /* Selector */
	case alMovieBrowser /* Selector */
	case alDigitalRightsManager /* Selector */
	case alDigitalWallet /* Selector */
	/* 0x1BB Reserved */
	case alInstantMessaging /* Selector */
	case alOEMFeatureBrowser /* Selector */
	case alOEMHelp /* Selector */
	case alOnlineCommunity /* Selector */
	case alEntertainmentContentBrowser /* Selector */
	case alOnlineShoppingBrowswer /* Selector */
	case alSmartCardInformationOrHelp /* Selector */
	case alMarketMonitorOrFinanceBrowser /* Selector */
	case alCustomizedCorporateNewsBrowser /* Selector */
	case alOnlineActivityBrowswer /* Selector */
	case alResearchOrSearchBrowswer /* Selector */
	case alAudioPlayer /* Selector */
	case alNavigation /* Selector */
	/* 0x1C9 - 0x1FF Reserved */
	case genericGUIApplicationControls /* Named Array */
	case acNew /* Selector */
	case acOpen /* Selector */
	case acClose /* Selector */
	case acExit /* Selector */
	case acMaximize /* Selector */
	case acMinimize /* Selector */
	case acSave /* Selector */
	case acPrint /* Selector */
	case acProperties /* Selector */
	case acUndo /* Selector */
	case acCopy /* Selector */
	case acCut /* Selector */
	case acPaste /* Selector */
	case aC /* Selector */
	case acFind /* Selector */
	case acFindandReplace /* Selector */
	case acSearch /* Selector */
	case acGoTo /* Selector */
	case acHome /* Selector */
	case acBack /* Selector */
	case acForward /* Selector */
	case acStop /* Selector */
	case acRefresh /* Selector */
	case acPreviousLink /* Selector */
	case acNextLink /* Selector */
	case acBookmarks /* Selector */
	case acHistory /* Selector */
	case acSubscriptions /* Selector */
	case acZoomIn /* Selector */
	case acZoomOut /* Selector */
	case acZoom /* Selector */
	case acFullScreenView /* Selector */
	case acNormalView /* Selector */
	case acViewToggle /* Selector */
	case acScrollUp /* Selector */
	case acScrollDown /* Selector */
	case acScroll /* Selector */
	case acPanLeft /* Selector */
	case acPanRight /* Selector */
	case acPan /* Selector */
	case acNewWindow /* Selector */
	case acTileHorizontally /* Selector */
	case acTileVertically /* Selector */
	case acFormat /* Selector */
	case acEdit /* Selector */
	case acBold /* Selector */
	case acItalics /* Selector */
	case acUnderline /* Selector */
	case acStrikethrough /* Selector */
	case acSubscript /* Selector */
	case acSuperscript /* Selector */
	case acAllCaps /* Selector */
	case acRotate /* Selector */
	case acResize /* Selector */
	case acFlipHorizontal /* Selector */
	case acFlipVertical /* Selector */
	case acMirrorHorizontal /* Selector */
	case acMirrorVertical /* Selector */
	case acFontSelect /* Selector */
	case acFontColor /* Selector */
	case acFontSize /* Selector */
	case acJustifyLeft /* Selector */
	case acJustifyCenterH /* Selector */
	case acJustifyRight /* Selector */
	case acJustifyBlockH /* Selector */
	case acJustifyTop /* Selector */
	case acJustifyCenterV /* Selector */
	case acJustifyBottom /* Selector */
	case acJustifyBlockV /* Selector */
	case acIndentyDecrease /* Selector */
	case acIndentyIncrease /* Selector */
	case acNumberedList /* Selector */
	case acRestartNumbering /* Selector */
	case acBulletedList /* Selector */
	case acPromote /* Selector */
	case acDemote /* Selector */
	case acYes /* Selector */
	case acNo /* Selector */
	case acCancel /* Selector */
	case acCatalog /* Selector */
	case acBuyOrCheckout /* Selector */
	case acAddToCart /* Selector */
	case acExpand /* Selector */
	case acExpandAll /* Selector */
	case acCollapse /* Selector */
	case acCollapseAll /* Selector */
	case acPrintPreview /* Selector */
	case acPasteSpecial /* Selector */
	case acInsertMode /* Selector */
	case acDelete /* Selector */
	case acLock /* Selector */
	case acUnlock /* Selector */
	case acProtect /* Selector */
	case acUnprotect /* Selector */
	case acAttachComment /* Selector */
	case acDetachComment /* Selector */
	case acViewComment /* Selector */
	case acSelectWord /* Selector */
	case acSelectSentence /* Selector */
	case acSelectParagraph /* Selector */
	case acSelectColumn /* Selector */
	case acSelectRow /* Selector */
	case acSelectTable /* Selector */
	case acSelectObject /* Selector */
	case acRedoOrRepeat /* Selector */
	case acSort /* Selector */
	case acSortAscending /* Selector */
	case acSortDescending /* Selector */
	case acFilter /* Selector */
	case acSetClock /* Selector */
	case acViewClock /* Selector */
	case acSelectTimeZone /* Selector */
	case acEditTimeZones /* Selector */
	case acSetAlarm /* Selector */
	case acClearAlarm /* Selector */
	case acSnoozeAlarm /* Selector */
	case acResetAlarm /* Selector */
	case acSynchronize /* Selector */
	case acSendOrReceive /* Selector */
	case acSendTo /* Selector */
	case acReply /* Selector */
	case acReplyAll /* Selector */
	case acForwardMessage /* Selector */
	case acSend /* Selector */
	case acAttachFile /* Selector */
	case acUpload /* Selector */
	case acDownload /* Selector */
	case acSetBorders /* Selector */
	case acInsertRow /* Selector */
	case acInsertColumn /* Selector */
	case acInsertFile /* Selector */
	case acInsertPicture /* Selector */
	case acInsertObject /* Selector */
	case acInsertSymbol /* Selector */
	case acSaveAndClose /* Selector */
	case acRename /* Selector */
	case acMerge /* Selector */
	case acSplit /* Selector */
	case acDistributeH /* Selector */
	case acDistributeV /* Selector */
	case acKeyboardLayoutSelect /* One-Shot Control */
	case acNavigationGuidance /* Selector */
	/* 0x29F - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Consumer, kHIDUsage_Undefined)
		case .consumerControl: return (kHIDPage_Consumer, kHIDUsage_Csmr_ConsumerControl) /* Application Collection */
		case .numericKeyPad: return (kHIDPage_Consumer, kHIDUsage_Csmr_NumericKeyPad) /* Named Array */
		case .programmableButtons: return (kHIDPage_Consumer, kHIDUsage_Csmr_ProgrammableButtons) /* Named Array */
		case .microphone: return (kHIDPage_Consumer, kHIDUsage_Csmr_Microphone) /* Application Collection */
		case .headphone: return (kHIDPage_Consumer, kHIDUsage_Csmr_Headphone) /* Application Collection */
		case .graphicEqualizer: return (kHIDPage_Consumer, kHIDUsage_Csmr_GraphicEqualizer) /* Application Collection */
			/* 0x07 - 0x1F Reserved */
		case .plus10: return (kHIDPage_Consumer, kHIDUsage_Csmr_Plus10) /* One-Shot Control */
		case .plus100: return (kHIDPage_Consumer, kHIDUsage_Csmr_Plus100) /* One-Shot Control */
		case .amOrPM: return (kHIDPage_Consumer, kHIDUsage_Csmr_AMOrPM) /* One-Shot Control */
			/* 0x23 - 0x3F Reserved */
		case .power: return (kHIDPage_Consumer, kHIDUsage_Csmr_Power) /* On/Off Control */
		case .reset: return (kHIDPage_Consumer, kHIDUsage_Csmr_Reset) /* One-Shot Control */
		case .sleep: return (kHIDPage_Consumer, kHIDUsage_Csmr_Sleep) /* One-Shot Control */
		case .sleepAfter: return (kHIDPage_Consumer, kHIDUsage_Csmr_SleepAfter) /* One-Shot Control */
		case .sleepMode: return (kHIDPage_Consumer, kHIDUsage_Csmr_SleepMode) /* Re-Trigger Control */
		case .illumination: return (kHIDPage_Consumer, kHIDUsage_Csmr_Illumination) /* On/Off Control */
		case .functionButtons: return (kHIDPage_Consumer, kHIDUsage_Csmr_FunctionButtons) /* Named Array */
			/* 0x37 - 0x3F Reserved */
		case .menu: return (kHIDPage_Consumer, kHIDUsage_Csmr_Menu) /* On/Off Control */
		case .menuPick: return (kHIDPage_Consumer, kHIDUsage_Csmr_MenuPick) /* One-Shot Control */
		case .menuUp: return (kHIDPage_Consumer, kHIDUsage_Csmr_MenuUp) /* One-Shot Control */
		case .menuDown: return (kHIDPage_Consumer, kHIDUsage_Csmr_MenuDown) /* One-Shot Control */
		case .menuLeft: return (kHIDPage_Consumer, kHIDUsage_Csmr_MenuLeft) /* One-Shot Control */
		case .menuRight: return (kHIDPage_Consumer, kHIDUsage_Csmr_MenuRight) /* One-Shot Control */
		case .menuEscape: return (kHIDPage_Consumer, kHIDUsage_Csmr_MenuEscape) /* One-Shot Control */
		case .menuValueIncrease: return (kHIDPage_Consumer, kHIDUsage_Csmr_MenuValueIncrease) /* One-Shot Control */
		case .menuValueDecrease: return (kHIDPage_Consumer, kHIDUsage_Csmr_MenuValueDecrease) /* One-Shot Control */
			/* 0x49 - 0x5F Reserved */
		case .dataOnScreen: return (kHIDPage_Consumer, kHIDUsage_Csmr_DataOnScreen) /* On/Off Control */
		case .closedCaption: return (kHIDPage_Consumer, kHIDUsage_Csmr_ClosedCaption) /* On/Off Control */
		case .closedCaptionSelect: return (kHIDPage_Consumer, kHIDUsage_Csmr_ClosedCaptionSelect) /* Selector */
		case .vCROrTV: return (kHIDPage_Consumer, kHIDUsage_Csmr_VCROrTV) /* On/Off Control */
		case .broadcastMode: return (kHIDPage_Consumer, kHIDUsage_Csmr_BroadcastMode) /* One-Shot Control */
		case .snapshot: return (kHIDPage_Consumer, kHIDUsage_Csmr_Snapshot) /* One-Shot Control */
		case .still: return (kHIDPage_Consumer, kHIDUsage_Csmr_Still) /* One-Shot Control */
		case .pictureInPictureToggle: return (kHIDPage_Consumer, kHIDUsage_Csmr_PictureInPictureToggle) /* One-Shot Control */
		case .pictureInPictureSwap: return (kHIDPage_Consumer, kHIDUsage_Csmr_PictureInPictureSwap) /* One-Shot Control */
		case .redMenuButton: return (kHIDPage_Consumer, kHIDUsage_Csmr_RedMenuButton) /* Momentary Control */
		case .greenMenuButton: return (kHIDPage_Consumer, kHIDUsage_Csmr_GreenMenuButton) /* Momentary Control */
		case .blueMenuButton: return (kHIDPage_Consumer, kHIDUsage_Csmr_BlueMenuButton) /* Momentary Control */
		case .yellowMenuButton: return (kHIDPage_Consumer, kHIDUsage_Csmr_YellowMenuButton) /* Momentary Control */
		case .aspect: return (kHIDPage_Consumer, kHIDUsage_Csmr_Aspect) /* One-Shot Control */
		case .threeDModeSelect: return (kHIDPage_Consumer, kHIDUsage_Csmr_3DModeSelect) /* One-Shot Control */
		case .displayBrightnessIncrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_DisplayBrightnessIncrement) /* Re-Trigger Control */
		case .displayBrightnessDecrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_DisplayBrightnessDecrement) /* Re-Trigger Control */
		case .displayBrightness: return (kHIDPage_Consumer, kHIDUsage_Csmr_DisplayBrightness) /* Logical Collection */
		case .displayBacklightToggle: return (kHIDPage_Consumer, kHIDUsage_Csmr_DisplayBacklightToggle) /* One Shot Control */
		case .displayBrightnessMinimum: return (kHIDPage_Consumer, kHIDUsage_Csmr_DisplayBrightnessMinimum) /* One Shot Control */
		case .displayBrightnessMaximum: return (kHIDPage_Consumer, kHIDUsage_Csmr_DisplayBrightnessMaximum) /* One Shot Control */
		case .displayBrightnessSetAutoBrightness: return (kHIDPage_Consumer, kHIDUsage_Csmr_DisplayBrightnessSetAutoBrightness) /* On Off Control */
			/* 0x76 - 0x7F Reserved */
		case .selection: return (kHIDPage_Consumer, kHIDUsage_Csmr_Selection) /* Named Array */
		case .assign: return (kHIDPage_Consumer, kHIDUsage_Csmr_Assign) /* Selector */
		case .modeStep: return (kHIDPage_Consumer, kHIDUsage_Csmr_ModeStep) /* One-Shot Control */
		case .recallLast: return (kHIDPage_Consumer, kHIDUsage_Csmr_RecallLast) /* One-Shot Control */
		case .enterChannel: return (kHIDPage_Consumer, kHIDUsage_Csmr_EnterChannel) /* One-Shot Control */
		case .orderMovie: return (kHIDPage_Consumer, kHIDUsage_Csmr_OrderMovie) /* One-Shot Control */
		case .channel: return (kHIDPage_Consumer, kHIDUsage_Csmr_Channel) /* Linear Control */
		case .mediaSelection: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelection) /* Selector */
		case .mediaSelectComputer: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectComputer) /* Selector */
		case .mediaSelectTV: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectTV) /* Selector */
		case .mediaSelectWWW: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectWWW) /* Selector */
		case .mediaSelectDVD: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectDVD) /* Selector */
		case .mediaSelectTelephone: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectTelephone) /* Selector */
		case .mediaSelectProgramGuide: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectProgramGuide) /* Selector */
		case .mediaSelectVideoPhone: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectVideoPhone) /* Selector */
		case .mediaSelectGames: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectGames) /* Selector */
		case .mediaSelectMessages: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectMessages) /* Selector */
		case .mediaSelectCD: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectCD) /* Selector */
		case .mediaSelectVCR: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectVCR) /* Selector */
		case .mediaSelectTuner: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectTuner) /* Selector */
		case .quit: return (kHIDPage_Consumer, kHIDUsage_Csmr_Quit) /* One-Shot Control */
		case .help: return (kHIDPage_Consumer, kHIDUsage_Csmr_Help) /* On/Off Control */
		case .mediaSelectTape: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectTape) /* Selector */
		case .mediaSelectCable: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectCable) /* Selector */
		case .mediaSelectSatellite: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectSatellite) /* Selector */
		case .mediaSelectSecurity: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectSecurity) /* Selector */
		case .mediaSelectHome: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectHome) /* Selector */
		case .mediaSelectCall: return (kHIDPage_Consumer, kHIDUsage_Csmr_MediaSelectCall) /* Selector */
		case .channelIncrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelIncrement) /* One-Shot Control */
		case .channelDecrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelDecrement) /* One-Shot Control */
		case .media: return (kHIDPage_Consumer, kHIDUsage_Csmr_Media) /* Selector */
			/* 0x9F Reserved */
		case .vcrPlus: return (kHIDPage_Consumer, kHIDUsage_Csmr_VCRPlus) /* One-Shot Control */
		case .once: return (kHIDPage_Consumer, kHIDUsage_Csmr_Once) /* One-Shot Control */
		case .daily: return (kHIDPage_Consumer, kHIDUsage_Csmr_Daily) /* One-Shot Control */
		case .weekly: return (kHIDPage_Consumer, kHIDUsage_Csmr_Weekly) /* One-Shot Control */
		case .monthly: return (kHIDPage_Consumer, kHIDUsage_Csmr_Monthly) /* One-Shot Control */
			/* 0xA5 - 0xAF Reserved */
		case .play: return (kHIDPage_Consumer, kHIDUsage_Csmr_Play) /* On/Off Control */
		case .pause: return (kHIDPage_Consumer, kHIDUsage_Csmr_Pause) /* On/Off Control */
		case .record: return (kHIDPage_Consumer, kHIDUsage_Csmr_Record) /* On/Off Control */
		case .fastForward: return (kHIDPage_Consumer, kHIDUsage_Csmr_FastForward) /* On/Off Control */
		case .rewind: return (kHIDPage_Consumer, kHIDUsage_Csmr_Rewind) /* On/Off Control */
		case .scanNextTrack: return (kHIDPage_Consumer, kHIDUsage_Csmr_ScanNextTrack) /* One-Shot Control */
		case .scanPreviousTrack: return (kHIDPage_Consumer, kHIDUsage_Csmr_ScanPreviousTrack) /* One-Shot Control */
		case .stop: return (kHIDPage_Consumer, kHIDUsage_Csmr_Stop) /* One-Shot Control */
		case .eject: return (kHIDPage_Consumer, kHIDUsage_Csmr_Eject) /* One-Shot Control */
		case .randomPlay: return (kHIDPage_Consumer, kHIDUsage_Csmr_RandomPlay) /* On/Off Control */
		case .selectDisc: return (kHIDPage_Consumer, kHIDUsage_Csmr_SelectDisc) /* Named Array */
		case .enterDisc: return (kHIDPage_Consumer, kHIDUsage_Csmr_EnterDisc) /* Momentary Control */
		case .csmrRepeat: return (kHIDPage_Consumer, kHIDUsage_Csmr_Repeat) /* One-Shot Control */
		case .tracking: return (kHIDPage_Consumer, kHIDUsage_Csmr_Tracking) /* Linear Control */
		case .trackNormal: return (kHIDPage_Consumer, kHIDUsage_Csmr_TrackNormal) /* One-Shot Control */
		case .slowTracking: return (kHIDPage_Consumer, kHIDUsage_Csmr_SlowTracking) /* Linear Control */
		case .frameForward: return (kHIDPage_Consumer, kHIDUsage_Csmr_FrameForward) /* Re-Trigger Control */
		case .frameBack: return (kHIDPage_Consumer, kHIDUsage_Csmr_FrameBack) /* Re-Trigger Control */
		case .mark: return (kHIDPage_Consumer, kHIDUsage_Csmr_Mark) /* One-Shot Control */
		case .clearMark: return (kHIDPage_Consumer, kHIDUsage_Csmr_ClearMark) /* One-Shot Control */
		case .repeatFromMark: return (kHIDPage_Consumer, kHIDUsage_Csmr_RepeatFromMark) /* On/Off Control */
		case .returnToMark: return (kHIDPage_Consumer, kHIDUsage_Csmr_ReturnToMark) /* One-Shot Control */
		case .searchMarkForward: return (kHIDPage_Consumer, kHIDUsage_Csmr_SearchMarkForward) /* One-Shot Control */
		case .searchMarkBackwards: return (kHIDPage_Consumer, kHIDUsage_Csmr_SearchMarkBackwards) /* One-Shot Control */
		case .counterReset: return (kHIDPage_Consumer, kHIDUsage_Csmr_CounterReset) /* One-Shot Control */
		case .showCounter: return (kHIDPage_Consumer, kHIDUsage_Csmr_ShowCounter) /* One-Shot Control */
		case .trackingIncrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_TrackingIncrement) /* Re-Trigger Control */
		case .trackingDecrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_TrackingDecrement) /* Re-Trigger Control */
		case .stopOrEject: return (kHIDPage_Consumer, kHIDUsage_Csmr_StopOrEject) /* One-Shot Control */
		case .playOrPause: return (kHIDPage_Consumer, kHIDUsage_Csmr_PlayOrPause) /* One-Shot Control */
		case .playOrSkip: return (kHIDPage_Consumer, kHIDUsage_Csmr_PlayOrSkip) /* One-Shot Control */
		case .voiceCommand: return (kHIDPage_Consumer, kHIDUsage_Csmr_VoiceCommand) /* One-Shot Control */
			/* 0xCF - 0xDF Reserved */
		case .volume: return (kHIDPage_Consumer, kHIDUsage_Csmr_Volume) /* Linear Control */
		case .balance: return (kHIDPage_Consumer, kHIDUsage_Csmr_Balance) /* Linear Control */
		case .mute: return (kHIDPage_Consumer, kHIDUsage_Csmr_Mute) /* On/Off Control */
		case .bass: return (kHIDPage_Consumer, kHIDUsage_Csmr_Bass) /* Linear Control */
		case .treble: return (kHIDPage_Consumer, kHIDUsage_Csmr_Treble) /* Linear Control */
		case .bassBoost: return (kHIDPage_Consumer, kHIDUsage_Csmr_BassBoost) /* On/Off Control */
		case .surroundMode: return (kHIDPage_Consumer, kHIDUsage_Csmr_SurroundMode) /* One-Shot Control */
		case .loudness: return (kHIDPage_Consumer, kHIDUsage_Csmr_Loudness) /* On/Off Control */
		case .mPX: return (kHIDPage_Consumer, kHIDUsage_Csmr_MPX) /* On/Off Control */
		case .volumeIncrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_VolumeIncrement) /* Re-Trigger Control */
		case .volumeDecrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_VolumeDecrement) /* Re-Trigger Control */
			/* 0xEB - 0xEF Reserved */
		case .speed: return (kHIDPage_Consumer, kHIDUsage_Csmr_Speed) /* Selector */
		case .playbackSpeed: return (kHIDPage_Consumer, kHIDUsage_Csmr_PlaybackSpeed) /* Named Array */
		case .standardPlay: return (kHIDPage_Consumer, kHIDUsage_Csmr_StandardPlay) /* Selector */
		case .longPlay: return (kHIDPage_Consumer, kHIDUsage_Csmr_LongPlay) /* Selector */
		case .extendedPlay: return (kHIDPage_Consumer, kHIDUsage_Csmr_ExtendedPlay) /* Selector */
		case .slow: return (kHIDPage_Consumer, kHIDUsage_Csmr_Slow) /* One-Shot Control */
			/* 0xF6 - 0xFF Reserved */
		case .fanEnable: return (kHIDPage_Consumer, kHIDUsage_Csmr_FanEnable) /* On/Off Control */
		case .fanSpeed: return (kHIDPage_Consumer, kHIDUsage_Csmr_FanSpeed) /* Linear Control */
		case .lightEnable: return (kHIDPage_Consumer, kHIDUsage_Csmr_LightEnable) /* On/Off Control */
		case .lightIlluminationLevel: return (kHIDPage_Consumer, kHIDUsage_Csmr_LightIlluminationLevel) /* Linear Control */
		case .climateControlEnable: return (kHIDPage_Consumer, kHIDUsage_Csmr_ClimateControlEnable) /* On/Off Control */
		case .roomTemperature: return (kHIDPage_Consumer, kHIDUsage_Csmr_RoomTemperature) /* Linear Control */
		case .securityEnable: return (kHIDPage_Consumer, kHIDUsage_Csmr_SecurityEnable) /* On/Off Control */
		case .fireAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_FireAlarm) /* One-Shot Control */
		case .policeAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_PoliceAlarm) /* One-Shot Control */
		case .proximity: return (kHIDPage_Consumer, kHIDUsage_Csmr_Proximity) /* Linear Control */
		case .motion: return (kHIDPage_Consumer, kHIDUsage_Csmr_Motion) /* One-Shot Control */
		case .duressAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_DuressAlarm) /* One-Shot Control */
		case .holdupAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_HoldupAlarm) /* One-Shot Control */
		case .medicalAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_MedicalAlarm) /* One-Shot Control */
			/* 0x10E - 0x14F Reserved */
		case .balanceRight: return (kHIDPage_Consumer, kHIDUsage_Csmr_BalanceRight) /* Re-Trigger Control */
		case .balanceLeft: return (kHIDPage_Consumer, kHIDUsage_Csmr_BalanceLeft) /* Re-Trigger Control */
		case .bassIncrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_BassIncrement) /* Re-Trigger Control */
		case .bassDecrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_BassDecrement) /* Re-Trigger Control */
		case .trebleIncrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_TrebleIncrement) /* Re-Trigger Control */
		case .trebleDecrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_TrebleDecrement) /* Re-Trigger Control */
			/* 0x156 - 0x15F Reserved */
		case .speakerSystem: return (kHIDPage_Consumer, kHIDUsage_Csmr_SpeakerSystem) /* Logical Collection */
		case .channelLeft: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelLeft) /* Logical Collection */
		case .channelRight: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelRight) /* Logical Collection */
		case .channelCenter: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelCenter) /* Logical Collection */
		case .channelFront: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelFront) /* Logical Collection */
		case .channelCenterFront: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelCenterFront) /* Logical Collection */
		case .channelSide: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelSide) /* Logical Collection */
		case .channelSurround: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelSurround) /* Logical Collection */
		case .channelLowFrequencyEnhancement: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelLowFrequencyEnhancement) /* Logical Collection */
		case .channelTop: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelTop) /* Logical Collection */
		case .channelUnknown: return (kHIDPage_Consumer, kHIDUsage_Csmr_ChannelUnknown) /* Logical Collection */
			/* 0x16B - 0x16F Reserved */
		case .subChannel: return (kHIDPage_Consumer, kHIDUsage_Csmr_SubChannel) /* Linear Control */
		case .subChannelIncrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_SubChannelIncrement) /* One-Shot Control */
		case .subChannelDecrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_SubChannelDecrement) /* One-Shot Control */
		case .alternateAudioIncrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_AlternateAudioIncrement) /* One-Shot Control */
		case .alternateAudioDecrement: return (kHIDPage_Consumer, kHIDUsage_Csmr_AlternateAudioDecrement) /* One-Shot Control */
			/* 0x175 - 0x17F Reserved */
		case .applicationLaunchButtons: return (kHIDPage_Consumer, kHIDUsage_Csmr_ApplicationLaunchButtons) /* Named Array */
		case .alLaunchButtonConfigurationTool: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALLaunchButtonConfigurationTool) /* Selector */
		case .alProgrammableButtonConfiguration: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALProgrammableButtonConfiguration) /* Selector */
		case .alConsumerControlConfiguration: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALConsumerControlConfiguration) /* Selector */
		case .alWordProcessor: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALWordProcessor) /* Selector */
		case .alTextEditor: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALTextEditor) /* Selector */
		case .alSpreadsheet: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALSpreadsheet) /* Selector */
		case .alGraphicsEditor: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALGraphicsEditor) /* Selector */
		case .alPresentationApp: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALPresentationApp) /* Selector */
		case .alDatabaseApp: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALDatabaseApp) /* Selector */
		case .alEmailReader: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALEmailReader) /* Selector */
		case .alNewsreader: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALNewsreader) /* Selector */
		case .alVoicemail: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALVoicemail) /* Selector */
		case .alContactsOrAddressBook: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALContactsOrAddressBook) /* Selector */
		case .alCalendarOrSchedule: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALCalendarOrSchedule) /* Selector */
		case .alTaskOrProjectManager: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALTaskOrProjectManager) /* Selector */
		case .alLogOrJournalOrTimecard: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALLogOrJournalOrTimecard) /* Selector */
		case .alCheckbookOrFinance: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALCheckbookOrFinance) /* Selector */
		case .alCalculator: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALCalculator) /* Selector */
		case .alAOrVCaptureOrPlayback: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALAOrVCaptureOrPlayback) /* Selector */
		case .alLocalMachineBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALLocalMachineBrowser) /* Selector */
		case .alLANOrWANBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALLANOrWANBrowser) /* Selector */
		case .alInternetBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALInternetBrowser) /* Selector */
		case .alRemoteNetworkingOrISPConnect: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALRemoteNetworkingOrISPConnect) /* Selector */
		case .alNetworkConference: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALNetworkConference) /* Selector */
		case .alNetworkChat: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALNetworkChat) /* Selector */
		case .alTelephonyOrDialer: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALTelephonyOrDialer) /* Selector */
		case .alLogon: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALLogon) /* Selector */
		case .alLogoff: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALLogoff) /* Selector */
		case .alLogonOrLogoff: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALLogonOrLogoff) /* Selector */
		case .alTerminalLockOrScreensaver: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALTerminalLockOrScreensaver) /* Selector */
		case .alControlPanel: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALControlPanel) /* Selector */
		case .alCommandLineProcessorOrRun: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALCommandLineProcessorOrRun) /* Selector */
		case .alProcessOrTaskManager: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALProcessOrTaskManager) /* Selector */
		case .al: return (kHIDPage_Consumer, kHIDUsage_Csmr_AL) /* Selector */
		case .alNextTaskOrApplication: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALNextTaskOrApplication) /* Selector */
		case .alPreviousTaskOrApplication: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALPreviousTaskOrApplication) /* Selector */
		case .alPreemptiveHaltTaskOrApplication: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALPreemptiveHaltTaskOrApplication) /* Selector */
		case .alIntegratedHelpCenter: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALIntegratedHelpCenter) /* Selector */
		case .alDocuments: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALDocuments) /* Selector */
		case .alThesaurus: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALThesaurus) /* Selector */
		case .alDictionary: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALDictionary) /* Selector */
		case .alDesktop: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALDesktop) /* Selector */
		case .alSpellCheck: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALSpellCheck) /* Selector */
		case .alGrammerCheck: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALGrammerCheck) /* Selector */
		case .alWirelessStatus: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALWirelessStatus) /* Selector */
		case .alKeyboardLayout: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALKeyboardLayout) /* Selector */
		case .alVirusProtection: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALVirusProtection) /* Selector */
		case .alEncryption: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALEncryption) /* Selector */
		case .alScreenSaver: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALScreenSaver) /* Selector */
		case .alAlarms: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALAlarms) /* Selector */
		case .alClock: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALClock) /* Selector */
		case .alFileBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALFileBrowser) /* Selector */
		case .alPowerStatus: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALPowerStatus) /* Selector */
		case .alImageBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALImageBrowser) /* Selector */
		case .alAudioBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALAudioBrowser) /* Selector */
		case .alMovieBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALMovieBrowser) /* Selector */
		case .alDigitalRightsManager: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALDigitalRightsManager) /* Selector */
		case .alDigitalWallet: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALDigitalWallet) /* Selector */
			/* 0x1BB Reserved */
		case .alInstantMessaging: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALInstantMessaging) /* Selector */
		case .alOEMFeatureBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALOEMFeatureBrowser) /* Selector */
		case .alOEMHelp: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALOEMHelp) /* Selector */
		case .alOnlineCommunity: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALOnlineCommunity) /* Selector */
		case .alEntertainmentContentBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALEntertainmentContentBrowser) /* Selector */
		case .alOnlineShoppingBrowswer: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALOnlineShoppingBrowswer) /* Selector */
		case .alSmartCardInformationOrHelp: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALSmartCardInformationOrHelp) /* Selector */
		case .alMarketMonitorOrFinanceBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALMarketMonitorOrFinanceBrowser) /* Selector */
		case .alCustomizedCorporateNewsBrowser: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALCustomizedCorporateNewsBrowser) /* Selector */
		case .alOnlineActivityBrowswer: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALOnlineActivityBrowswer) /* Selector */
		case .alResearchOrSearchBrowswer: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALResearchOrSearchBrowswer) /* Selector */
		case .alAudioPlayer: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALAudioPlayer) /* Selector */
		case .alNavigation: return (kHIDPage_Consumer, kHIDUsage_Csmr_ALNavigation) /* Selector */
			/* 0x1C9 - 0x1FF Reserved */
		case .genericGUIApplicationControls: return (kHIDPage_Consumer, kHIDUsage_Csmr_GenericGUIApplicationControls) /* Named Array */
		case .acNew: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACNew) /* Selector */
		case .acOpen: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACOpen) /* Selector */
		case .acClose: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACClose) /* Selector */
		case .acExit: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACExit) /* Selector */
		case .acMaximize: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACMaximize) /* Selector */
		case .acMinimize: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACMinimize) /* Selector */
		case .acSave: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSave) /* Selector */
		case .acPrint: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPrint) /* Selector */
		case .acProperties: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACProperties) /* Selector */
		case .acUndo: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACUndo) /* Selector */
		case .acCopy: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACCopy) /* Selector */
		case .acCut: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACCut) /* Selector */
		case .acPaste: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPaste) /* Selector */
		case .aC: return (kHIDPage_Consumer, kHIDUsage_Csmr_AC) /* Selector */
		case .acFind: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFind) /* Selector */
		case .acFindandReplace: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFindandReplace) /* Selector */
		case .acSearch: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSearch) /* Selector */
		case .acGoTo: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACGoTo) /* Selector */
		case .acHome: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACHome) /* Selector */
		case .acBack: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACBack) /* Selector */
		case .acForward: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACForward) /* Selector */
		case .acStop: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACStop) /* Selector */
		case .acRefresh: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACRefresh) /* Selector */
		case .acPreviousLink: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPreviousLink) /* Selector */
		case .acNextLink: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACNextLink) /* Selector */
		case .acBookmarks: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACBookmarks) /* Selector */
		case .acHistory: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACHistory) /* Selector */
		case .acSubscriptions: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSubscriptions) /* Selector */
		case .acZoomIn: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACZoomIn) /* Selector */
		case .acZoomOut: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACZoomOut) /* Selector */
		case .acZoom: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACZoom) /* Selector */
		case .acFullScreenView: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFullScreenView) /* Selector */
		case .acNormalView: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACNormalView) /* Selector */
		case .acViewToggle: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACViewToggle) /* Selector */
		case .acScrollUp: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACScrollUp) /* Selector */
		case .acScrollDown: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACScrollDown) /* Selector */
		case .acScroll: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACScroll) /* Selector */
		case .acPanLeft: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPanLeft) /* Selector */
		case .acPanRight: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPanRight) /* Selector */
		case .acPan: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPan) /* Selector */
		case .acNewWindow: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACNewWindow) /* Selector */
		case .acTileHorizontally: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACTileHorizontally) /* Selector */
		case .acTileVertically: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACTileVertically) /* Selector */
		case .acFormat: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFormat) /* Selector */
		case .acEdit: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACEdit) /* Selector */
		case .acBold: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACBold) /* Selector */
		case .acItalics: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACItalics) /* Selector */
		case .acUnderline: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACUnderline) /* Selector */
		case .acStrikethrough: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACStrikethrough) /* Selector */
		case .acSubscript: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSubscript) /* Selector */
		case .acSuperscript: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSuperscript) /* Selector */
		case .acAllCaps: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACAllCaps) /* Selector */
		case .acRotate: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACRotate) /* Selector */
		case .acResize: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACResize) /* Selector */
		case .acFlipHorizontal: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFlipHorizontal) /* Selector */
		case .acFlipVertical: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFlipVertical) /* Selector */
		case .acMirrorHorizontal: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACMirrorHorizontal) /* Selector */
		case .acMirrorVertical: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACMirrorVertical) /* Selector */
		case .acFontSelect: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFontSelect) /* Selector */
		case .acFontColor: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFontColor) /* Selector */
		case .acFontSize: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFontSize) /* Selector */
		case .acJustifyLeft: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACJustifyLeft) /* Selector */
		case .acJustifyCenterH: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACJustifyCenterH) /* Selector */
		case .acJustifyRight: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACJustifyRight) /* Selector */
		case .acJustifyBlockH: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACJustifyBlockH) /* Selector */
		case .acJustifyTop: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACJustifyTop) /* Selector */
		case .acJustifyCenterV: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACJustifyCenterV) /* Selector */
		case .acJustifyBottom: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACJustifyBottom) /* Selector */
		case .acJustifyBlockV: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACJustifyBlockV) /* Selector */
		case .acIndentyDecrease: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACIndentyDecrease) /* Selector */
		case .acIndentyIncrease: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACIndentyIncrease) /* Selector */
		case .acNumberedList: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACNumberedList) /* Selector */
		case .acRestartNumbering: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACRestartNumbering) /* Selector */
		case .acBulletedList: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACBulletedList) /* Selector */
		case .acPromote: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPromote) /* Selector */
		case .acDemote: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACDemote) /* Selector */
		case .acYes: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACYes) /* Selector */
		case .acNo: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACNo) /* Selector */
		case .acCancel: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACCancel) /* Selector */
		case .acCatalog: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACCatalog) /* Selector */
		case .acBuyOrCheckout: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACBuyOrCheckout) /* Selector */
		case .acAddToCart: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACAddToCart) /* Selector */
		case .acExpand: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACExpand) /* Selector */
		case .acExpandAll: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACExpandAll) /* Selector */
		case .acCollapse: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACCollapse) /* Selector */
		case .acCollapseAll: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACCollapseAll) /* Selector */
		case .acPrintPreview: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPrintPreview) /* Selector */
		case .acPasteSpecial: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACPasteSpecial) /* Selector */
		case .acInsertMode: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACInsertMode) /* Selector */
		case .acDelete: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACDelete) /* Selector */
		case .acLock: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACLock) /* Selector */
		case .acUnlock: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACUnlock) /* Selector */
		case .acProtect: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACProtect) /* Selector */
		case .acUnprotect: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACUnprotect) /* Selector */
		case .acAttachComment: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACAttachComment) /* Selector */
		case .acDetachComment: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACDetachComment) /* Selector */
		case .acViewComment: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACViewComment) /* Selector */
		case .acSelectWord: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSelectWord) /* Selector */
		case .acSelectSentence: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSelectSentence) /* Selector */
		case .acSelectParagraph: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSelectParagraph) /* Selector */
		case .acSelectColumn: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSelectColumn) /* Selector */
		case .acSelectRow: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSelectRow) /* Selector */
		case .acSelectTable: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSelectTable) /* Selector */
		case .acSelectObject: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSelectObject) /* Selector */
		case .acRedoOrRepeat: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACRedoOrRepeat) /* Selector */
		case .acSort: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSort) /* Selector */
		case .acSortAscending: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSortAscending) /* Selector */
		case .acSortDescending: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSortDescending) /* Selector */
		case .acFilter: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACFilter) /* Selector */
		case .acSetClock: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSetClock) /* Selector */
		case .acViewClock: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACViewClock) /* Selector */
		case .acSelectTimeZone: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSelectTimeZone) /* Selector */
		case .acEditTimeZones: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACEditTimeZones) /* Selector */
		case .acSetAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSetAlarm) /* Selector */
		case .acClearAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACClearAlarm) /* Selector */
		case .acSnoozeAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSnoozeAlarm) /* Selector */
		case .acResetAlarm: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACResetAlarm) /* Selector */
		case .acSynchronize: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSynchronize) /* Selector */
		case .acSendOrReceive: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSendOrReceive) /* Selector */
		case .acSendTo: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSendTo) /* Selector */
		case .acReply: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACReply) /* Selector */
		case .acReplyAll: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACReplyAll) /* Selector */
		case .acForwardMessage: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACForwardMessage) /* Selector */
		case .acSend: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSend) /* Selector */
		case .acAttachFile: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACAttachFile) /* Selector */
		case .acUpload: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACUpload) /* Selector */
		case .acDownload: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACDownload) /* Selector */
		case .acSetBorders: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSetBorders) /* Selector */
		case .acInsertRow: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACInsertRow) /* Selector */
		case .acInsertColumn: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACInsertColumn) /* Selector */
		case .acInsertFile: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACInsertFile) /* Selector */
		case .acInsertPicture: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACInsertPicture) /* Selector */
		case .acInsertObject: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACInsertObject) /* Selector */
		case .acInsertSymbol: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACInsertSymbol) /* Selector */
		case .acSaveAndClose: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSaveAndClose) /* Selector */
		case .acRename: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACRename) /* Selector */
		case .acMerge: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACMerge) /* Selector */
		case .acSplit: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACSplit) /* Selector */
		case .acDistributeH: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACDistributeH) /* Selector */
		case .acDistributeV: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACDistributeV) /* Selector */
		case .acKeyboardLayoutSelect: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACKeyboardLayoutSelect) /* One-Shot Control */
		case .acNavigationGuidance: return (kHIDPage_Consumer, kHIDUsage_Csmr_ACNavigationGuidance) /* Selector */
			/* 0x29F - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_Consumer, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_Csmr_ConsumerControl: self = .consumerControl
		case kHIDUsage_Csmr_NumericKeyPad: self = .numericKeyPad
		case kHIDUsage_Csmr_ProgrammableButtons: self = .programmableButtons
		case kHIDUsage_Csmr_Microphone: self = .microphone
		case kHIDUsage_Csmr_Headphone: self = .headphone
		case kHIDUsage_Csmr_GraphicEqualizer: self = .graphicEqualizer
			/* 0x07 - 0x1F Reserved */
		case kHIDUsage_Csmr_Plus10: self = .plus10
		case kHIDUsage_Csmr_Plus100: self = .plus100
		case kHIDUsage_Csmr_AMOrPM: self = .amOrPM
			/* 0x23 - 0x3F Reserved */
		case kHIDUsage_Csmr_Power: self = .power
		case kHIDUsage_Csmr_Reset: self = .reset
		case kHIDUsage_Csmr_Sleep: self = .sleep
		case kHIDUsage_Csmr_SleepAfter: self = .sleepAfter
		case kHIDUsage_Csmr_SleepMode: self = .sleepMode
		case kHIDUsage_Csmr_Illumination: self = .illumination
		case kHIDUsage_Csmr_FunctionButtons: self = .functionButtons
			/* 0x37 - 0x3F Reserved */
		case kHIDUsage_Csmr_Menu: self = .menu
		case kHIDUsage_Csmr_MenuPick: self = .menuPick
		case kHIDUsage_Csmr_MenuUp: self = .menuUp
		case kHIDUsage_Csmr_MenuDown: self = .menuDown
		case kHIDUsage_Csmr_MenuLeft: self = .menuLeft
		case kHIDUsage_Csmr_MenuRight: self = .menuRight
		case kHIDUsage_Csmr_MenuEscape: self = .menuEscape
		case kHIDUsage_Csmr_MenuValueIncrease: self = .menuValueIncrease
		case kHIDUsage_Csmr_MenuValueDecrease: self = .menuValueDecrease
			/* 0x49 - 0x5F Reserved */
		case kHIDUsage_Csmr_DataOnScreen: self = .dataOnScreen
		case kHIDUsage_Csmr_ClosedCaption: self = .closedCaption
		case kHIDUsage_Csmr_ClosedCaptionSelect: self = .closedCaptionSelect
		case kHIDUsage_Csmr_VCROrTV: self = .vCROrTV
		case kHIDUsage_Csmr_BroadcastMode: self = .broadcastMode
		case kHIDUsage_Csmr_Snapshot: self = .snapshot
		case kHIDUsage_Csmr_Still: self = .still
		case kHIDUsage_Csmr_PictureInPictureToggle: self = .pictureInPictureToggle
		case kHIDUsage_Csmr_PictureInPictureSwap: self = .pictureInPictureSwap
		case kHIDUsage_Csmr_RedMenuButton: self = .redMenuButton
		case kHIDUsage_Csmr_GreenMenuButton: self = .greenMenuButton
		case kHIDUsage_Csmr_BlueMenuButton: self = .blueMenuButton
		case kHIDUsage_Csmr_YellowMenuButton: self = .yellowMenuButton
		case kHIDUsage_Csmr_Aspect: self = .aspect
		case kHIDUsage_Csmr_3DModeSelect: self = .threeDModeSelect
		case kHIDUsage_Csmr_DisplayBrightnessIncrement: self = .displayBrightnessIncrement
		case kHIDUsage_Csmr_DisplayBrightnessDecrement: self = .displayBrightnessDecrement
		case kHIDUsage_Csmr_DisplayBrightness: self = .displayBrightness
		case kHIDUsage_Csmr_DisplayBacklightToggle: self = .displayBacklightToggle
		case kHIDUsage_Csmr_DisplayBrightnessMinimum: self = .displayBrightnessMinimum
		case kHIDUsage_Csmr_DisplayBrightnessMaximum: self = .displayBrightnessMaximum
		case kHIDUsage_Csmr_DisplayBrightnessSetAutoBrightness: self = .displayBrightnessSetAutoBrightness
			/* 0x76 - 0x7F Reserved */
		case kHIDUsage_Csmr_Selection: self = .selection
		case kHIDUsage_Csmr_Assign: self = .assign
		case kHIDUsage_Csmr_ModeStep: self = .modeStep
		case kHIDUsage_Csmr_RecallLast: self = .recallLast
		case kHIDUsage_Csmr_EnterChannel: self = .enterChannel
		case kHIDUsage_Csmr_OrderMovie: self = .orderMovie
		case kHIDUsage_Csmr_Channel: self = .channel
		case kHIDUsage_Csmr_MediaSelection: self = .mediaSelection
		case kHIDUsage_Csmr_MediaSelectComputer: self = .mediaSelectComputer
		case kHIDUsage_Csmr_MediaSelectTV: self = .mediaSelectTV
		case kHIDUsage_Csmr_MediaSelectWWW: self = .mediaSelectWWW
		case kHIDUsage_Csmr_MediaSelectDVD: self = .mediaSelectDVD
		case kHIDUsage_Csmr_MediaSelectTelephone: self = .mediaSelectTelephone
		case kHIDUsage_Csmr_MediaSelectProgramGuide: self = .mediaSelectProgramGuide
		case kHIDUsage_Csmr_MediaSelectVideoPhone: self = .mediaSelectVideoPhone
		case kHIDUsage_Csmr_MediaSelectGames: self = .mediaSelectGames
		case kHIDUsage_Csmr_MediaSelectMessages: self = .mediaSelectMessages
		case kHIDUsage_Csmr_MediaSelectCD: self = .mediaSelectCD
		case kHIDUsage_Csmr_MediaSelectVCR: self = .mediaSelectVCR
		case kHIDUsage_Csmr_MediaSelectTuner: self = .mediaSelectTuner
		case kHIDUsage_Csmr_Quit: self = .quit
		case kHIDUsage_Csmr_Help: self = .help
		case kHIDUsage_Csmr_MediaSelectTape: self = .mediaSelectTape
		case kHIDUsage_Csmr_MediaSelectCable: self = .mediaSelectCable
		case kHIDUsage_Csmr_MediaSelectSatellite: self = .mediaSelectSatellite
		case kHIDUsage_Csmr_MediaSelectSecurity: self = .mediaSelectSecurity
		case kHIDUsage_Csmr_MediaSelectHome: self = .mediaSelectHome
		case kHIDUsage_Csmr_MediaSelectCall: self = .mediaSelectCall
		case kHIDUsage_Csmr_ChannelIncrement: self = .channelIncrement
		case kHIDUsage_Csmr_ChannelDecrement: self = .channelDecrement
		case kHIDUsage_Csmr_Media: self = .media
			/* 0x9F Reserved */
		case kHIDUsage_Csmr_VCRPlus: self = .vcrPlus
		case kHIDUsage_Csmr_Once: self = .once
		case kHIDUsage_Csmr_Daily: self = .daily
		case kHIDUsage_Csmr_Weekly: self = .weekly
		case kHIDUsage_Csmr_Monthly: self = .monthly
			/* 0xA5 - 0xAF Reserved */
		case kHIDUsage_Csmr_Play: self = .play
		case kHIDUsage_Csmr_Pause: self = .pause
		case kHIDUsage_Csmr_Record: self = .record
		case kHIDUsage_Csmr_FastForward: self = .fastForward
		case kHIDUsage_Csmr_Rewind: self = .rewind
		case kHIDUsage_Csmr_ScanNextTrack: self = .scanNextTrack
		case kHIDUsage_Csmr_ScanPreviousTrack: self = .scanPreviousTrack
		case kHIDUsage_Csmr_Stop: self = .stop
		case kHIDUsage_Csmr_Eject: self = .eject
		case kHIDUsage_Csmr_RandomPlay: self = .randomPlay
		case kHIDUsage_Csmr_SelectDisc: self = .selectDisc
		case kHIDUsage_Csmr_EnterDisc: self = .enterDisc
		case kHIDUsage_Csmr_Repeat: self = .csmrRepeat
		case kHIDUsage_Csmr_Tracking: self = .tracking
		case kHIDUsage_Csmr_TrackNormal: self = .trackNormal
		case kHIDUsage_Csmr_SlowTracking: self = .slowTracking
		case kHIDUsage_Csmr_FrameForward: self = .frameForward
		case kHIDUsage_Csmr_FrameBack: self = .frameBack
		case kHIDUsage_Csmr_Mark: self = .mark
		case kHIDUsage_Csmr_ClearMark: self = .clearMark
		case kHIDUsage_Csmr_RepeatFromMark: self = .repeatFromMark
		case kHIDUsage_Csmr_ReturnToMark: self = .returnToMark
		case kHIDUsage_Csmr_SearchMarkForward: self = .searchMarkForward
		case kHIDUsage_Csmr_SearchMarkBackwards: self = .searchMarkBackwards
		case kHIDUsage_Csmr_CounterReset: self = .counterReset
		case kHIDUsage_Csmr_ShowCounter: self = .showCounter
		case kHIDUsage_Csmr_TrackingIncrement: self = .trackingIncrement
		case kHIDUsage_Csmr_TrackingDecrement: self = .trackingDecrement
		case kHIDUsage_Csmr_StopOrEject: self = .stopOrEject
		case kHIDUsage_Csmr_PlayOrPause: self = .playOrPause
		case kHIDUsage_Csmr_PlayOrSkip: self = .playOrSkip
		case kHIDUsage_Csmr_VoiceCommand: self = .voiceCommand
			/* 0xCF - 0xDF Reserved */
		case kHIDUsage_Csmr_Volume: self = .volume
		case kHIDUsage_Csmr_Balance: self = .balance
		case kHIDUsage_Csmr_Mute: self = .mute
		case kHIDUsage_Csmr_Bass: self = .bass
		case kHIDUsage_Csmr_Treble: self = .treble
		case kHIDUsage_Csmr_BassBoost: self = .bassBoost
		case kHIDUsage_Csmr_SurroundMode: self = .surroundMode
		case kHIDUsage_Csmr_Loudness: self = .loudness
		case kHIDUsage_Csmr_MPX: self = .mPX
		case kHIDUsage_Csmr_VolumeIncrement: self = .volumeIncrement
		case kHIDUsage_Csmr_VolumeDecrement: self = .volumeDecrement
			/* 0xEB - 0xEF Reserved */
		case kHIDUsage_Csmr_Speed: self = .speed
		case kHIDUsage_Csmr_PlaybackSpeed: self = .playbackSpeed
		case kHIDUsage_Csmr_StandardPlay: self = .standardPlay
		case kHIDUsage_Csmr_LongPlay: self = .longPlay
		case kHIDUsage_Csmr_ExtendedPlay: self = .extendedPlay
		case kHIDUsage_Csmr_Slow: self = .slow
			/* 0xF6 - 0xFF Reserved */
		case kHIDUsage_Csmr_FanEnable: self = .fanEnable
		case kHIDUsage_Csmr_FanSpeed: self = .fanSpeed
		case kHIDUsage_Csmr_LightEnable: self = .lightEnable
		case kHIDUsage_Csmr_LightIlluminationLevel: self = .lightIlluminationLevel
		case kHIDUsage_Csmr_ClimateControlEnable: self = .climateControlEnable
		case kHIDUsage_Csmr_RoomTemperature: self = .roomTemperature
		case kHIDUsage_Csmr_SecurityEnable: self = .securityEnable
		case kHIDUsage_Csmr_FireAlarm: self = .fireAlarm
		case kHIDUsage_Csmr_PoliceAlarm: self = .policeAlarm
		case kHIDUsage_Csmr_Proximity: self = .proximity
		case kHIDUsage_Csmr_Motion: self = .motion
		case kHIDUsage_Csmr_DuressAlarm: self = .duressAlarm
		case kHIDUsage_Csmr_HoldupAlarm: self = .holdupAlarm
		case kHIDUsage_Csmr_MedicalAlarm: self = .medicalAlarm
			/* 0x10E - 0x14F Reserved */
		case kHIDUsage_Csmr_BalanceRight: self = .balanceRight
		case kHIDUsage_Csmr_BalanceLeft: self = .balanceLeft
		case kHIDUsage_Csmr_BassIncrement: self = .bassIncrement
		case kHIDUsage_Csmr_BassDecrement: self = .bassDecrement
		case kHIDUsage_Csmr_TrebleIncrement: self = .trebleIncrement
		case kHIDUsage_Csmr_TrebleDecrement: self = .trebleDecrement
			/* 0x156 - 0x15F Reserved */
		case kHIDUsage_Csmr_SpeakerSystem: self = .speakerSystem
		case kHIDUsage_Csmr_ChannelLeft: self = .channelLeft
		case kHIDUsage_Csmr_ChannelRight: self = .channelRight
		case kHIDUsage_Csmr_ChannelCenter: self = .channelCenter
		case kHIDUsage_Csmr_ChannelFront: self = .channelFront
		case kHIDUsage_Csmr_ChannelCenterFront: self = .channelCenterFront
		case kHIDUsage_Csmr_ChannelSide: self = .channelSide
		case kHIDUsage_Csmr_ChannelSurround: self = .channelSurround
		case kHIDUsage_Csmr_ChannelLowFrequencyEnhancement: self = .channelLowFrequencyEnhancement
		case kHIDUsage_Csmr_ChannelTop: self = .channelTop
		case kHIDUsage_Csmr_ChannelUnknown: self = .channelUnknown
			/* 0x16B - 0x16F Reserved */
		case kHIDUsage_Csmr_SubChannel: self = .subChannel
		case kHIDUsage_Csmr_SubChannelIncrement: self = .subChannelIncrement
		case kHIDUsage_Csmr_SubChannelDecrement: self = .subChannelDecrement
		case kHIDUsage_Csmr_AlternateAudioIncrement: self = .alternateAudioIncrement
		case kHIDUsage_Csmr_AlternateAudioDecrement: self = .alternateAudioDecrement
			/* 0x175 - 0x17F Reserved */
		case kHIDUsage_Csmr_ApplicationLaunchButtons: self = .applicationLaunchButtons
		case kHIDUsage_Csmr_ALLaunchButtonConfigurationTool: self = .alLaunchButtonConfigurationTool
		case kHIDUsage_Csmr_ALProgrammableButtonConfiguration: self = .alProgrammableButtonConfiguration
		case kHIDUsage_Csmr_ALConsumerControlConfiguration: self = .alConsumerControlConfiguration
		case kHIDUsage_Csmr_ALWordProcessor: self = .alWordProcessor
		case kHIDUsage_Csmr_ALTextEditor: self = .alTextEditor
		case kHIDUsage_Csmr_ALSpreadsheet: self = .alSpreadsheet
		case kHIDUsage_Csmr_ALGraphicsEditor: self = .alGraphicsEditor
		case kHIDUsage_Csmr_ALPresentationApp: self = .alPresentationApp
		case kHIDUsage_Csmr_ALDatabaseApp: self = .alDatabaseApp
		case kHIDUsage_Csmr_ALEmailReader: self = .alEmailReader
		case kHIDUsage_Csmr_ALNewsreader: self = .alNewsreader
		case kHIDUsage_Csmr_ALVoicemail: self = .alVoicemail
		case kHIDUsage_Csmr_ALContactsOrAddressBook: self = .alContactsOrAddressBook
		case kHIDUsage_Csmr_ALCalendarOrSchedule: self = .alCalendarOrSchedule
		case kHIDUsage_Csmr_ALTaskOrProjectManager: self = .alTaskOrProjectManager
		case kHIDUsage_Csmr_ALLogOrJournalOrTimecard: self = .alLogOrJournalOrTimecard
		case kHIDUsage_Csmr_ALCheckbookOrFinance: self = .alCheckbookOrFinance
		case kHIDUsage_Csmr_ALCalculator: self = .alCalculator
		case kHIDUsage_Csmr_ALAOrVCaptureOrPlayback: self = .alAOrVCaptureOrPlayback
		case kHIDUsage_Csmr_ALLocalMachineBrowser: self = .alLocalMachineBrowser
		case kHIDUsage_Csmr_ALLANOrWANBrowser: self = .alLANOrWANBrowser
		case kHIDUsage_Csmr_ALInternetBrowser: self = .alInternetBrowser
		case kHIDUsage_Csmr_ALRemoteNetworkingOrISPConnect: self = .alRemoteNetworkingOrISPConnect
		case kHIDUsage_Csmr_ALNetworkConference: self = .alNetworkConference
		case kHIDUsage_Csmr_ALNetworkChat: self = .alNetworkChat
		case kHIDUsage_Csmr_ALTelephonyOrDialer: self = .alTelephonyOrDialer
		case kHIDUsage_Csmr_ALLogon: self = .alLogon
		case kHIDUsage_Csmr_ALLogoff: self = .alLogoff
		case kHIDUsage_Csmr_ALLogonOrLogoff: self = .alLogonOrLogoff
		case kHIDUsage_Csmr_ALTerminalLockOrScreensaver: self = .alTerminalLockOrScreensaver
		case kHIDUsage_Csmr_ALControlPanel: self = .alControlPanel
		case kHIDUsage_Csmr_ALCommandLineProcessorOrRun: self = .alCommandLineProcessorOrRun
		case kHIDUsage_Csmr_ALProcessOrTaskManager: self = .alProcessOrTaskManager
		case kHIDUsage_Csmr_AL: self = .al
		case kHIDUsage_Csmr_ALNextTaskOrApplication: self = .alNextTaskOrApplication
		case kHIDUsage_Csmr_ALPreviousTaskOrApplication: self = .alPreviousTaskOrApplication
		case kHIDUsage_Csmr_ALPreemptiveHaltTaskOrApplication: self = .alPreemptiveHaltTaskOrApplication
		case kHIDUsage_Csmr_ALIntegratedHelpCenter: self = .alIntegratedHelpCenter
		case kHIDUsage_Csmr_ALDocuments: self = .alDocuments
		case kHIDUsage_Csmr_ALThesaurus: self = .alThesaurus
		case kHIDUsage_Csmr_ALDictionary: self = .alDictionary
		case kHIDUsage_Csmr_ALDesktop: self = .alDesktop
		case kHIDUsage_Csmr_ALSpellCheck: self = .alSpellCheck
		case kHIDUsage_Csmr_ALGrammerCheck: self = .alGrammerCheck
		case kHIDUsage_Csmr_ALWirelessStatus: self = .alWirelessStatus
		case kHIDUsage_Csmr_ALKeyboardLayout: self = .alKeyboardLayout
		case kHIDUsage_Csmr_ALVirusProtection: self = .alVirusProtection
		case kHIDUsage_Csmr_ALEncryption: self = .alEncryption
		case kHIDUsage_Csmr_ALScreenSaver: self = .alScreenSaver
		case kHIDUsage_Csmr_ALAlarms: self = .alAlarms
		case kHIDUsage_Csmr_ALClock: self = .alClock
		case kHIDUsage_Csmr_ALFileBrowser: self = .alFileBrowser
		case kHIDUsage_Csmr_ALPowerStatus: self = .alPowerStatus
		case kHIDUsage_Csmr_ALImageBrowser: self = .alImageBrowser
		case kHIDUsage_Csmr_ALAudioBrowser: self = .alAudioBrowser
		case kHIDUsage_Csmr_ALMovieBrowser: self = .alMovieBrowser
		case kHIDUsage_Csmr_ALDigitalRightsManager: self = .alDigitalRightsManager
		case kHIDUsage_Csmr_ALDigitalWallet: self = .alDigitalWallet
			/* 0x1BB Reserved */
		case kHIDUsage_Csmr_ALInstantMessaging: self = .alInstantMessaging
		case kHIDUsage_Csmr_ALOEMFeatureBrowser: self = .alOEMFeatureBrowser
		case kHIDUsage_Csmr_ALOEMHelp: self = .alOEMHelp
		case kHIDUsage_Csmr_ALOnlineCommunity: self = .alOnlineCommunity
		case kHIDUsage_Csmr_ALEntertainmentContentBrowser: self = .alEntertainmentContentBrowser
		case kHIDUsage_Csmr_ALOnlineShoppingBrowswer: self = .alOnlineShoppingBrowswer
		case kHIDUsage_Csmr_ALSmartCardInformationOrHelp: self = .alSmartCardInformationOrHelp
		case kHIDUsage_Csmr_ALMarketMonitorOrFinanceBrowser: self = .alMarketMonitorOrFinanceBrowser
		case kHIDUsage_Csmr_ALCustomizedCorporateNewsBrowser: self = .alCustomizedCorporateNewsBrowser
		case kHIDUsage_Csmr_ALOnlineActivityBrowswer: self = .alOnlineActivityBrowswer
		case kHIDUsage_Csmr_ALResearchOrSearchBrowswer: self = .alResearchOrSearchBrowswer
		case kHIDUsage_Csmr_ALAudioPlayer: self = .alAudioPlayer
		case kHIDUsage_Csmr_ALNavigation: self = .alNavigation
			/* 0x1C9 - 0x1FF Reserved */
		case kHIDUsage_Csmr_GenericGUIApplicationControls: self = .genericGUIApplicationControls
		case kHIDUsage_Csmr_ACNew: self = .acNew
		case kHIDUsage_Csmr_ACOpen: self = .acOpen
		case kHIDUsage_Csmr_ACClose: self = .acClose
		case kHIDUsage_Csmr_ACExit: self = .acExit
		case kHIDUsage_Csmr_ACMaximize: self = .acMaximize
		case kHIDUsage_Csmr_ACMinimize: self = .acMinimize
		case kHIDUsage_Csmr_ACSave: self = .acSave
		case kHIDUsage_Csmr_ACPrint: self = .acPrint
		case kHIDUsage_Csmr_ACProperties: self = .acProperties
		case kHIDUsage_Csmr_ACUndo: self = .acUndo
		case kHIDUsage_Csmr_ACCopy: self = .acCopy
		case kHIDUsage_Csmr_ACCut: self = .acCut
		case kHIDUsage_Csmr_ACPaste: self = .acPaste
		case kHIDUsage_Csmr_AC: self = .aC
		case kHIDUsage_Csmr_ACFind: self = .acFind
		case kHIDUsage_Csmr_ACFindandReplace: self = .acFindandReplace
		case kHIDUsage_Csmr_ACSearch: self = .acSearch
		case kHIDUsage_Csmr_ACGoTo: self = .acGoTo
		case kHIDUsage_Csmr_ACHome: self = .acHome
		case kHIDUsage_Csmr_ACBack: self = .acBack
		case kHIDUsage_Csmr_ACForward: self = .acForward
		case kHIDUsage_Csmr_ACStop: self = .acStop
		case kHIDUsage_Csmr_ACRefresh: self = .acRefresh
		case kHIDUsage_Csmr_ACPreviousLink: self = .acPreviousLink
		case kHIDUsage_Csmr_ACNextLink: self = .acNextLink
		case kHIDUsage_Csmr_ACBookmarks: self = .acBookmarks
		case kHIDUsage_Csmr_ACHistory: self = .acHistory
		case kHIDUsage_Csmr_ACSubscriptions: self = .acSubscriptions
		case kHIDUsage_Csmr_ACZoomIn: self = .acZoomIn
		case kHIDUsage_Csmr_ACZoomOut: self = .acZoomOut
		case kHIDUsage_Csmr_ACZoom: self = .acZoom
		case kHIDUsage_Csmr_ACFullScreenView: self = .acFullScreenView
		case kHIDUsage_Csmr_ACNormalView: self = .acNormalView
		case kHIDUsage_Csmr_ACViewToggle: self = .acViewToggle
		case kHIDUsage_Csmr_ACScrollUp: self = .acScrollUp
		case kHIDUsage_Csmr_ACScrollDown: self = .acScrollDown
		case kHIDUsage_Csmr_ACScroll: self = .acScroll
		case kHIDUsage_Csmr_ACPanLeft: self = .acPanLeft
		case kHIDUsage_Csmr_ACPanRight: self = .acPanRight
		case kHIDUsage_Csmr_ACPan: self = .acPan
		case kHIDUsage_Csmr_ACNewWindow: self = .acNewWindow
		case kHIDUsage_Csmr_ACTileHorizontally: self = .acTileHorizontally
		case kHIDUsage_Csmr_ACTileVertically: self = .acTileVertically
		case kHIDUsage_Csmr_ACFormat: self = .acFormat
		case kHIDUsage_Csmr_ACEdit: self = .acEdit
		case kHIDUsage_Csmr_ACBold: self = .acBold
		case kHIDUsage_Csmr_ACItalics: self = .acItalics
		case kHIDUsage_Csmr_ACUnderline: self = .acUnderline
		case kHIDUsage_Csmr_ACStrikethrough: self = .acStrikethrough
		case kHIDUsage_Csmr_ACSubscript: self = .acSubscript
		case kHIDUsage_Csmr_ACSuperscript: self = .acSuperscript
		case kHIDUsage_Csmr_ACAllCaps: self = .acAllCaps
		case kHIDUsage_Csmr_ACRotate: self = .acRotate
		case kHIDUsage_Csmr_ACResize: self = .acResize
		case kHIDUsage_Csmr_ACFlipHorizontal: self = .acFlipHorizontal
		case kHIDUsage_Csmr_ACFlipVertical: self = .acFlipVertical
		case kHIDUsage_Csmr_ACMirrorHorizontal: self = .acMirrorHorizontal
		case kHIDUsage_Csmr_ACMirrorVertical: self = .acMirrorVertical
		case kHIDUsage_Csmr_ACFontSelect: self = .acFontSelect
		case kHIDUsage_Csmr_ACFontColor: self = .acFontColor
		case kHIDUsage_Csmr_ACFontSize: self = .acFontSize
		case kHIDUsage_Csmr_ACJustifyLeft: self = .acJustifyLeft
		case kHIDUsage_Csmr_ACJustifyCenterH: self = .acJustifyCenterH
		case kHIDUsage_Csmr_ACJustifyRight: self = .acJustifyRight
		case kHIDUsage_Csmr_ACJustifyBlockH: self = .acJustifyBlockH
		case kHIDUsage_Csmr_ACJustifyTop: self = .acJustifyTop
		case kHIDUsage_Csmr_ACJustifyCenterV: self = .acJustifyCenterV
		case kHIDUsage_Csmr_ACJustifyBottom: self = .acJustifyBottom
		case kHIDUsage_Csmr_ACJustifyBlockV: self = .acJustifyBlockV
		case kHIDUsage_Csmr_ACIndentyDecrease: self = .acIndentyDecrease
		case kHIDUsage_Csmr_ACIndentyIncrease: self = .acIndentyIncrease
		case kHIDUsage_Csmr_ACNumberedList: self = .acNumberedList
		case kHIDUsage_Csmr_ACRestartNumbering: self = .acRestartNumbering
		case kHIDUsage_Csmr_ACBulletedList: self = .acBulletedList
		case kHIDUsage_Csmr_ACPromote: self = .acPromote
		case kHIDUsage_Csmr_ACDemote: self = .acDemote
		case kHIDUsage_Csmr_ACYes: self = .acYes
		case kHIDUsage_Csmr_ACNo: self = .acNo
		case kHIDUsage_Csmr_ACCancel: self = .acCancel
		case kHIDUsage_Csmr_ACCatalog: self = .acCatalog
		case kHIDUsage_Csmr_ACBuyOrCheckout: self = .acBuyOrCheckout
		case kHIDUsage_Csmr_ACAddToCart: self = .acAddToCart
		case kHIDUsage_Csmr_ACExpand: self = .acExpand
		case kHIDUsage_Csmr_ACExpandAll: self = .acExpandAll
		case kHIDUsage_Csmr_ACCollapse: self = .acCollapse
		case kHIDUsage_Csmr_ACCollapseAll: self = .acCollapseAll
		case kHIDUsage_Csmr_ACPrintPreview: self = .acPrintPreview
		case kHIDUsage_Csmr_ACPasteSpecial: self = .acPasteSpecial
		case kHIDUsage_Csmr_ACInsertMode: self = .acInsertMode
		case kHIDUsage_Csmr_ACDelete: self = .acDelete
		case kHIDUsage_Csmr_ACLock: self = .acLock
		case kHIDUsage_Csmr_ACUnlock: self = .acUnlock
		case kHIDUsage_Csmr_ACProtect: self = .acProtect
		case kHIDUsage_Csmr_ACUnprotect: self = .acUnprotect
		case kHIDUsage_Csmr_ACAttachComment: self = .acAttachComment
		case kHIDUsage_Csmr_ACDetachComment: self = .acDetachComment
		case kHIDUsage_Csmr_ACViewComment: self = .acViewComment
		case kHIDUsage_Csmr_ACSelectWord: self = .acSelectWord
		case kHIDUsage_Csmr_ACSelectSentence: self = .acSelectSentence
		case kHIDUsage_Csmr_ACSelectParagraph: self = .acSelectParagraph
		case kHIDUsage_Csmr_ACSelectColumn: self = .acSelectColumn
		case kHIDUsage_Csmr_ACSelectRow: self = .acSelectRow
		case kHIDUsage_Csmr_ACSelectTable: self = .acSelectTable
		case kHIDUsage_Csmr_ACSelectObject: self = .acSelectObject
		case kHIDUsage_Csmr_ACRedoOrRepeat: self = .acRedoOrRepeat
		case kHIDUsage_Csmr_ACSort: self = .acSort
		case kHIDUsage_Csmr_ACSortAscending: self = .acSortAscending
		case kHIDUsage_Csmr_ACSortDescending: self = .acSortDescending
		case kHIDUsage_Csmr_ACFilter: self = .acFilter
		case kHIDUsage_Csmr_ACSetClock: self = .acSetClock
		case kHIDUsage_Csmr_ACViewClock: self = .acViewClock
		case kHIDUsage_Csmr_ACSelectTimeZone: self = .acSelectTimeZone
		case kHIDUsage_Csmr_ACEditTimeZones: self = .acEditTimeZones
		case kHIDUsage_Csmr_ACSetAlarm: self = .acSetAlarm
		case kHIDUsage_Csmr_ACClearAlarm: self = .acClearAlarm
		case kHIDUsage_Csmr_ACSnoozeAlarm: self = .acSnoozeAlarm
		case kHIDUsage_Csmr_ACResetAlarm: self = .acResetAlarm
		case kHIDUsage_Csmr_ACSynchronize: self = .acSynchronize
		case kHIDUsage_Csmr_ACSendOrReceive: self = .acSendOrReceive
		case kHIDUsage_Csmr_ACSendTo: self = .acSendTo
		case kHIDUsage_Csmr_ACReply: self = .acReply
		case kHIDUsage_Csmr_ACReplyAll: self = .acReplyAll
		case kHIDUsage_Csmr_ACForwardMessage: self = .acForwardMessage
		case kHIDUsage_Csmr_ACSend: self = .acSend
		case kHIDUsage_Csmr_ACAttachFile: self = .acAttachFile
		case kHIDUsage_Csmr_ACUpload: self = .acUpload
		case kHIDUsage_Csmr_ACDownload: self = .acDownload
		case kHIDUsage_Csmr_ACSetBorders: self = .acSetBorders
		case kHIDUsage_Csmr_ACInsertRow: self = .acInsertRow
		case kHIDUsage_Csmr_ACInsertColumn: self = .acInsertColumn
		case kHIDUsage_Csmr_ACInsertFile: self = .acInsertFile
		case kHIDUsage_Csmr_ACInsertPicture: self = .acInsertPicture
		case kHIDUsage_Csmr_ACInsertObject: self = .acInsertObject
		case kHIDUsage_Csmr_ACInsertSymbol: self = .acInsertSymbol
		case kHIDUsage_Csmr_ACSaveAndClose: self = .acSaveAndClose
		case kHIDUsage_Csmr_ACRename: self = .acRename
		case kHIDUsage_Csmr_ACMerge: self = .acMerge
		case kHIDUsage_Csmr_ACSplit: self = .acSplit
		case kHIDUsage_Csmr_ACDistributeH: self = .acDistributeH
		case kHIDUsage_Csmr_ACDistributeV: self = .acDistributeV
		case kHIDUsage_Csmr_ACKeyboardLayoutSelect: self = .acKeyboardLayoutSelect
		case kHIDUsage_Csmr_ACNavigationGuidance: self = .acNavigationGuidance
			/* 0x29F - 0xFFFF Reserved */
		case kHIDUsage_Csmr_Reserved: self = .reserved(kHIDUsage_Csmr_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/**
 Digitizer Page (0x0D)

 This section provides detailed descriptions of the usages employed by Digitizer Devices.
 */
public enum DigitizerUsage: IUsagePageUsage
{
	case undefined
	case digitizer /* Application Collection */
	case pen /* Application Collection */
	case lightPen /* Application Collection */
	case touchScreen /* Application Collection */
	case touchPad /* Application Collection */
	case whiteBoard /* Application Collection */
	case coordinateMeasuringMachine /* Application Collection */
	case threeDDigitizer /* Application Collection */
	case stereoPlotter /* Application Collection */
	case articulatedArm /* Application Collection */
	case armature /* Application Collection */
	case multiplePointDigitizer /* Application Collection */
	case freeSpaceWand /* Application Collection */
	case deviceConfiguration /* Application Collection */
	/* 0x0F - 0x1F Reserved */
	case stylus /* Logical Collection */
	case puck /* Logical Collection */
	case finger /* Logical Collection */
	case deviceSettings /* Logical Collection */
	case gestureCharacter /* Logical Collection */
	/* 0x25 - 0x2F Reserved */
	case tipPressure /* Dynamic Value */
	case barrelPressure /* Dynamic Value */
	case inRange /* Momentary Control */
	case touch /* Momentary Control */
	case untouch /* One-Shot Control */
	case tap /* One-Shot Control */
	case quality /* Dynamic Value */
	case dataValid /* Momentary Control */
	case transducerIndex /* Dynamic Value */
	case tabletFunctionKeys /* Logical Collection */
	case programChangeKeys /* Logical Collection */
	case batteryStrength /* Dynamic Value */
	case invert /* Momentary Control */
	case xTilt /* Dynamic Value */
	case yTilt /* Dynamic Value */
	case azimuth /* Dynamic Value */
	case altitude /* Dynamic Value */
	case twist /* Dynamic Value */
	case tipSwitch /* Momentary Control */
	case secondaryTipSwitch /* Momentary Control */
	case barrelSwitch /* Momentary Control */
	case eraser /* Momentary Control */
	case tabletPick /* Momentary Control */
	case touchValid /* Momentary Control */
	case width /* Dynamic Value */
	case height /* Dynamic Value */
	/* 0x4A - 0x50 Reserved */
	case contactIdentifier /* Dynamic Value */
	case deviceMode /* Dynamic Value */
	case deviceIdentifier /* Dynamic Value */
	case contactCount /* Dynamic Value */
	case contactCountMaximum /* Static Value */

	/* 0x56 - 0x5F Reserved */
	case gestureCharacterEnable /* Dynamic Flag */
	case gestureCharacterQuality /* Dynamic Value */
	case gestureCharacterDataLength /* Dynamic Value */
	case gestureCharacterData /* Buffered Bytes */
	case gestureCharacterEncoding /* Named Array */
	case gestureCharacterEncodingUTF8 /* Selector */
	case gestureCharacterEncodingUTF16LE /* Selector */
	case gestureCharacterEncodingUTF16BE /* Selector */
	case gestureCharacterEncodingUTF32LE /* Selector */
	case gestureCharacterEncodingUTF32BE /* Selector */

	/* 0x70 - 0xFFFF Reserved */
	case reserved(Int)

	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Digitizer, kHIDUsage_Undefined)
		case .digitizer: return (kHIDPage_Digitizer, kHIDUsage_Dig_Digitizer) /* Application Collection */
		case .pen: return (kHIDPage_Digitizer, kHIDUsage_Dig_Pen) /* Application Collection */
		case .lightPen: return (kHIDPage_Digitizer, kHIDUsage_Dig_LightPen) /* Application Collection */
		case .touchScreen: return (kHIDPage_Digitizer, kHIDUsage_Dig_TouchScreen) /* Application Collection */
		case .touchPad: return (kHIDPage_Digitizer, kHIDUsage_Dig_TouchPad) /* Application Collection */
		case .whiteBoard: return (kHIDPage_Digitizer, kHIDUsage_Dig_WhiteBoard) /* Application Collection */
		case .coordinateMeasuringMachine: return (kHIDPage_Digitizer, kHIDUsage_Dig_CoordinateMeasuringMachine) /* Application Collection */
		case .threeDDigitizer: return (kHIDPage_Digitizer, kHIDUsage_Dig_3DDigitizer) /* Application Collection */
		case .stereoPlotter: return (kHIDPage_Digitizer, kHIDUsage_Dig_StereoPlotter) /* Application Collection */
		case .articulatedArm: return (kHIDPage_Digitizer, kHIDUsage_Dig_ArticulatedArm) /* Application Collection */
		case .armature: return (kHIDPage_Digitizer, kHIDUsage_Dig_Armature) /* Application Collection */
		case .multiplePointDigitizer: return (kHIDPage_Digitizer, kHIDUsage_Dig_MultiplePointDigitizer) /* Application Collection */
		case .freeSpaceWand: return (kHIDPage_Digitizer, kHIDUsage_Dig_FreeSpaceWand) /* Application Collection */
		case .deviceConfiguration: return (kHIDPage_Digitizer, kHIDUsage_Dig_DeviceConfiguration) /* Application Collection */
			/* 0x0F - 0x1F Reserved */
		case .stylus: return (kHIDPage_Digitizer, kHIDUsage_Dig_Stylus) /* Logical Collection */
		case .puck: return (kHIDPage_Digitizer, kHIDUsage_Dig_Puck) /* Logical Collection */
		case .finger: return (kHIDPage_Digitizer, kHIDUsage_Dig_Finger) /* Logical Collection */
		case .deviceSettings: return (kHIDPage_Digitizer, kHIDUsage_Dig_DeviceSettings) /* Logical Collection */
		case .gestureCharacter: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacter) /* Logical Collection */
			/* 0x25 - 0x2F Reserved */
		case .tipPressure: return (kHIDPage_Digitizer, kHIDUsage_Dig_TipPressure) /* Dynamic Value */
		case .barrelPressure: return (kHIDPage_Digitizer, kHIDUsage_Dig_BarrelPressure) /* Dynamic Value */
		case .inRange: return (kHIDPage_Digitizer, kHIDUsage_Dig_InRange) /* Momentary Control */
		case .touch: return (kHIDPage_Digitizer, kHIDUsage_Dig_Touch) /* Momentary Control */
		case .untouch: return (kHIDPage_Digitizer, kHIDUsage_Dig_Untouch) /* One-Shot Control */
		case .tap: return (kHIDPage_Digitizer, kHIDUsage_Dig_Tap) /* One-Shot Control */
		case .quality: return (kHIDPage_Digitizer, kHIDUsage_Dig_Quality) /* Dynamic Value */
		case .dataValid: return (kHIDPage_Digitizer, kHIDUsage_Dig_DataValid) /* Momentary Control */
		case .transducerIndex: return (kHIDPage_Digitizer, kHIDUsage_Dig_TransducerIndex) /* Dynamic Value */
		case .tabletFunctionKeys: return (kHIDPage_Digitizer, kHIDUsage_Dig_TabletFunctionKeys) /* Logical Collection */
		case .programChangeKeys: return (kHIDPage_Digitizer, kHIDUsage_Dig_ProgramChangeKeys) /* Logical Collection */
		case .batteryStrength: return (kHIDPage_Digitizer, kHIDUsage_Dig_BatteryStrength) /* Dynamic Value */
		case .invert: return (kHIDPage_Digitizer, kHIDUsage_Dig_Invert) /* Momentary Control */
		case .xTilt: return (kHIDPage_Digitizer, kHIDUsage_Dig_XTilt) /* Dynamic Value */
		case .yTilt: return (kHIDPage_Digitizer, kHIDUsage_Dig_YTilt) /* Dynamic Value */
		case .azimuth: return (kHIDPage_Digitizer, kHIDUsage_Dig_Azimuth) /* Dynamic Value */
		case .altitude: return (kHIDPage_Digitizer, kHIDUsage_Dig_Altitude) /* Dynamic Value */
		case .twist: return (kHIDPage_Digitizer, kHIDUsage_Dig_Twist) /* Dynamic Value */
		case .tipSwitch: return (kHIDPage_Digitizer, kHIDUsage_Dig_TipSwitch) /* Momentary Control */
		case .secondaryTipSwitch: return (kHIDPage_Digitizer, kHIDUsage_Dig_SecondaryTipSwitch) /* Momentary Control */
		case .barrelSwitch: return (kHIDPage_Digitizer, kHIDUsage_Dig_BarrelSwitch) /* Momentary Control */
		case .eraser: return (kHIDPage_Digitizer, kHIDUsage_Dig_Eraser) /* Momentary Control */
		case .tabletPick: return (kHIDPage_Digitizer, kHIDUsage_Dig_TabletPick) /* Momentary Control */
		case .touchValid: return (kHIDPage_Digitizer, kHIDUsage_Dig_TouchValid) /* Momentary Control */
		case .width: return (kHIDPage_Digitizer, kHIDUsage_Dig_Width) /* Dynamic Value */
		case .height: return (kHIDPage_Digitizer, kHIDUsage_Dig_Height) /* Dynamic Value */
			/* 0x4A - 0x50 Reserved */
		case .contactIdentifier: return (kHIDPage_Digitizer, kHIDUsage_Dig_ContactIdentifier) /* Dynamic Value */
		case .deviceMode: return (kHIDPage_Digitizer, kHIDUsage_Dig_DeviceMode) /* Dynamic Value */
		case .deviceIdentifier: return (kHIDPage_Digitizer, kHIDUsage_Dig_DeviceIdentifier) /* Dynamic Value */
		case .contactCount: return (kHIDPage_Digitizer, kHIDUsage_Dig_ContactCount) /* Dynamic Value */
		case .contactCountMaximum: return (kHIDPage_Digitizer, kHIDUsage_Dig_ContactCountMaximum) /* Static Value */
			
			/* 0x56 - 0x5F Reserved */
		case .gestureCharacterEnable: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterEnable) /* Dynamic Flag */
		case .gestureCharacterQuality: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterQuality) /* Dynamic Value */
		case .gestureCharacterDataLength: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterDataLength) /* Dynamic Value */
		case .gestureCharacterData: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterData) /* Buffered Bytes */
		case .gestureCharacterEncoding: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterEncoding) /* Named Array */
		case .gestureCharacterEncodingUTF8: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterEncodingUTF8) /* Selector */
		case .gestureCharacterEncodingUTF16LE: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterEncodingUTF16LE) /* Selector */
		case .gestureCharacterEncodingUTF16BE: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterEncodingUTF16BE) /* Selector */
		case .gestureCharacterEncodingUTF32LE: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterEncodingUTF32LE) /* Selector */
		case .gestureCharacterEncodingUTF32BE: return (kHIDPage_Digitizer, kHIDUsage_Dig_GestureCharacterEncodingUTF32BE) /* Selector */
			
			/* 0x70 - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_Digitizer, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_Dig_Digitizer: self = .digitizer
		case kHIDUsage_Dig_Pen: self = .pen
		case kHIDUsage_Dig_LightPen: self = .lightPen
		case kHIDUsage_Dig_TouchScreen: self = .touchScreen
		case kHIDUsage_Dig_TouchPad: self = .touchPad
		case kHIDUsage_Dig_WhiteBoard: self = .whiteBoard
		case kHIDUsage_Dig_CoordinateMeasuringMachine: self = .coordinateMeasuringMachine
		case kHIDUsage_Dig_3DDigitizer: self = .threeDDigitizer
		case kHIDUsage_Dig_StereoPlotter: self = .stereoPlotter
		case kHIDUsage_Dig_ArticulatedArm: self = .articulatedArm
		case kHIDUsage_Dig_Armature: self = .armature
		case kHIDUsage_Dig_MultiplePointDigitizer: self = .multiplePointDigitizer
		case kHIDUsage_Dig_FreeSpaceWand: self = .freeSpaceWand
		case kHIDUsage_Dig_DeviceConfiguration: self = .deviceConfiguration
			/* 0x0F - 0x1F Reserved */
		case kHIDUsage_Dig_Stylus: self = .stylus
		case kHIDUsage_Dig_Puck: self = .puck
		case kHIDUsage_Dig_Finger: self = .finger
		case kHIDUsage_Dig_DeviceSettings: self = .deviceSettings
		case kHIDUsage_Dig_GestureCharacter: self = .gestureCharacter
			/* 0x25 - 0x2F Reserved */
		case kHIDUsage_Dig_TipPressure: self = .tipPressure
		case kHIDUsage_Dig_BarrelPressure: self = .barrelPressure
		case kHIDUsage_Dig_InRange: self = .inRange
		case kHIDUsage_Dig_Touch: self = .touch
		case kHIDUsage_Dig_Untouch: self = .untouch
		case kHIDUsage_Dig_Tap: self = .tap
		case kHIDUsage_Dig_Quality: self = .quality
		case kHIDUsage_Dig_DataValid: self = .dataValid
		case kHIDUsage_Dig_TransducerIndex: self = .transducerIndex
		case kHIDUsage_Dig_TabletFunctionKeys: self = .tabletFunctionKeys
		case kHIDUsage_Dig_ProgramChangeKeys: self = .programChangeKeys
		case kHIDUsage_Dig_BatteryStrength: self = .batteryStrength
		case kHIDUsage_Dig_Invert: self = .invert
		case kHIDUsage_Dig_XTilt: self = .xTilt
		case kHIDUsage_Dig_YTilt: self = .yTilt
		case kHIDUsage_Dig_Azimuth: self = .azimuth
		case kHIDUsage_Dig_Altitude: self = .altitude
		case kHIDUsage_Dig_Twist: self = .twist
		case kHIDUsage_Dig_TipSwitch: self = .tipSwitch
		case kHIDUsage_Dig_SecondaryTipSwitch: self = .secondaryTipSwitch
		case kHIDUsage_Dig_BarrelSwitch: self = .barrelSwitch
		case kHIDUsage_Dig_Eraser: self = .eraser
		case kHIDUsage_Dig_TabletPick: self = .tabletPick
		case kHIDUsage_Dig_TouchValid: self = .touchValid
		case kHIDUsage_Dig_Width: self = .width
		case kHIDUsage_Dig_Height: self = .height
			/* 0x4A - 0x50 Reserved */
		case kHIDUsage_Dig_ContactIdentifier: self = .contactIdentifier
		case kHIDUsage_Dig_DeviceMode: self = .deviceMode
		case kHIDUsage_Dig_DeviceIdentifier: self = .deviceIdentifier
		case kHIDUsage_Dig_ContactCount: self = .contactCount
		case kHIDUsage_Dig_ContactCountMaximum: self = .contactCountMaximum
			
			/* 0x56 - 0x5F Reserved */
		case kHIDUsage_Dig_GestureCharacterEnable: self = .gestureCharacterEnable
		case kHIDUsage_Dig_GestureCharacterQuality: self = .gestureCharacterQuality
		case kHIDUsage_Dig_GestureCharacterDataLength: self = .gestureCharacterDataLength
		case kHIDUsage_Dig_GestureCharacterData: self = .gestureCharacterData
		case kHIDUsage_Dig_GestureCharacterEncoding: self = .gestureCharacterEncoding
		case kHIDUsage_Dig_GestureCharacterEncodingUTF8: self = .gestureCharacterEncodingUTF8
		case kHIDUsage_Dig_GestureCharacterEncodingUTF16LE: self = .gestureCharacterEncodingUTF16LE
		case kHIDUsage_Dig_GestureCharacterEncodingUTF16BE: self = .gestureCharacterEncodingUTF16BE
		case kHIDUsage_Dig_GestureCharacterEncodingUTF32LE: self = .gestureCharacterEncodingUTF32LE
		case kHIDUsage_Dig_GestureCharacterEncodingUTF32BE: self = .gestureCharacterEncodingUTF32BE
			
			/* 0x70 - 0xFFFF Reserved */
		case kHIDUsage_Dig_Reserved: self = .reserved(kHIDUsage_Dig_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/**
 Physical Interface Device Page (0x0F)

 This section provides detailed descriptions of the usages employed by Power Devices.
 */
public enum PhysicalInterfaceDeviceUsage: IUsagePageUsage
{
	case undefined
	case physicalInterfaceDevice        /* CA - A collection of PID usages */
	/* 0x02 - 0x1F Reserved */
	case normal                        /* DV - A force applied perpendicular to the surface of an object */
	case setEffectReport                /* XXX */
	case effectBlockIndex                /* XXX */
	case paramBlockOffset                /* XXX */
	case rom_Flag                        /* XXX */
	case effectType                    /* XXX */
	case et_ConstantForce                /* XXX */
	case et_Ramp                        /* XXX */
	case et_CustomForceData            /* XXX */
	/* 0x29 - 0x2F Reserved */
	case et_Square                        /* XXX */
	case et_Sine                        /* XXX */
	case et_Triangle                    /* XXX */
	case et_SawtoothUp                    /* XXX */
	case et_SawtoothDown                /* XXX */
	/* 0x35 - 0x3F Reserved */
	case et_Spring                        /* XXX */
	case et_Damper                        /* XXX */
	case et_Inertia                    /* XXX */
	case et_Friction                    /* XXX */
	/* 0x44 - 0x4F Reserved */
	case duration                        /* XXX */
	case samplePeriod                    /* XXX */
	case gain                            /* XXX */
	case triggerButton                    /* XXX */
	case triggerRepeatInterval            /* XXX */
	case axesEnable                    /* XXX */
	case directionEnable                /* XXX */
	case direction                        /* XXX */
	case typeSpecificBlockOffset        /* XXX */
	case blockType                        /* XXX */
	case setEnvelopeReport                /* XXX */
	case attackLevel                    /* XXX */
	case attackTime                    /* XXX */
	case fadeLevel                        /* XXX */
	case fadeTime                        /* XXX */
	case setConditionReport            /* XXX */

	case cp_Offset                        /* XXX */
	case positiveCoefficient            /* XXX */
	case negativeCoefficient            /* XXX */
	case positiveSaturation            /* XXX */
	case negativeSaturation            /* XXX */
	case deadBand                        /* XXX */
	case downloadForceSample            /* XXX */
	case isochCustomForceEnable        /* XXX */
	case customForceDataReport            /* XXX */
	case customForceData                /* XXX */
	case customForceVendorDefinedData    /* XXX */
	case setCustomForceReport            /* XXX */
	case customForceDataOffset            /* XXX */
	case sampleCount                    /* XXX */
	case setPeriodicReport                /* XXX */
	case offset                        /* XXX */

	case magnitude                        /* XXX */
	case phase                            /* XXX */
	case period                        /* XXX */
	case setConstantForceReport        /* XXX */
	case setRampForceReport            /* XXX */
	case rampStart                        /* XXX */
	case rampEnd                        /* XXX */
	case effectOperationReport            /* XXX */
	case effectOperation                /* XXX */
	case opEffectStart                    /* XXX */
	case opEffectStartSolo                /* XXX */
	case opEffectStop                    /* XXX */
	case loopCount                        /* XXX */
	case deviceGainReport                /* XXX */
	case deviceGain                    /* XXX */
	case poolReport                    /* XXX */

	case ram_PoolSize                    /* XXX */
	case rom_PoolSize                    /* XXX */
	case rom_EffectBlockCount            /* XXX */
	case simultaneousEffectsMax        /* XXX */
	case poolAlignment                    /* XXX */
	case poolMoveReport                /* XXX */
	case moveSource                    /* XXX */
	case moveDestination                /* XXX */
	case moveLength                    /* XXX */
	case blockLoadReport                /* XXX */
	/* 0x8A Reserved */
	case blockLoadStatus                /* XXX */
	case blockLoadSuccess                /* XXX */
	case blockLoadFull                    /* XXX */
	case blockLoadError                /* XXX */
	case blockHandle                    /* XXX */

	case blockFreeReport                /* XXX */
	case typeSpecificBlockHandle        /* XXX */
	case stateReport                    /* XXX */
	/* 0x93 Reserved */
	case effectPlaying                    /* XXX */
	case deviceControlReport            /* XXX */
	case deviceControl                    /* XXX */
	case dc_EnableActuators            /* XXX */
	case dc_DisableActuators            /* XXX */
	case dc_StopAllEffects                /* XXX */
	case dc_DeviceReset                /* XXX */
	case dc_DevicePause                /* XXX */
	case dc_DeviceContinue                /* XXX */
	/* 0x9d - 0x9E Reserved */
	case devicePaused                    /* XXX */

	case actuatorsEnabled                /* XXX */
	/* 0xA1 - 0xA3 Reserved */
	case safetySwitch                    /* XXX */
	case actuatorOverrideSwitch        /* XXX */
	case actuatorPower                    /* XXX */
	case startDelay                    /* XXX */
	case parameterBlockSize            /* XXX */
	case deviceManagedPool                /* XXX */
	case sharedParameterBlocks            /* XXX */
	case createNewEffectReport            /* XXX */
	case ram_PoolAvailable                /* XXX */
	/* 0xAD - 0xFFFF Reserved */
	case reserved(Int)

	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_PID, kHIDUsage_Undefined)
		case .physicalInterfaceDevice: return (kHIDPage_PID, kHIDUsage_PID_PhysicalInterfaceDevice)
			/* 0x02 - 0x1F Reserved */
		case .normal: return (kHIDPage_PID, kHIDUsage_PID_Normal)
		case .setEffectReport: return (kHIDPage_PID, kHIDUsage_PID_SetEffectReport)
		case .effectBlockIndex: return (kHIDPage_PID, kHIDUsage_PID_EffectBlockIndex)
		case .paramBlockOffset: return (kHIDPage_PID, kHIDUsage_PID_ParamBlockOffset)
		case .rom_Flag: return (kHIDPage_PID, kHIDUsage_PID_ROM_Flag)
		case .effectType: return (kHIDPage_PID, kHIDUsage_PID_EffectType)
		case .et_ConstantForce: return (kHIDPage_PID, kHIDUsage_PID_ET_ConstantForce)
		case .et_Ramp: return (kHIDPage_PID, kHIDUsage_PID_ET_Ramp)
		case .et_CustomForceData: return (kHIDPage_PID, kHIDUsage_PID_ET_CustomForceData)
			/* 0x29 - 0x2F Reserved */
		case .et_Square: return (kHIDPage_PID, kHIDUsage_PID_ET_Square)
		case .et_Sine: return (kHIDPage_PID, kHIDUsage_PID_ET_Sine)
		case .et_Triangle: return (kHIDPage_PID, kHIDUsage_PID_ET_Triangle)
		case .et_SawtoothUp: return (kHIDPage_PID, kHIDUsage_PID_ET_SawtoothUp)
		case .et_SawtoothDown: return (kHIDPage_PID, kHIDUsage_PID_ET_SawtoothDown)
			/* 0x35 - 0x3F Reserved */
		case .et_Spring: return (kHIDPage_PID, kHIDUsage_PID_ET_Spring)
		case .et_Damper: return (kHIDPage_PID, kHIDUsage_PID_ET_Damper)
		case .et_Inertia: return (kHIDPage_PID, kHIDUsage_PID_ET_Inertia)
		case .et_Friction: return (kHIDPage_PID, kHIDUsage_PID_ET_Friction)
			/* 0x44 - 0x4F Reserved */
		case .duration: return (kHIDPage_PID, kHIDUsage_PID_Duration)
		case .samplePeriod: return (kHIDPage_PID, kHIDUsage_PID_SamplePeriod)
		case .gain: return (kHIDPage_PID, kHIDUsage_PID_Gain)
		case .triggerButton: return (kHIDPage_PID, kHIDUsage_PID_TriggerButton)
		case .triggerRepeatInterval: return (kHIDPage_PID, kHIDUsage_PID_TriggerRepeatInterval)
		case .axesEnable: return (kHIDPage_PID, kHIDUsage_PID_AxesEnable)
		case .directionEnable: return (kHIDPage_PID, kHIDUsage_PID_DirectionEnable)
		case .direction: return (kHIDPage_PID, kHIDUsage_PID_Direction)
		case .typeSpecificBlockOffset: return (kHIDPage_PID, kHIDUsage_PID_TypeSpecificBlockOffset)
		case .blockType: return (kHIDPage_PID, kHIDUsage_PID_BlockType)
		case .setEnvelopeReport: return (kHIDPage_PID, kHIDUsage_PID_SetEnvelopeReport)
		case .attackLevel: return (kHIDPage_PID, kHIDUsage_PID_AttackLevel)
		case .attackTime: return (kHIDPage_PID, kHIDUsage_PID_AttackTime)
		case .fadeLevel: return (kHIDPage_PID, kHIDUsage_PID_FadeLevel)
		case .fadeTime: return (kHIDPage_PID, kHIDUsage_PID_FadeTime)
		case .setConditionReport: return (kHIDPage_PID, kHIDUsage_PID_SetConditionReport)
			
		case .cp_Offset: return (kHIDPage_PID, kHIDUsage_PID_CP_Offset)
		case .positiveCoefficient: return (kHIDPage_PID, kHIDUsage_PID_PositiveCoefficient)
		case .negativeCoefficient: return (kHIDPage_PID, kHIDUsage_PID_NegativeCoefficient)
		case .positiveSaturation: return (kHIDPage_PID, kHIDUsage_PID_PositiveSaturation)
		case .negativeSaturation: return (kHIDPage_PID, kHIDUsage_PID_NegativeSaturation)
		case .deadBand: return (kHIDPage_PID, kHIDUsage_PID_DeadBand)
		case .downloadForceSample: return (kHIDPage_PID, kHIDUsage_PID_DownloadForceSample)
		case .isochCustomForceEnable: return (kHIDPage_PID, kHIDUsage_PID_IsochCustomForceEnable)
		case .customForceDataReport: return (kHIDPage_PID, kHIDUsage_PID_CustomForceDataReport)
		case .customForceData: return (kHIDPage_PID, kHIDUsage_PID_CustomForceData)
		case .customForceVendorDefinedData: return (kHIDPage_PID, kHIDUsage_PID_CustomForceVendorDefinedData)
		case .setCustomForceReport: return (kHIDPage_PID, kHIDUsage_PID_SetCustomForceReport)
		case .customForceDataOffset: return (kHIDPage_PID, kHIDUsage_PID_CustomForceDataOffset)
		case .sampleCount: return (kHIDPage_PID, kHIDUsage_PID_SampleCount)
		case .setPeriodicReport: return (kHIDPage_PID, kHIDUsage_PID_SetPeriodicReport)
		case .offset: return (kHIDPage_PID, kHIDUsage_PID_Offset)
			
		case .magnitude: return (kHIDPage_PID, kHIDUsage_PID_Magnitude)
		case .phase: return (kHIDPage_PID, kHIDUsage_PID_Phase)
		case .period: return (kHIDPage_PID, kHIDUsage_PID_Period)
		case .setConstantForceReport: return (kHIDPage_PID, kHIDUsage_PID_SetConstantForceReport)
		case .setRampForceReport: return (kHIDPage_PID, kHIDUsage_PID_SetRampForceReport)
		case .rampStart: return (kHIDPage_PID, kHIDUsage_PID_RampStart)
		case .rampEnd: return (kHIDPage_PID, kHIDUsage_PID_RampEnd)
		case .effectOperationReport: return (kHIDPage_PID, kHIDUsage_PID_EffectOperationReport)
		case .effectOperation: return (kHIDPage_PID, kHIDUsage_PID_EffectOperation)
		case .opEffectStart: return (kHIDPage_PID, kHIDUsage_PID_OpEffectStart)
		case .opEffectStartSolo: return (kHIDPage_PID, kHIDUsage_PID_OpEffectStartSolo)
		case .opEffectStop: return (kHIDPage_PID, kHIDUsage_PID_OpEffectStop)
		case .loopCount: return (kHIDPage_PID, kHIDUsage_PID_LoopCount)
		case .deviceGainReport: return (kHIDPage_PID, kHIDUsage_PID_DeviceGainReport)
		case .deviceGain: return (kHIDPage_PID, kHIDUsage_PID_DeviceGain)
		case .poolReport: return (kHIDPage_PID, kHIDUsage_PID_PoolReport)
			
		case .ram_PoolSize: return (kHIDPage_PID, kHIDUsage_PID_RAM_PoolSize)
		case .rom_PoolSize: return (kHIDPage_PID, kHIDUsage_PID_ROM_PoolSize)
		case .rom_EffectBlockCount: return (kHIDPage_PID, kHIDUsage_PID_ROM_EffectBlockCount)
		case .simultaneousEffectsMax: return (kHIDPage_PID, kHIDUsage_PID_SimultaneousEffectsMax)
		case .poolAlignment: return (kHIDPage_PID, kHIDUsage_PID_PoolAlignment)
		case .poolMoveReport: return (kHIDPage_PID, kHIDUsage_PID_PoolMoveReport)
		case .moveSource: return (kHIDPage_PID, kHIDUsage_PID_MoveSource)
		case .moveDestination: return (kHIDPage_PID, kHIDUsage_PID_MoveDestination)
		case .moveLength: return (kHIDPage_PID, kHIDUsage_PID_MoveLength)
		case .blockLoadReport: return (kHIDPage_PID, kHIDUsage_PID_BlockLoadReport)
			/* 0x8A Reserved */
		case .blockLoadStatus: return (kHIDPage_PID, kHIDUsage_PID_BlockLoadStatus)
		case .blockLoadSuccess: return (kHIDPage_PID, kHIDUsage_PID_BlockLoadSuccess)
		case .blockLoadFull: return (kHIDPage_PID, kHIDUsage_PID_BlockLoadFull)
		case .blockLoadError: return (kHIDPage_PID, kHIDUsage_PID_BlockLoadError)
		case .blockHandle: return (kHIDPage_PID, kHIDUsage_PID_BlockHandle)
			
		case .blockFreeReport: return (kHIDPage_PID, kHIDUsage_PID_BlockFreeReport)
		case .typeSpecificBlockHandle: return (kHIDPage_PID, kHIDUsage_PID_TypeSpecificBlockHandle)
		case .stateReport: return (kHIDPage_PID, kHIDUsage_PID_StateReport)
			/* 0x93 Reserved */
		case .effectPlaying: return (kHIDPage_PID, kHIDUsage_PID_EffectPlaying)
		case .deviceControlReport: return (kHIDPage_PID, kHIDUsage_PID_DeviceControlReport)
		case .deviceControl: return (kHIDPage_PID, kHIDUsage_PID_DeviceControl)
		case .dc_EnableActuators: return (kHIDPage_PID, kHIDUsage_PID_DC_EnableActuators)
		case .dc_DisableActuators: return (kHIDPage_PID, kHIDUsage_PID_DC_DisableActuators)
		case .dc_StopAllEffects: return (kHIDPage_PID, kHIDUsage_PID_DC_StopAllEffects)
		case .dc_DeviceReset: return (kHIDPage_PID, kHIDUsage_PID_DC_DeviceReset)
		case .dc_DevicePause: return (kHIDPage_PID, kHIDUsage_PID_DC_DevicePause)
		case .dc_DeviceContinue: return (kHIDPage_PID, kHIDUsage_PID_DC_DeviceContinue)
			/* 0x9d - 0x9E Reserved */
		case .devicePaused: return (kHIDPage_PID, kHIDUsage_PID_DevicePaused)
			
		case .actuatorsEnabled: return (kHIDPage_PID, kHIDUsage_PID_ActuatorsEnabled)
			/* 0xA1 - 0xA3 Reserved */
		case .safetySwitch: return (kHIDPage_PID, kHIDUsage_PID_SafetySwitch)
		case .actuatorOverrideSwitch: return (kHIDPage_PID, kHIDUsage_PID_ActuatorOverrideSwitch)
		case .actuatorPower: return (kHIDPage_PID, kHIDUsage_PID_ActuatorPower)
		case .startDelay: return (kHIDPage_PID, kHIDUsage_PID_StartDelay)
		case .parameterBlockSize: return (kHIDPage_PID, kHIDUsage_PID_ParameterBlockSize)
		case .deviceManagedPool: return (kHIDPage_PID, kHIDUsage_PID_DeviceManagedPool)
		case .sharedParameterBlocks: return (kHIDPage_PID, kHIDUsage_PID_SharedParameterBlocks)
		case .createNewEffectReport: return (kHIDPage_PID, kHIDUsage_PID_CreateNewEffectReport)
		case .ram_PoolAvailable: return (kHIDPage_PID, kHIDUsage_PID_RAM_PoolAvailable)
			/* 0xAD - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_PID, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_PID_PhysicalInterfaceDevice: self = .physicalInterfaceDevice
			/* 0x02 - 0x1F Reserved */
		case kHIDUsage_PID_Normal: self = .normal
		case kHIDUsage_PID_SetEffectReport: self = .setEffectReport
		case kHIDUsage_PID_EffectBlockIndex: self = .effectBlockIndex
		case kHIDUsage_PID_ParamBlockOffset: self = .paramBlockOffset
		case kHIDUsage_PID_ROM_Flag: self = .rom_Flag
		case kHIDUsage_PID_EffectType: self = .effectType
		case kHIDUsage_PID_ET_ConstantForce: self = .et_ConstantForce
		case kHIDUsage_PID_ET_Ramp: self = .et_Ramp
		case kHIDUsage_PID_ET_CustomForceData: self = .et_CustomForceData
			/* 0x29 - 0x2F Reserved */
		case kHIDUsage_PID_ET_Square: self = .et_Square
		case kHIDUsage_PID_ET_Sine: self = .et_Sine
		case kHIDUsage_PID_ET_Triangle: self = .et_Triangle
		case kHIDUsage_PID_ET_SawtoothUp: self = .et_SawtoothUp
		case kHIDUsage_PID_ET_SawtoothDown: self = .et_SawtoothDown
			/* 0x35 - 0x3F Reserved */
		case kHIDUsage_PID_ET_Spring: self = .et_Spring
		case kHIDUsage_PID_ET_Damper: self = .et_Damper
		case kHIDUsage_PID_ET_Inertia: self = .et_Inertia
		case kHIDUsage_PID_ET_Friction: self = .et_Friction
			/* 0x44 - 0x4F Reserved */
		case kHIDUsage_PID_Duration: self = .duration
		case kHIDUsage_PID_SamplePeriod: self = .samplePeriod
		case kHIDUsage_PID_Gain: self = .gain
		case kHIDUsage_PID_TriggerButton: self = .triggerButton
		case kHIDUsage_PID_TriggerRepeatInterval: self = .triggerRepeatInterval
		case kHIDUsage_PID_AxesEnable: self = .axesEnable
		case kHIDUsage_PID_DirectionEnable: self = .directionEnable
		case kHIDUsage_PID_Direction: self = .direction
		case kHIDUsage_PID_TypeSpecificBlockOffset: self = .typeSpecificBlockOffset
		case kHIDUsage_PID_BlockType: self = .blockType
		case kHIDUsage_PID_SetEnvelopeReport: self = .setEnvelopeReport
		case kHIDUsage_PID_AttackLevel: self = .attackLevel
		case kHIDUsage_PID_AttackTime: self = .attackTime
		case kHIDUsage_PID_FadeLevel: self = .fadeLevel
		case kHIDUsage_PID_FadeTime: self = .fadeTime
		case kHIDUsage_PID_SetConditionReport: self = .setConditionReport
			
		case kHIDUsage_PID_CP_Offset: self = .cp_Offset
		case kHIDUsage_PID_PositiveCoefficient: self = .positiveCoefficient
		case kHIDUsage_PID_NegativeCoefficient: self = .negativeCoefficient
		case kHIDUsage_PID_PositiveSaturation: self = .positiveSaturation
		case kHIDUsage_PID_NegativeSaturation: self = .negativeSaturation
		case kHIDUsage_PID_DeadBand: self = .deadBand
		case kHIDUsage_PID_DownloadForceSample: self = .downloadForceSample
		case kHIDUsage_PID_IsochCustomForceEnable: self = .isochCustomForceEnable
		case kHIDUsage_PID_CustomForceDataReport: self = .customForceDataReport
		case kHIDUsage_PID_CustomForceData: self = .customForceData
		case kHIDUsage_PID_CustomForceVendorDefinedData: self = .customForceVendorDefinedData
		case kHIDUsage_PID_SetCustomForceReport: self = .setCustomForceReport
		case kHIDUsage_PID_CustomForceDataOffset: self = .customForceDataOffset
		case kHIDUsage_PID_SampleCount: self = .sampleCount
		case kHIDUsage_PID_SetPeriodicReport: self = .setPeriodicReport
		case kHIDUsage_PID_Offset: self = .offset
			
		case kHIDUsage_PID_Magnitude: self = .magnitude
		case kHIDUsage_PID_Phase: self = .phase
		case kHIDUsage_PID_Period: self = .period
		case kHIDUsage_PID_SetConstantForceReport: self = .setConstantForceReport
		case kHIDUsage_PID_SetRampForceReport: self = .setRampForceReport
		case kHIDUsage_PID_RampStart: self = .rampStart
		case kHIDUsage_PID_RampEnd: self = .rampEnd
		case kHIDUsage_PID_EffectOperationReport: self = .effectOperationReport
		case kHIDUsage_PID_EffectOperation: self = .effectOperation
		case kHIDUsage_PID_OpEffectStart: self = .opEffectStart
		case kHIDUsage_PID_OpEffectStartSolo: self = .opEffectStartSolo
		case kHIDUsage_PID_OpEffectStop: self = .opEffectStop
		case kHIDUsage_PID_LoopCount: self = .loopCount
		case kHIDUsage_PID_DeviceGainReport: self = .deviceGainReport
		case kHIDUsage_PID_DeviceGain: self = .deviceGain
		case kHIDUsage_PID_PoolReport: self = .poolReport
			
		case kHIDUsage_PID_RAM_PoolSize: self = .ram_PoolSize
		case kHIDUsage_PID_ROM_PoolSize: self = .rom_PoolSize
		case kHIDUsage_PID_ROM_EffectBlockCount: self = .rom_EffectBlockCount
		case kHIDUsage_PID_SimultaneousEffectsMax: self = .simultaneousEffectsMax
		case kHIDUsage_PID_PoolAlignment: self = .poolAlignment
		case kHIDUsage_PID_PoolMoveReport: self = .poolMoveReport
		case kHIDUsage_PID_MoveSource: self = .moveSource
		case kHIDUsage_PID_MoveDestination: self = .moveDestination
		case kHIDUsage_PID_MoveLength: self = .moveLength
		case kHIDUsage_PID_BlockLoadReport: self = .blockLoadReport
			/* 0x8A Reserved */
		case kHIDUsage_PID_BlockLoadStatus: self = .blockLoadStatus
		case kHIDUsage_PID_BlockLoadSuccess: self = .blockLoadSuccess
		case kHIDUsage_PID_BlockLoadFull: self = .blockLoadFull
		case kHIDUsage_PID_BlockLoadError: self = .blockLoadError
		case kHIDUsage_PID_BlockHandle: self = .blockHandle
			
		case kHIDUsage_PID_BlockFreeReport: self = .blockFreeReport
		case kHIDUsage_PID_TypeSpecificBlockHandle: self = .typeSpecificBlockHandle
		case kHIDUsage_PID_StateReport: self = .stateReport
			/* 0x93 Reserved */
		case kHIDUsage_PID_EffectPlaying: self = .effectPlaying
		case kHIDUsage_PID_DeviceControlReport: self = .deviceControlReport
		case kHIDUsage_PID_DeviceControl: self = .deviceControl
		case kHIDUsage_PID_DC_EnableActuators: self = .dc_EnableActuators
		case kHIDUsage_PID_DC_DisableActuators: self = .dc_DisableActuators
		case kHIDUsage_PID_DC_StopAllEffects: self = .dc_StopAllEffects
		case kHIDUsage_PID_DC_DeviceReset: self = .dc_DeviceReset
		case kHIDUsage_PID_DC_DevicePause: self = .dc_DevicePause
		case kHIDUsage_PID_DC_DeviceContinue: self = .dc_DeviceContinue
			/* 0x9d - 0x9E Reserved */
		case kHIDUsage_PID_DevicePaused: self = .devicePaused
			
		case kHIDUsage_PID_ActuatorsEnabled: self = .actuatorsEnabled
			/* 0xA1 - 0xA3 Reserved */
		case kHIDUsage_PID_SafetySwitch: self = .safetySwitch
		case kHIDUsage_PID_ActuatorOverrideSwitch: self = .actuatorOverrideSwitch
		case kHIDUsage_PID_ActuatorPower: self = .actuatorPower
		case kHIDUsage_PID_StartDelay: self = .startDelay
		case kHIDUsage_PID_ParameterBlockSize: self = .parameterBlockSize
		case kHIDUsage_PID_DeviceManagedPool: self = .deviceManagedPool
		case kHIDUsage_PID_SharedParameterBlocks: self = .sharedParameterBlocks
		case kHIDUsage_PID_CreateNewEffectReport: self = .createNewEffectReport
		case kHIDUsage_PID_RAM_PoolAvailable: self = .ram_PoolAvailable
			/* 0xAD - 0xFFFF Reserved */
		case kHIDUsage_PID_Reserved: self = .reserved(kHIDUsage_PID_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/**
 AlphanumericDisplay Page (0x14)

 The Alphanumeric Display page is intended for use by simple alphanumeric displays that are used on consumer devices.
 */
public enum AlphanumericDisplayUsage: IUsagePageUsage
{
	case undefined
	case alphanumericDisplay /* Application Collection */
	/* 0x02 - 0x1F Reserved */
	case displayAttributesReport /* Logical Collection */
	case aSCIICharacterSet /* Static Flag */
	case dataReadBack /* Static Flag */
	case fontReadBack /* Static Flag */
	case displayControlReport /* Logical Collection */
	case clearDisplay /* Dynamic Flag */
	case displayEnable /* Dynamic Flag */
	case screenSaverDelay /* Static Value */
	case screenSaverEnable /* Dynamic Flag */
	case verticalScroll /* Static Flag */
	case horizontalScroll /* Static Flag */
	case characterReport /* Logical Collection */
	case displayData /* Dynamic Value */
	case displayStatus /* Logical Collection */
	case statNotReady /* Selector */
	case statReady /* Selector */
	case errNotaloadablecharacter /* Selector */
	case errFontdatacannotberead /* Selector */
	case cursorPositionReport /* Logical Collection */
	case row /* Dynamic Value */
	case column /* Dynamic Value */
	case rows /* Static Value */
	case columns /* Static Value */
	case cursorPixelPositioning /* Static Flag */
	case cursorMode /* Dynamic Flag */
	case cursorEnable /* Dynamic Flag */
	case cursorBlink /* Dynamic Flag */
	case fontReport /* Logical Collection */
	case fontData /* Buffered Byte */
	case characterWidth /* Static Value */
	case characterHeight /* Static Value */
	case characterSpacingHorizontal /* Static Value */
	case characterSpacingVertical /* Static Value */
	case unicodeCharacterSet /* Static Flag */
	/* 0x42 - 0xFFFF Reserved */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_AlphanumericDisplay, kHIDUsage_Undefined)
		case .alphanumericDisplay: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_AlphanumericDisplay) /* Application Collection */
			/* 0x02 - 0x1F Reserved */
		case .displayAttributesReport: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_DisplayAttributesReport) /* Logical Collection */
		case .aSCIICharacterSet: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_ASCIICharacterSet) /* Static Flag */
		case .dataReadBack: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_DataReadBack) /* Static Flag */
		case .fontReadBack: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_FontReadBack) /* Static Flag */
		case .displayControlReport: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_DisplayControlReport) /* Logical Collection */
		case .clearDisplay: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_ClearDisplay) /* Dynamic Flag */
		case .displayEnable: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_DisplayEnable) /* Dynamic Flag */
		case .screenSaverDelay: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_ScreenSaverDelay) /* Static Value */
		case .screenSaverEnable: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_ScreenSaverEnable) /* Dynamic Flag */
		case .verticalScroll: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_VerticalScroll) /* Static Flag */
		case .horizontalScroll: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_HorizontalScroll) /* Static Flag */
		case .characterReport: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CharacterReport) /* Logical Collection */
		case .displayData: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_DisplayData) /* Dynamic Value */
		case .displayStatus: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_DisplayStatus) /* Logical Collection */
		case .statNotReady: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_StatNotReady) /* Selector */
		case .statReady: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_StatReady) /* Selector */
		case .errNotaloadablecharacter: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_ErrNotaloadablecharacter) /* Selector */
		case .errFontdatacannotberead: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_ErrFontdatacannotberead) /* Selector */
		case .cursorPositionReport: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CursorPositionReport) /* Logical Collection */
		case .row: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_Row) /* Dynamic Value */
		case .column: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_Column) /* Dynamic Value */
		case .rows: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_Rows) /* Static Value */
		case .columns: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_Columns) /* Static Value */
		case .cursorPixelPositioning: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CursorPixelPositioning) /* Static Flag */
		case .cursorMode: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CursorMode) /* Dynamic Flag */
		case .cursorEnable: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CursorEnable) /* Dynamic Flag */
		case .cursorBlink: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CursorBlink) /* Dynamic Flag */
		case .fontReport: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_FontReport) /* Logical Collection */
		case .fontData: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_FontData) /* Buffered Byte */
		case .characterWidth: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CharacterWidth) /* Static Value */
		case .characterHeight: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CharacterHeight) /* Static Value */
		case .characterSpacingHorizontal: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CharacterSpacingHorizontal) /* Static Value */
		case .characterSpacingVertical: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_CharacterSpacingVertical) /* Static Value */
		case .unicodeCharacterSet: return (kHIDPage_AlphanumericDisplay, kHIDUsage_AD_UnicodeCharacterSet) /* Static Flag */
			/* 0x42 - 0xFFFF Reserved */
		case .reserved(let val): return (kHIDPage_AlphanumericDisplay, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Undefined: self = .undefined
		case kHIDUsage_AD_AlphanumericDisplay: self = .alphanumericDisplay
			/* 0x02 - 0x1F Reserved */
		case kHIDUsage_AD_DisplayAttributesReport: self = .displayAttributesReport
		case kHIDUsage_AD_ASCIICharacterSet: self = .aSCIICharacterSet
		case kHIDUsage_AD_DataReadBack: self = .dataReadBack
		case kHIDUsage_AD_FontReadBack: self = .fontReadBack
		case kHIDUsage_AD_DisplayControlReport: self = .displayControlReport
		case kHIDUsage_AD_ClearDisplay: self = .clearDisplay
		case kHIDUsage_AD_DisplayEnable: self = .displayEnable
		case kHIDUsage_AD_ScreenSaverDelay: self = .screenSaverDelay
		case kHIDUsage_AD_ScreenSaverEnable: self = .screenSaverEnable
		case kHIDUsage_AD_VerticalScroll: self = .verticalScroll
		case kHIDUsage_AD_HorizontalScroll: self = .horizontalScroll
		case kHIDUsage_AD_CharacterReport: self = .characterReport
		case kHIDUsage_AD_DisplayData: self = .displayData
		case kHIDUsage_AD_DisplayStatus: self = .displayStatus
		case kHIDUsage_AD_StatNotReady: self = .statNotReady
		case kHIDUsage_AD_StatReady: self = .statReady
		case kHIDUsage_AD_ErrNotaloadablecharacter: self = .errNotaloadablecharacter
		case kHIDUsage_AD_ErrFontdatacannotberead: self = .errFontdatacannotberead
		case kHIDUsage_AD_CursorPositionReport: self = .cursorPositionReport
		case kHIDUsage_AD_Row: self = .row
		case kHIDUsage_AD_Column: self = .column
		case kHIDUsage_AD_Rows: self = .rows
		case kHIDUsage_AD_Columns: self = .columns
		case kHIDUsage_AD_CursorPixelPositioning: self = .cursorPixelPositioning
		case kHIDUsage_AD_CursorMode: self = .cursorMode
		case kHIDUsage_AD_CursorEnable: self = .cursorEnable
		case kHIDUsage_AD_CursorBlink: self = .cursorBlink
		case kHIDUsage_AD_FontReport: self = .fontReport
		case kHIDUsage_AD_FontData: self = .fontData
		case kHIDUsage_AD_CharacterWidth: self = .characterWidth
		case kHIDUsage_AD_CharacterHeight: self = .characterHeight
		case kHIDUsage_AD_CharacterSpacingHorizontal: self = .characterSpacingHorizontal
		case kHIDUsage_AD_CharacterSpacingVertical: self = .characterSpacingVertical
		case kHIDUsage_AD_UnicodeCharacterSet: self = .unicodeCharacterSet
			/* 0x42 - 0xFFFF Reserved */
		case kHIDUsage_AD_Reserved: self = .reserved(kHIDUsage_AD_Reserved)
		default: self = .reserved(usage)
		}
	}
}

/**
 Sensor Page (0x20)

 The Sensor page is intended for use by devices that capture biometric, electrical, environmental, light, location, mechanical, motion, orientation, scanner, etc events.
 */
public enum SensorUsage: IUsagePageUsage {
		case undefined
	case sensor     /* Application/Physical Collection */
	/* 0x02 - 0x0F Reserved */
	case biometric     /* Application/Physical Collection */
	case biometric_HumanPresence     /* Application/Physical Collection */
	case biometric_HumanProximity     /* Application/Physical Collection */
	case biometric_HumanTouch     /* Application/Physical Collection */
	/* 0x14 - 0x1F Reserved */
	case electrical     /* Application/Physical Collection */
	case electrical_Capacitance     /* Application/Physical Collection */
	case electrical_Current     /* Application/Physical Collection */
	case electrical_Power     /* Application/Physical Collection */
	case electrical_Inductance     /* Application/Physical Collection */
	case electrical_Resistance     /* Application/Physical Collection */
	case electrical_Voltage     /* Application/Physical Collection */
	case electrical_Potentiometer     /* Application/Physical Collection */
	case electrical_Frequency     /* Application/Physical Collection */
	case electrical_Period     /* Application/Physical Collection */
	/* 0x2A - 0x2F Reserved */
	case environmental     /* Application/Physical Collection */
	case environmental_AtmosphericPressure     /* Application/Physical Collection */
	case environmental_Humidity     /* Application/Physical Collection */
	case environmental_Temperature     /* Application/Physical Collection */
	case environmental_WindDirection     /* Application/Physical Collection */
	case environmental_WindSpeed     /* Application/Physical Collection */
	/* 0x36 - 0x3F Reserved */
	case light     /* Application/Physical Collection */
	case light_AmbientLight     /* Application/Physical Collection */
	case light_ConsumerInfrared     /* Application/Physical Collection */
	/* 0x43 - 0x4F Reserved */
	case location     /* Application/Physical Collection */
	case location_Broadcast     /* Application/Physical Collection */
	case location_DeadReckoning     /* Application/Physical Collection */
	case location_GPS     /* Application/Physical Collection */
	case location_Lookup     /* Application/Physical Collection */
	case location_Other     /* Application/Physical Collection */
	case location_Static     /* Application/Physical Collection */
	case location_Triangulation     /* Application/Physical Collection */
	/* 0x58 - 0x5F Reserved */
	case mechanical     /* Application/Physical Collection */
	case mechanical_BooleanSwitch     /* Application/Physical Collection */
	case mechanical_BooleanSwitchArray     /* Application/Physical Collection */
	case mechanical_MultivalueSwitch     /* Application/Physical Collection */
	case mechanical_Force     /* Application/Physical Collection */
	case mechanical_Pressure     /* Application/Physical Collection */
	case mechanical_Strain     /* Application/Physical Collection */
	case mechanical_Weight     /* Application/Physical Collection */
	case mechanical_HapticVibrator     /* Application/Physical Collection */
	case mechanical_HallEffectSwitch     /* Application/Physical Collection */
	/* 0x6A - 0x6F Reserved */
	case motion     /* Application/Physical Collection */
	case motion_Accelerometer1D     /* Application/Physical Collection */
	case motion_Accelerometer2D     /* Application/Physical Collection */
	case motion_Accelerometer3D     /* Application/Physical Collection */
	case motion_Gyrometer1D     /* Application/Physical Collection */
	case motion_Gyrometer2D     /* Application/Physical Collection */
	case motion_Gyrometer3D     /* Application/Physical Collection */
	case motion_MotionDetector     /* Application/Physical Collection */
	case motion_Speedometer     /* Application/Physical Collection */
	case motion_Accelerometer     /* Application/Physical Collection */
	case motion_Gyrometer     /* Application/Physical Collection */
	/* 0x7B - 0x7F Reserved */
	case orientation     /* Application/Physical Collection */
	case orientation_Compass1D     /* Application/Physical Collection */
	case orientation_Compass2D     /* Application/Physical Collection */
	case orientation_Compass3D     /* Application/Physical Collection */
	case orientation_Inclinometer1D     /* Application/Physical Collection */
	case orientation_Inclinometer2D     /* Application/Physical Collection */
	case orientation_Inclinometer3D     /* Application/Physical Collection */
	case orientation_Distance1D     /* Application/Physical Collection */
	case orientation_Distance2D     /* Application/Physical Collection */
	case orientation_Distance3D     /* Application/Physical Collection */
	case orientation_DeviceOrientation     /* Application/Physical Collection */
	case orientation_CompassD     /* Application/Physical Collection */
	case orientation_InclinometerD     /* Application/Physical Collection */
	case orientation_DistanceD     /* Application/Physical Collection */
	/* 0x8E - 0x8F Reserved */
	case scanner     /* Application/Physical Collection */
	case scanner_Barcode     /* Application/Physical Collection */
	case scanner_RFID     /* Application/Physical Collection */
	case scanner_NFC     /* Application/Physical Collection */
	/* 0x94 - 0x9F Reserved */
	case time     /* Application/Physical Collection */
	case time_AlarmTimer     /* Application/Physical Collection */
	case time_RealTimeClock     /* Application/Physical Collection */
	/* 0xA3 - 0xDF Reserved */
	case other     /* Application/Physical Collection */
	case other_Custom     /* Application/Physical Collection */
	case other_Generic     /* Application/Physical Collection */
	case other_GenericEnumerator     /* Application/Physical Collection */
	/* 0xE4 - 0xEF Reserved */
	/* 0xF0 - 0xFF Vendor Reserved */

	/* Common Sensor Type Data Fields */

	/* Usage Switches used in conjunction with other Data Usages. The value of the modifier is OR-ed in to the upper nibble of the 16bit Data Usage. */
	case modifier_None      /* Data Field Usage Switch */
	case modifier_ChangeSensitivityAbsolute      /* Data Field Usage Switch */
	case modifier_Max      /* Data Field Usage Switch */
	case modifier_Min      /* Data Field Usage Switch */
	case modifier_Accuracy      /* Data Field Usage Switch */
	case modifier_Resolution      /* Data Field Usage Switch */
	case modifier_ThresholdHigh      /* Data Field Usage Switch */
	case modifier_ThresholdLow      /* Data Field Usage Switch */
	case modifier_CalibrationOffset      /* Data Field Usage Switch */
	case modifier_CalibrationMultiplier      /* Data Field Usage Switch */
	case modifier_ReportInterval      /* Data Field Usage Switch */
	case modifier_FrequencyMax      /* Data Field Usage Switch */
	case modifier_PeriodMax      /* Data Field Usage Switch */
	case modifier_ChangeSensitivityPercentRange      /* Data Field Usage Switch */
	case modifier_ChangeSensitivityPercentRelative      /* Data Field Usage Switch */
	case modifier_VendorDefined      /* Data Field Usage Switch */

	/* Event Usages */
	case event
	case event_SensorState
	case event_SensorEvent
	/* 0x0203 - 0x02FF Event Reserved */

	case event_SensorState_Undefined
	case event_SensorState_Ready
	case event_SensorState_NotAvailable
	case event_SensorState_NoData
	case event_SensorState_Initializing
	case event_SensorState_AccessDenied
	case event_SensorState_Error
	/* 0x0807 - 0x080F Reserved */

	case event_SensorEvent_Unknown
	case event_SensorEvent_StateChanged
	case event_SensorEvent_PropertyChanged
	case event_SensorEvent_DataUpdated
	case event_SensorEvent_PollResponse
	case event_SensorEvent_ChangeSensitivity
	case event_SensorEvent_RangeMaxReached
	case event_SensorEvent_RangeMinReached
	case event_SensorEvent_HighThresholdCrossUp
	case event_SensorEvent_HighThresholdCrossDown
	case event_SensorEvent_LowThresholdCrossUp
	case event_SensorEvent_LowThresholdCrossDown
	case event_SensorEvent_ZeroThresholdCrossUp
	case event_SensorEvent_ZeroThresholdCrossDown
	case event_SensorEvent_PeriodExceeded
	case event_SensorEvent_FrequencyExceeded
	case event_SensorEvent_ComplexTrigger
	/* 0x0821 - 0x082F Reserved */

	/* Property Usages */
	case property
	case property_FriendlyName
	case property_PersistentUniqueID
	case property_SensorStatus
	case property_MinimumReportInterval
	case property_Manufacturer
	case property_Model
	case property_SerialNumber
	case property_Description
	case property_ConnectionType
	case property_DevicePath
	case property_HardwareRevision
	case property_FirmwareVersion
	case property_ReleaseData
	case property_ReportInterval
	case property_ChangeSensitivityAbsolute
	case property_ChangeSensitivityPercentRange
	case property_ChangeSensitivityPercentRelative
	case property_Accuracy
	case property_Resolution
	case property_Maximum
	case property_Minimum
	case property_ReportingState
	case property_SamplingRate
	case property_ResponseCurve
	case property_PowerState
	/* 0x031A - 0x03FF Reserved */

	case property_ConnectionType_Integrated
	case property_ConnectionType_Attached
	case property_ConnectionType_External
	/* 0x0833 - 0x083F Reserved */
	case property_ReportingState_NoEvents
	case property_ReportingState_AllEvents
	case property_ReportingState_ThresholdEvents
	case property_ReportingState_WakeNoEvents
	case property_ReportingState_WakeAllEvents
	case property_ReportingState_WakeThresholdEvents
	/* 0x0846 - 0x084F Reserved */
	case property_PowerState_Undefined
	case property_PowerState_D0_FullPower
	case property_PowerState_D1_LowPower
	case property_PowerState_D2_Standby
	case property_PowerState_D3_Sleep
	case property_PowerState_D4_PowerOff
	/* 0x0855 - 0x085F Reserved */
	case light_Illuminance

	/* Specific Sensor Type Data Fields */

	/* Biometric Sensor Data Fields */
	case data_Biometric
	case data_Biometric_HumanPresence
	case data_Biometric_HumanProximityRange
	case data_Biometric_HumanProximityOutOfRange
	case data_Biometric_HumanTouchState
	/* 0x04B5 - 0x04CF Reserved */
	case reserved(Int)

	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_Sensor, kHIDUsage_Snsr_Undefined)
		case .sensor: return (kHIDPage_Sensor, kHIDUsage_Snsr_Sensor)     /* Application/Physical Collection */
		/* 0x02 - 0x0F Reserved */
		case .biometric: return (kHIDPage_Sensor, kHIDUsage_Snsr_Biometric)     /* Application/Physical Collection */
		case .biometric_HumanPresence: return (kHIDPage_Sensor, kHIDUsage_Snsr_Biometric_HumanPresence)     /* Application/Physical Collection */
		case .biometric_HumanProximity: return (kHIDPage_Sensor, kHIDUsage_Snsr_Biometric_HumanProximity)     /* Application/Physical Collection */
		case .biometric_HumanTouch: return (kHIDPage_Sensor, kHIDUsage_Snsr_Biometric_HumanTouch)     /* Application/Physical Collection */
		/* 0x14 - 0x1F Reserved */
		case .electrical: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical)     /* Application/Physical Collection */
		case .electrical_Capacitance: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Capacitance)     /* Application/Physical Collection */
		case .electrical_Current: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Current)     /* Application/Physical Collection */
		case .electrical_Power: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Power)     /* Application/Physical Collection */
		case .electrical_Inductance: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Inductance)     /* Application/Physical Collection */
		case .electrical_Resistance: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Resistance)     /* Application/Physical Collection */
		case .electrical_Voltage: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Voltage)     /* Application/Physical Collection */
		case .electrical_Potentiometer: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Potentiometer)     /* Application/Physical Collection */
		case .electrical_Frequency: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Frequency)     /* Application/Physical Collection */
		case .electrical_Period: return (kHIDPage_Sensor, kHIDUsage_Snsr_Electrical_Period)     /* Application/Physical Collection */
		/* 0x2A - 0x2F Reserved */
		case .environmental: return (kHIDPage_Sensor, kHIDUsage_Snsr_Environmental)     /* Application/Physical Collection */
		case .environmental_AtmosphericPressure: return (kHIDPage_Sensor, kHIDUsage_Snsr_Environmental_AtmosphericPressure)     /* Application/Physical Collection */
		case .environmental_Humidity: return (kHIDPage_Sensor, kHIDUsage_Snsr_Environmental_Humidity)     /* Application/Physical Collection */
		case .environmental_Temperature: return (kHIDPage_Sensor, kHIDUsage_Snsr_Environmental_Temperature)     /* Application/Physical Collection */
		case .environmental_WindDirection: return (kHIDPage_Sensor, kHIDUsage_Snsr_Environmental_WindDirection)     /* Application/Physical Collection */
		case .environmental_WindSpeed: return (kHIDPage_Sensor, kHIDUsage_Snsr_Environmental_WindSpeed)     /* Application/Physical Collection */
		/* 0x36 - 0x3F Reserved */
		case .light: return (kHIDPage_Sensor, kHIDUsage_Snsr_Light)     /* Application/Physical Collection */
		case .light_AmbientLight: return (kHIDPage_Sensor, kHIDUsage_Snsr_Light_AmbientLight)     /* Application/Physical Collection */
		case .light_ConsumerInfrared: return (kHIDPage_Sensor, kHIDUsage_Snsr_Light_ConsumerInfrared)     /* Application/Physical Collection */
		/* 0x43 - 0x4F Reserved */
		case .location: return (kHIDPage_Sensor, kHIDUsage_Snsr_Location)     /* Application/Physical Collection */
		case .location_Broadcast: return (kHIDPage_Sensor, kHIDUsage_Snsr_Location_Broadcast)     /* Application/Physical Collection */
		case .location_DeadReckoning: return (kHIDPage_Sensor, kHIDUsage_Snsr_Location_DeadReckoning)     /* Application/Physical Collection */
		case .location_GPS: return (kHIDPage_Sensor, kHIDUsage_Snsr_Location_GPS)     /* Application/Physical Collection */
		case .location_Lookup: return (kHIDPage_Sensor, kHIDUsage_Snsr_Location_Lookup)     /* Application/Physical Collection */
		case .location_Other: return (kHIDPage_Sensor, kHIDUsage_Snsr_Location_Other)     /* Application/Physical Collection */
		case .location_Static: return (kHIDPage_Sensor, kHIDUsage_Snsr_Location_Static)     /* Application/Physical Collection */
		case .location_Triangulation: return (kHIDPage_Sensor, kHIDUsage_Snsr_Location_Triangulation)     /* Application/Physical Collection */
		/* 0x58 - 0x5F Reserved */
		case .mechanical: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical)     /* Application/Physical Collection */
		case .mechanical_BooleanSwitch: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_BooleanSwitch)     /* Application/Physical Collection */
		case .mechanical_BooleanSwitchArray: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_BooleanSwitchArray)     /* Application/Physical Collection */
		case .mechanical_MultivalueSwitch: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_MultivalueSwitch)     /* Application/Physical Collection */
		case .mechanical_Force: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_Force)     /* Application/Physical Collection */
		case .mechanical_Pressure: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_Pressure)     /* Application/Physical Collection */
		case .mechanical_Strain: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_Strain)     /* Application/Physical Collection */
		case .mechanical_Weight: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_Weight)     /* Application/Physical Collection */
		case .mechanical_HapticVibrator: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_HapticVibrator)     /* Application/Physical Collection */
		case .mechanical_HallEffectSwitch: return (kHIDPage_Sensor, kHIDUsage_Snsr_Mechanical_HallEffectSwitch)     /* Application/Physical Collection */
		/* 0x6A - 0x6F Reserved */
		case .motion: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion)     /* Application/Physical Collection */
		case .motion_Accelerometer1D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Accelerometer1D)     /* Application/Physical Collection */
		case .motion_Accelerometer2D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Accelerometer2D)     /* Application/Physical Collection */
		case .motion_Accelerometer3D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Accelerometer3D)     /* Application/Physical Collection */
		case .motion_Gyrometer1D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Gyrometer1D)     /* Application/Physical Collection */
		case .motion_Gyrometer2D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Gyrometer2D)     /* Application/Physical Collection */
		case .motion_Gyrometer3D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Gyrometer3D)     /* Application/Physical Collection */
		case .motion_MotionDetector: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_MotionDetector)     /* Application/Physical Collection */
		case .motion_Speedometer: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Speedometer)     /* Application/Physical Collection */
		case .motion_Accelerometer: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Accelerometer)     /* Application/Physical Collection */
		case .motion_Gyrometer: return (kHIDPage_Sensor, kHIDUsage_Snsr_Motion_Gyrometer)     /* Application/Physical Collection */
		/* 0x7B - 0x7F Reserved */
		case .orientation: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation)     /* Application/Physical Collection */
		case .orientation_Compass1D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Compass1D)     /* Application/Physical Collection */
		case .orientation_Compass2D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Compass2D)     /* Application/Physical Collection */
		case .orientation_Compass3D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Compass3D)     /* Application/Physical Collection */
		case .orientation_Inclinometer1D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Inclinometer1D)     /* Application/Physical Collection */
		case .orientation_Inclinometer2D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Inclinometer2D)     /* Application/Physical Collection */
		case .orientation_Inclinometer3D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Inclinometer3D)     /* Application/Physical Collection */
		case .orientation_Distance1D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Distance1D)     /* Application/Physical Collection */
		case .orientation_Distance2D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Distance2D)     /* Application/Physical Collection */
		case .orientation_Distance3D: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_Distance3D)     /* Application/Physical Collection */
		case .orientation_DeviceOrientation: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_DeviceOrientation)     /* Application/Physical Collection */
		case .orientation_CompassD: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_CompassD)     /* Application/Physical Collection */
		case .orientation_InclinometerD: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_InclinometerD)     /* Application/Physical Collection */
		case .orientation_DistanceD: return (kHIDPage_Sensor, kHIDUsage_Snsr_Orientation_DistanceD)     /* Application/Physical Collection */
		/* 0x8E - 0x8F Reserved */
		case .scanner: return (kHIDPage_Sensor, kHIDUsage_Snsr_Scanner)     /* Application/Physical Collection */
		case .scanner_Barcode: return (kHIDPage_Sensor, kHIDUsage_Snsr_Scanner_Barcode)     /* Application/Physical Collection */
		case .scanner_RFID: return (kHIDPage_Sensor, kHIDUsage_Snsr_Scanner_RFID)     /* Application/Physical Collection */
		case .scanner_NFC: return (kHIDPage_Sensor, kHIDUsage_Snsr_Scanner_NFC)     /* Application/Physical Collection */
		/* 0x94 - 0x9F Reserved */
		case .time: return (kHIDPage_Sensor, kHIDUsage_Snsr_Time)     /* Application/Physical Collection */
		case .time_AlarmTimer: return (kHIDPage_Sensor, kHIDUsage_Snsr_Time_AlarmTimer)     /* Application/Physical Collection */
		case .time_RealTimeClock: return (kHIDPage_Sensor, kHIDUsage_Snsr_Time_RealTimeClock)     /* Application/Physical Collection */
		/* 0xA3 - 0xDF Reserved */
		case .other: return (kHIDPage_Sensor, kHIDUsage_Snsr_Other)     /* Application/Physical Collection */
		case .other_Custom: return (kHIDPage_Sensor, kHIDUsage_Snsr_Other_Custom)     /* Application/Physical Collection */
		case .other_Generic: return (kHIDPage_Sensor, kHIDUsage_Snsr_Other_Generic)     /* Application/Physical Collection */
		case .other_GenericEnumerator: return (kHIDPage_Sensor, kHIDUsage_Snsr_Other_GenericEnumerator)     /* Application/Physical Collection */
		/* 0xE4 - 0xEF Reserved */
		/* 0xF0 - 0xFF Vendor Reserved */

		/* Common Sensor Type Data Fields */

		/* Usage Switches used in conjunction with other Data Usages. The value of the modifier is OR-ed in to the upper nibble of the 16bit Data Usage. */
		case .modifier_None: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_None)      /* Data Field Usage Switch */
		case .modifier_ChangeSensitivityAbsolute: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_ChangeSensitivityAbsolute)      /* Data Field Usage Switch */
		case .modifier_Max: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_Max)      /* Data Field Usage Switch */
		case .modifier_Min: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_Min)      /* Data Field Usage Switch */
		case .modifier_Accuracy: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_Accuracy)      /* Data Field Usage Switch */
		case .modifier_Resolution: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_Resolution)      /* Data Field Usage Switch */
		case .modifier_ThresholdHigh: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_ThresholdHigh)      /* Data Field Usage Switch */
		case .modifier_ThresholdLow: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_ThresholdLow)      /* Data Field Usage Switch */
		case .modifier_CalibrationOffset: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_CalibrationOffset)      /* Data Field Usage Switch */
		case .modifier_CalibrationMultiplier: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_CalibrationMultiplier)      /* Data Field Usage Switch */
		case .modifier_ReportInterval: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_ReportInterval)      /* Data Field Usage Switch */
		case .modifier_FrequencyMax: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_FrequencyMax)      /* Data Field Usage Switch */
		case .modifier_PeriodMax: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_PeriodMax)      /* Data Field Usage Switch */
		case .modifier_ChangeSensitivityPercentRange: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_ChangeSensitivityPercentRange)      /* Data Field Usage Switch */
		case .modifier_ChangeSensitivityPercentRelative: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_ChangeSensitivityPercentRelative)      /* Data Field Usage Switch */
		case .modifier_VendorDefined: return (kHIDPage_Sensor, kHIDUsage_Snsr_Modifier_VendorDefined)      /* Data Field Usage Switch */

		/* Event Usages */
		case .event: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event)
		case .event_SensorState: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorState)
		case .event_SensorEvent: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent)
		/* 0x0203 - 0x02FF Event Reserved */

		case .event_SensorState_Undefined: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorState_Undefined)
		case .event_SensorState_Ready: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorState_Ready)
		case .event_SensorState_NotAvailable: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorState_NotAvailable)
		case .event_SensorState_NoData: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorState_NoData)
		case .event_SensorState_Initializing: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorState_Initializing)
		case .event_SensorState_AccessDenied: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorState_AccessDenied)
		case .event_SensorState_Error: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorState_Error)
		/* 0x0807 - 0x080F Reserved */

		case .event_SensorEvent_Unknown: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_Unknown)
		case .event_SensorEvent_StateChanged: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_StateChanged)
		case .event_SensorEvent_PropertyChanged: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_PropertyChanged)
		case .event_SensorEvent_DataUpdated: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_DataUpdated)
		case .event_SensorEvent_PollResponse: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_PollResponse)
		case .event_SensorEvent_ChangeSensitivity: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_ChangeSensitivity)
		case .event_SensorEvent_RangeMaxReached: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_RangeMaxReached)
		case .event_SensorEvent_RangeMinReached: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_RangeMinReached)
		case .event_SensorEvent_HighThresholdCrossUp: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_HighThresholdCrossUp)
		case .event_SensorEvent_HighThresholdCrossDown: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_HighThresholdCrossDown)
		case .event_SensorEvent_LowThresholdCrossUp: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_LowThresholdCrossUp)
		case .event_SensorEvent_LowThresholdCrossDown: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_LowThresholdCrossDown)
		case .event_SensorEvent_ZeroThresholdCrossUp: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_ZeroThresholdCrossUp)
		case .event_SensorEvent_ZeroThresholdCrossDown: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_ZeroThresholdCrossDown)
		case .event_SensorEvent_PeriodExceeded: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_PeriodExceeded)
		case .event_SensorEvent_FrequencyExceeded: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_FrequencyExceeded)
		case .event_SensorEvent_ComplexTrigger: return (kHIDPage_Sensor, kHIDUsage_Snsr_Event_SensorEvent_ComplexTrigger)
		/* 0x0821 - 0x082F Reserved */

		/* Property Usages */
		case .property: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property)
		case .property_FriendlyName: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_FriendlyName)
		case .property_PersistentUniqueID: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_PersistentUniqueID)
		case .property_SensorStatus: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_SensorStatus)
		case .property_MinimumReportInterval: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_MinimumReportInterval)
		case .property_Manufacturer: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_Manufacturer)
		case .property_Model: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_Model)
		case .property_SerialNumber: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_SerialNumber)
		case .property_Description: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_Description)
		case .property_ConnectionType: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ConnectionType)
		case .property_DevicePath: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_DevicePath)
		case .property_HardwareRevision: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_HardwareRevision)
		case .property_FirmwareVersion: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_FirmwareVersion)
		case .property_ReleaseData: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReleaseData)
		case .property_ReportInterval: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReportInterval)
		case .property_ChangeSensitivityAbsolute: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ChangeSensitivityAbsolute)
		case .property_ChangeSensitivityPercentRange: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ChangeSensitivityPercentRange)
		case .property_ChangeSensitivityPercentRelative: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ChangeSensitivityPercentRelative)
		case .property_Accuracy: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_Accuracy)
		case .property_Resolution: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_Resolution)
		case .property_Maximum: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_Maximum)
		case .property_Minimum: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_Minimum)
		case .property_ReportingState: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReportingState)
		case .property_SamplingRate: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_SamplingRate)
		case .property_ResponseCurve: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ResponseCurve)
		case .property_PowerState: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_PowerState)
		/* 0x031A - 0x03FF Reserved */

		case .property_ConnectionType_Integrated: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ConnectionType_Integrated)
		case .property_ConnectionType_Attached: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ConnectionType_Attached)
		case .property_ConnectionType_External: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ConnectionType_External)
		/* 0x0833 - 0x083F Reserved */
		case .property_ReportingState_NoEvents: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReportingState_NoEvents)
		case .property_ReportingState_AllEvents: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReportingState_AllEvents)
		case .property_ReportingState_ThresholdEvents: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReportingState_ThresholdEvents)
		case .property_ReportingState_WakeNoEvents: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReportingState_WakeNoEvents)
		case .property_ReportingState_WakeAllEvents: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReportingState_WakeAllEvents)
		case .property_ReportingState_WakeThresholdEvents: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_ReportingState_WakeThresholdEvents)
		/* 0x0846 - 0x084F Reserved */
		case .property_PowerState_Undefined: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_PowerState_Undefined)
		case .property_PowerState_D0_FullPower: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_PowerState_D0_FullPower)
		case .property_PowerState_D1_LowPower: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_PowerState_D1_LowPower)
		case .property_PowerState_D2_Standby: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_PowerState_D2_Standby)
		case .property_PowerState_D3_Sleep: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_PowerState_D3_Sleep)
		case .property_PowerState_D4_PowerOff: return (kHIDPage_Sensor, kHIDUsage_Snsr_Property_PowerState_D4_PowerOff)
		/* 0x0855 - 0x085F Reserved */
		case .light_Illuminance: return (kHIDPage_Sensor, kHIDUsage_Snsr_Light_Illuminance)

		/* Specific Sensor Type Data Fields */

		/* Biometric Sensor Data Fields */
		case .data_Biometric: return (kHIDPage_Sensor, kHIDUsage_Snsr_Data_Biometric)
		case .data_Biometric_HumanPresence: return (kHIDPage_Sensor, kHIDUsage_Snsr_Data_Biometric_HumanPresence)
		case .data_Biometric_HumanProximityRange: return (kHIDPage_Sensor, kHIDUsage_Snsr_Data_Biometric_HumanProximityRange)
		case .data_Biometric_HumanProximityOutOfRange: return (kHIDPage_Sensor, kHIDUsage_Snsr_Data_Biometric_HumanProximityOutOfRange)
		case .data_Biometric_HumanTouchState: return (kHIDPage_Sensor, kHIDUsage_Snsr_Data_Biometric_HumanTouchState)
		/* 0x04B5 - 0x04CF Reserved */
		case .reserved(let val): return (kHIDPage_Sensor, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_Snsr_Undefined: self = .undefined
		case kHIDUsage_Snsr_Sensor: self = .sensor
			/* 0x02 - 0x0F Reserved */
		case kHIDUsage_Snsr_Biometric: self = .biometric
		case kHIDUsage_Snsr_Biometric_HumanPresence: self = .biometric_HumanPresence
		case kHIDUsage_Snsr_Biometric_HumanProximity: self = .biometric_HumanProximity
		case kHIDUsage_Snsr_Biometric_HumanTouch: self = .biometric_HumanTouch
			/* 0x14 - 0x1F Reserved */
		case kHIDUsage_Snsr_Electrical: self = .electrical
		case kHIDUsage_Snsr_Electrical_Capacitance: self = .electrical_Capacitance
		case kHIDUsage_Snsr_Electrical_Current: self = .electrical_Current
		case kHIDUsage_Snsr_Electrical_Power: self = .electrical_Power
		case kHIDUsage_Snsr_Electrical_Inductance: self = .electrical_Inductance
		case kHIDUsage_Snsr_Electrical_Resistance: self = .electrical_Resistance
		case kHIDUsage_Snsr_Electrical_Voltage: self = .electrical_Voltage
		case kHIDUsage_Snsr_Electrical_Potentiometer: self = .electrical_Potentiometer
		case kHIDUsage_Snsr_Electrical_Frequency: self = .electrical_Frequency
		case kHIDUsage_Snsr_Electrical_Period: self = .electrical_Period
			/* 0x2A - 0x2F Reserved */
		case kHIDUsage_Snsr_Environmental: self = .environmental
		case kHIDUsage_Snsr_Environmental_AtmosphericPressure: self = .environmental_AtmosphericPressure
		case kHIDUsage_Snsr_Environmental_Humidity: self = .environmental_Humidity
		case kHIDUsage_Snsr_Environmental_Temperature: self = .environmental_Temperature
		case kHIDUsage_Snsr_Environmental_WindDirection: self = .environmental_WindDirection
		case kHIDUsage_Snsr_Environmental_WindSpeed: self = .environmental_WindSpeed
			/* 0x36 - 0x3F Reserved */
		case kHIDUsage_Snsr_Light: self = .light
		case kHIDUsage_Snsr_Light_AmbientLight: self = .light_AmbientLight
		case kHIDUsage_Snsr_Light_ConsumerInfrared: self = .light_ConsumerInfrared
			/* 0x43 - 0x4F Reserved */
		case kHIDUsage_Snsr_Location: self = .location
		case kHIDUsage_Snsr_Location_Broadcast: self = .location_Broadcast
		case kHIDUsage_Snsr_Location_DeadReckoning: self = .location_DeadReckoning
		case kHIDUsage_Snsr_Location_GPS: self = .location_GPS
		case kHIDUsage_Snsr_Location_Lookup: self = .location_Lookup
		case kHIDUsage_Snsr_Location_Other: self = .location_Other
		case kHIDUsage_Snsr_Location_Static: self = .location_Static
		case kHIDUsage_Snsr_Location_Triangulation: self = .location_Triangulation
			/* 0x58 - 0x5F Reserved */
		case kHIDUsage_Snsr_Mechanical: self = .mechanical
		case kHIDUsage_Snsr_Mechanical_BooleanSwitch: self = .mechanical_BooleanSwitch
		case kHIDUsage_Snsr_Mechanical_BooleanSwitchArray: self = .mechanical_BooleanSwitchArray
		case kHIDUsage_Snsr_Mechanical_MultivalueSwitch: self = .mechanical_MultivalueSwitch
		case kHIDUsage_Snsr_Mechanical_Force: self = .mechanical_Force
		case kHIDUsage_Snsr_Mechanical_Pressure: self = .mechanical_Pressure
		case kHIDUsage_Snsr_Mechanical_Strain: self = .mechanical_Strain
		case kHIDUsage_Snsr_Mechanical_Weight: self = .mechanical_Weight
		case kHIDUsage_Snsr_Mechanical_HapticVibrator: self = .mechanical_HapticVibrator
		case kHIDUsage_Snsr_Mechanical_HallEffectSwitch: self = .mechanical_HallEffectSwitch
			/* 0x6A - 0x6F Reserved */
		case kHIDUsage_Snsr_Motion: self = .motion
		case kHIDUsage_Snsr_Motion_Accelerometer1D: self = .motion_Accelerometer1D
		case kHIDUsage_Snsr_Motion_Accelerometer2D: self = .motion_Accelerometer2D
		case kHIDUsage_Snsr_Motion_Accelerometer3D: self = .motion_Accelerometer3D
		case kHIDUsage_Snsr_Motion_Gyrometer1D: self = .motion_Gyrometer1D
		case kHIDUsage_Snsr_Motion_Gyrometer2D: self = .motion_Gyrometer2D
		case kHIDUsage_Snsr_Motion_Gyrometer3D: self = .motion_Gyrometer3D
		case kHIDUsage_Snsr_Motion_MotionDetector: self = .motion_MotionDetector
		case kHIDUsage_Snsr_Motion_Speedometer: self = .motion_Speedometer
		case kHIDUsage_Snsr_Motion_Accelerometer: self = .motion_Accelerometer
		case kHIDUsage_Snsr_Motion_Gyrometer: self = .motion_Gyrometer
			/* 0x7B - 0x7F Reserved */
		case kHIDUsage_Snsr_Orientation: self = .orientation
		case kHIDUsage_Snsr_Orientation_Compass1D: self = .orientation_Compass1D
		case kHIDUsage_Snsr_Orientation_Compass2D: self = .orientation_Compass2D
		case kHIDUsage_Snsr_Orientation_Compass3D: self = .orientation_Compass3D
		case kHIDUsage_Snsr_Orientation_Inclinometer1D: self = .orientation_Inclinometer1D
		case kHIDUsage_Snsr_Orientation_Inclinometer2D: self = .orientation_Inclinometer2D
		case kHIDUsage_Snsr_Orientation_Inclinometer3D: self = .orientation_Inclinometer3D
		case kHIDUsage_Snsr_Orientation_Distance1D: self = .orientation_Distance1D
		case kHIDUsage_Snsr_Orientation_Distance2D: self = .orientation_Distance2D
		case kHIDUsage_Snsr_Orientation_Distance3D: self = .orientation_Distance3D
		case kHIDUsage_Snsr_Orientation_DeviceOrientation: self = .orientation_DeviceOrientation
		case kHIDUsage_Snsr_Orientation_CompassD: self = .orientation_CompassD
		case kHIDUsage_Snsr_Orientation_InclinometerD: self = .orientation_InclinometerD
		case kHIDUsage_Snsr_Orientation_DistanceD: self = .orientation_DistanceD
			/* 0x8E - 0x8F Reserved */
		case kHIDUsage_Snsr_Scanner: self = .scanner
		case kHIDUsage_Snsr_Scanner_Barcode: self = .scanner_Barcode
		case kHIDUsage_Snsr_Scanner_RFID: self = .scanner_RFID
		case kHIDUsage_Snsr_Scanner_NFC: self = .scanner_NFC
			/* 0x94 - 0x9F Reserved */
		case kHIDUsage_Snsr_Time: self = .time
		case kHIDUsage_Snsr_Time_AlarmTimer: self = .time_AlarmTimer
		case kHIDUsage_Snsr_Time_RealTimeClock: self = .time_RealTimeClock
			/* 0xA3 - 0xDF Reserved */
		case kHIDUsage_Snsr_Other: self = .other
		case kHIDUsage_Snsr_Other_Custom: self = .other_Custom
		case kHIDUsage_Snsr_Other_Generic: self = .other_Generic
		case kHIDUsage_Snsr_Other_GenericEnumerator: self = .other_GenericEnumerator
			/* 0xE4 - 0xEF Reserved */
			/* 0xF0 - 0xFF Vendor Reserved */
			
			/* Common Sensor Type Data Fields */
			
			/* Usage Switches used in conjunction with other Data Usages. The value of the modifier is OR-ed in to the upper nibble of the 16bit Data Usage. */
		case kHIDUsage_Snsr_Modifier_None: self = .modifier_None
		case kHIDUsage_Snsr_Modifier_ChangeSensitivityAbsolute: self = .modifier_ChangeSensitivityAbsolute
		case kHIDUsage_Snsr_Modifier_Max: self = .modifier_Max
		case kHIDUsage_Snsr_Modifier_Min: self = .modifier_Min
		case kHIDUsage_Snsr_Modifier_Accuracy: self = .modifier_Accuracy
		case kHIDUsage_Snsr_Modifier_Resolution: self = .modifier_Resolution
		case kHIDUsage_Snsr_Modifier_ThresholdHigh: self = .modifier_ThresholdHigh
		case kHIDUsage_Snsr_Modifier_ThresholdLow: self = .modifier_ThresholdLow
		case kHIDUsage_Snsr_Modifier_CalibrationOffset: self = .modifier_CalibrationOffset
		case kHIDUsage_Snsr_Modifier_CalibrationMultiplier: self = .modifier_CalibrationMultiplier
		case kHIDUsage_Snsr_Modifier_ReportInterval: self = .modifier_ReportInterval
		case kHIDUsage_Snsr_Modifier_FrequencyMax: self = .modifier_FrequencyMax
		case kHIDUsage_Snsr_Modifier_PeriodMax: self = .modifier_PeriodMax
		case kHIDUsage_Snsr_Modifier_ChangeSensitivityPercentRange: self = .modifier_ChangeSensitivityPercentRange
		case kHIDUsage_Snsr_Modifier_ChangeSensitivityPercentRelative: self = .modifier_ChangeSensitivityPercentRelative
		case kHIDUsage_Snsr_Modifier_VendorDefined: self = .modifier_VendorDefined
			
			/* Event Usages */
		case kHIDUsage_Snsr_Event: self = .event
		case kHIDUsage_Snsr_Event_SensorState: self = .event_SensorState
		case kHIDUsage_Snsr_Event_SensorEvent: self = .event_SensorEvent
			/* 0x0203 - 0x02FF Event Reserved */
			
		case kHIDUsage_Snsr_Event_SensorState_Undefined: self = .event_SensorState_Undefined
		case kHIDUsage_Snsr_Event_SensorState_Ready: self = .event_SensorState_Ready
		case kHIDUsage_Snsr_Event_SensorState_NotAvailable: self = .event_SensorState_NotAvailable
		case kHIDUsage_Snsr_Event_SensorState_NoData: self = .event_SensorState_NoData
		case kHIDUsage_Snsr_Event_SensorState_Initializing: self = .event_SensorState_Initializing
		case kHIDUsage_Snsr_Event_SensorState_AccessDenied: self = .event_SensorState_AccessDenied
		case kHIDUsage_Snsr_Event_SensorState_Error: self = .event_SensorState_Error
			/* 0x0807 - 0x080F Reserved */
			
		case kHIDUsage_Snsr_Event_SensorEvent_Unknown: self = .event_SensorEvent_Unknown
		case kHIDUsage_Snsr_Event_SensorEvent_StateChanged: self = .event_SensorEvent_StateChanged
		case kHIDUsage_Snsr_Event_SensorEvent_PropertyChanged: self = .event_SensorEvent_PropertyChanged
		case kHIDUsage_Snsr_Event_SensorEvent_DataUpdated: self = .event_SensorEvent_DataUpdated
		case kHIDUsage_Snsr_Event_SensorEvent_PollResponse: self = .event_SensorEvent_PollResponse
		case kHIDUsage_Snsr_Event_SensorEvent_ChangeSensitivity: self = .event_SensorEvent_ChangeSensitivity
		case kHIDUsage_Snsr_Event_SensorEvent_RangeMaxReached: self = .event_SensorEvent_RangeMaxReached
		case kHIDUsage_Snsr_Event_SensorEvent_RangeMinReached: self = .event_SensorEvent_RangeMinReached
		case kHIDUsage_Snsr_Event_SensorEvent_HighThresholdCrossUp: self = .event_SensorEvent_HighThresholdCrossUp
		case kHIDUsage_Snsr_Event_SensorEvent_HighThresholdCrossDown: self = .event_SensorEvent_HighThresholdCrossDown
		case kHIDUsage_Snsr_Event_SensorEvent_LowThresholdCrossUp: self = .event_SensorEvent_LowThresholdCrossUp
		case kHIDUsage_Snsr_Event_SensorEvent_LowThresholdCrossDown: self = .event_SensorEvent_LowThresholdCrossDown
		case kHIDUsage_Snsr_Event_SensorEvent_ZeroThresholdCrossUp: self = .event_SensorEvent_ZeroThresholdCrossUp
		case kHIDUsage_Snsr_Event_SensorEvent_ZeroThresholdCrossDown: self = .event_SensorEvent_ZeroThresholdCrossDown
		case kHIDUsage_Snsr_Event_SensorEvent_PeriodExceeded: self = .event_SensorEvent_PeriodExceeded
		case kHIDUsage_Snsr_Event_SensorEvent_FrequencyExceeded: self = .event_SensorEvent_FrequencyExceeded
		case kHIDUsage_Snsr_Event_SensorEvent_ComplexTrigger: self = .event_SensorEvent_ComplexTrigger
			/* 0x0821 - 0x082F Reserved */
			
			/* Property Usages */
		case kHIDUsage_Snsr_Property: self = .property
		case kHIDUsage_Snsr_Property_FriendlyName: self = .property_FriendlyName
		case kHIDUsage_Snsr_Property_PersistentUniqueID: self = .property_PersistentUniqueID
		case kHIDUsage_Snsr_Property_SensorStatus: self = .property_SensorStatus
		case kHIDUsage_Snsr_Property_MinimumReportInterval: self = .property_MinimumReportInterval
		case kHIDUsage_Snsr_Property_Manufacturer: self = .property_Manufacturer
		case kHIDUsage_Snsr_Property_Model: self = .property_Model
		case kHIDUsage_Snsr_Property_SerialNumber: self = .property_SerialNumber
		case kHIDUsage_Snsr_Property_Description: self = .property_Description
		case kHIDUsage_Snsr_Property_ConnectionType: self = .property_ConnectionType
		case kHIDUsage_Snsr_Property_DevicePath: self = .property_DevicePath
		case kHIDUsage_Snsr_Property_HardwareRevision: self = .property_HardwareRevision
		case kHIDUsage_Snsr_Property_FirmwareVersion: self = .property_FirmwareVersion
		case kHIDUsage_Snsr_Property_ReleaseData: self = .property_ReleaseData
		case kHIDUsage_Snsr_Property_ReportInterval: self = .property_ReportInterval
		case kHIDUsage_Snsr_Property_ChangeSensitivityAbsolute: self = .property_ChangeSensitivityAbsolute
		case kHIDUsage_Snsr_Property_ChangeSensitivityPercentRange: self = .property_ChangeSensitivityPercentRange
		case kHIDUsage_Snsr_Property_ChangeSensitivityPercentRelative: self = .property_ChangeSensitivityPercentRelative
		case kHIDUsage_Snsr_Property_Accuracy: self = .property_Accuracy
		case kHIDUsage_Snsr_Property_Resolution: self = .property_Resolution
		case kHIDUsage_Snsr_Property_Maximum: self = .property_Maximum
		case kHIDUsage_Snsr_Property_Minimum: self = .property_Minimum
		case kHIDUsage_Snsr_Property_ReportingState: self = .property_ReportingState
		case kHIDUsage_Snsr_Property_SamplingRate: self = .property_SamplingRate
		case kHIDUsage_Snsr_Property_ResponseCurve: self = .property_ResponseCurve
		case kHIDUsage_Snsr_Property_PowerState: self = .property_PowerState
			/* 0x031A - 0x03FF Reserved */
			
		case kHIDUsage_Snsr_Property_ConnectionType_Integrated: self = .property_ConnectionType_Integrated
		case kHIDUsage_Snsr_Property_ConnectionType_Attached: self = .property_ConnectionType_Attached
		case kHIDUsage_Snsr_Property_ConnectionType_External: self = .property_ConnectionType_External
			/* 0x0833 - 0x083F Reserved */
		case kHIDUsage_Snsr_Property_ReportingState_NoEvents: self = .property_ReportingState_NoEvents
		case kHIDUsage_Snsr_Property_ReportingState_AllEvents: self = .property_ReportingState_AllEvents
		case kHIDUsage_Snsr_Property_ReportingState_ThresholdEvents: self = .property_ReportingState_ThresholdEvents
		case kHIDUsage_Snsr_Property_ReportingState_WakeNoEvents: self = .property_ReportingState_WakeNoEvents
		case kHIDUsage_Snsr_Property_ReportingState_WakeAllEvents: self = .property_ReportingState_WakeAllEvents
		case kHIDUsage_Snsr_Property_ReportingState_WakeThresholdEvents: self = .property_ReportingState_WakeThresholdEvents
			/* 0x0846 - 0x084F Reserved */
		case kHIDUsage_Snsr_Property_PowerState_Undefined: self = .property_PowerState_Undefined
		case kHIDUsage_Snsr_Property_PowerState_D0_FullPower: self = .property_PowerState_D0_FullPower
		case kHIDUsage_Snsr_Property_PowerState_D1_LowPower: self = .property_PowerState_D1_LowPower
		case kHIDUsage_Snsr_Property_PowerState_D2_Standby: self = .property_PowerState_D2_Standby
		case kHIDUsage_Snsr_Property_PowerState_D3_Sleep: self = .property_PowerState_D3_Sleep
		case kHIDUsage_Snsr_Property_PowerState_D4_PowerOff: self = .property_PowerState_D4_PowerOff
			/* 0x0855 - 0x085F Reserved */
		case kHIDUsage_Snsr_Light_Illuminance: self = .light_Illuminance
			
			/* Specific Sensor Type Data Fields */
			
			/* Biometric Sensor Data Fields */
		case kHIDUsage_Snsr_Data_Biometric: self = .data_Biometric
		case kHIDUsage_Snsr_Data_Biometric_HumanPresence: self = .data_Biometric_HumanPresence
		case kHIDUsage_Snsr_Data_Biometric_HumanProximityRange: self = .data_Biometric_HumanProximityRange
		case kHIDUsage_Snsr_Data_Biometric_HumanProximityOutOfRange: self = .data_Biometric_HumanProximityOutOfRange
		case kHIDUsage_Snsr_Data_Biometric_HumanTouchState: self = .data_Biometric_HumanTouchState
			/* 0x04B5 - 0x04CF Reserved */
		default: self = .reserved(usage)
		}
	}
}

/**
 Power Device Page (0x84)

 This section provides detailed descriptions of the usages employed by Power Devices.
 */
public enum PowerDeviceUsage: IUsagePageUsage
{
	case undefined                /* Power Device Undefined Usage */
	case iName                    /* CL- Power Device Name Index */
	case presentStatus            /* CL- Power Device Present Status */
	case changedStatus            /* CA- Power Device Changed Status */
	case uPS                    /* CA- Uninterruptible Power Supply */
	case powerSupply            /* CA- Power Supply */
	case peripheralDevice       /* CA- Perpheral Device */
	/* Reserved 0x07 - 0x0F */
	case batterySystem            /* CP- Battery System power module */
	case batterySystemID        /* SV IF- Battery System ID */
	case battery                /* CP- Battery */
	case batteryID                /* SV IF- Battery ID */
	case charger                /* CP- Charger */
	case chargerID                /* SV IF- Charger ID */
	case powerConverter            /* CP- Power Converter power module */
	case powerConverterID        /* SV IF- Power Converter ID */
	case outletSystem            /* CP- Outlet System power module */
	case outletSystemID            /* SV IF-Outlet System ID */
	case input                    /* CP- Power Device Input */
	case inputID                /* SV IF- Power Device Input ID */
	case output                    /* CP- Power Device Output */
	case outputID                /* SV IF- Power Device Output ID */
	case flow                    /* CP- Power Device Flow */
	case flowID                    /* Item IF- Power Device Flow ID */
	case outlet                    /* CP- Power Device Outlet */
	case outletID                /* SV IF- Power Device Outlet ID */
	case gang                    /* CL/CP- Power Device Gang */
	case gangID                    /* SV IF- Power Device Gang ID */
	case powerSummary            /* CL/CP- Power Device Power Summary */
	case powerSummaryID            /* SV IF- Power Device Power Summary ID */
	/* Reserved 0x26 - 0x2F */
	case voltage                /* DV IF- Power Device Voltage */
	case current                /* DV IF- Power Device Current */
	case frequency                /* DV IF- Power Device Frequency */
	case apparentPower            /* DV IF- Power Device Apparent Power */
	case activePower            /* DV IF- Power Device RMS Power */
	case percentLoad            /* DV IF- Power Device Percent Load */
	case temperature            /* DV IF- Power Device Temperature */
	case humidity                /* DV IF- Power Device Humidity */
	case badCount                /* DV IF- Power Device Bad Condition Count */
	/* Reserved 0x39 - 0x3F */
	case configVoltage            /* SV/DV F- Power Device Nominal Voltage */
	case configCurrent            /* SV/DV F- Power Device Nominal Current */
	case configFrequency        /* SV/DV F- Power Device Nominal Frequency */
	case configApparentPower    /* SV/DV F- Power Device Nominal Apparent Power */
	case configActivePower        /* SV/DV F- Power Device Nominal RMS Power */
	case configPercentLoad        /* SV/DV F- Power Device Nominal Percent Load */
	case configTemperature        /* SV/DV F- Power Device Nominal Temperature */
	case configHumidity            /* SV/DV F- Power Device Nominal Humidity */
	/* Reserved 0x48 - 0x4F */
	case switchOnControl        /* DV F- Power Device Switch On Control */
	case switchOffControl        /* DV F- Power Device Switch Off Control */
	case toggleControl            /* DV F- Power Device Toogle Sequence Control */
	case lowVoltageTransfer        /* DV F- Power Device Min Transfer Voltage */
	case highVoltageTransfer    /* DV F- Power Device Max Transfer Voltage */
	case delayBeforeReboot        /* DV F- Power Device Delay Before Reboot */
	case delayBeforeStartup        /* DV F- Power Device Delay Before Startup */
	case delayBeforeShutdown    /* DV F- Power Device Delay Before Shutdown */
	case test                    /* DV F- Power Device Test Request/Result */
	case moduleReset            /* DV F- Power Device Reset Request/Result */
	case audibleAlarmControl    /* DV F- Power Device Audible Alarm Control */
	/* Reserved 0x5B - 0x5F */
	case present                /* DV IOF- Power Device Present */
	case good                    /* DV IOF- Power Device Good */
	case internalFailure        /* DV IOF- Power Device Internal Failure */
	case voltageOutOfRange        /* DV IOF- Power Device Voltage Out Of Range */
	case frequencyOutOfRange    /* DV IOF- Power Device Frequency Out Of Range */
	case overload                /* DV IOF- Power Device Overload */
	case overCharged            /* DV IOF- Power Device Over Charged */
	case overTemperature        /* DV IOF- Power Device Over Temperature */
	case shutdownRequested        /* DV IOF- Power Device Shutdown Requested */
	case shutdownImminent        /* DV IOF- Power Device Shutdown Imminent */
	/* Reserved 0x6A */
	case switchOnOff            /* DV IOF- Power Device On/Off Switch Status */
	case switchable                /* DV IOF- Power Device Switchable */
	case used                    /* DV IOF- Power Device Used */
	case boost                    /* DV IOF- Power Device Boosted */
	case buck                    /* DV IOF- Power Device Bucked */
	case initialized            /* DV IOF- Power Device Initialized */
	case tested                    /* DV IOF- Power Device Tested */
	case awaitingPower            /* DV IOF- Power Device Awaiting Power */
	case communicationLost        /* DV IOF- Power Device Communication Lost */
	/* Reserved 0x74 - 0xFC */
	case iManufacturer            /* SV F- Power Device Manufacturer String Index */
	case iProduct                /* SV F- Power Device Product String Index */
	case iserialNumber /* SV F- Power Device Serial Number String Index */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_PowerDevice, kHIDUsage_PD_Undefined)                /* Power Device Undefined Usage */
		case .iName: return (kHIDPage_PowerDevice, kHIDUsage_PD_iName)                    /* CL- Power Device Name Index */
		case .presentStatus: return (kHIDPage_PowerDevice, kHIDUsage_PD_PresentStatus)            /* CL- Power Device Present Status */
		case .changedStatus: return (kHIDPage_PowerDevice, kHIDUsage_PD_ChangedStatus)            /* CA- Power Device Changed Status */
		case .uPS: return (kHIDPage_PowerDevice, kHIDUsage_PD_UPS)                    /* CA- Uninterruptible Power Supply */
		case .powerSupply: return (kHIDPage_PowerDevice, kHIDUsage_PD_PowerSupply)            /* CA- Power Supply */
		case .peripheralDevice: return (kHIDPage_PowerDevice, kHIDUsage_PD_PeripheralDevice)       /* CA- Perpheral Device */
			/* Reserved 0x07 - 0x0F */
		case .batterySystem: return (kHIDPage_PowerDevice, kHIDUsage_PD_BatterySystem)            /* CP- Battery System power module */
		case .batterySystemID: return (kHIDPage_PowerDevice, kHIDUsage_PD_BatterySystemID)        /* SV IF- Battery System ID */
		case .battery: return (kHIDPage_PowerDevice, kHIDUsage_PD_Battery)                /* CP- Battery */
		case .batteryID: return (kHIDPage_PowerDevice, kHIDUsage_PD_BatteryID)                /* SV IF- Battery ID */
		case .charger: return (kHIDPage_PowerDevice, kHIDUsage_PD_Charger)                /* CP- Charger */
		case .chargerID: return (kHIDPage_PowerDevice, kHIDUsage_PD_ChargerID)                /* SV IF- Charger ID */
		case .powerConverter: return (kHIDPage_PowerDevice, kHIDUsage_PD_PowerConverter)            /* CP- Power Converter power module */
		case .powerConverterID: return (kHIDPage_PowerDevice, kHIDUsage_PD_PowerConverterID)        /* SV IF- Power Converter ID */
		case .outletSystem: return (kHIDPage_PowerDevice, kHIDUsage_PD_OutletSystem)            /* CP- Outlet System power module */
		case .outletSystemID: return (kHIDPage_PowerDevice, kHIDUsage_PD_OutletSystemID)            /* SV IF-Outlet System ID */
		case .input: return (kHIDPage_PowerDevice, kHIDUsage_PD_Input)                    /* CP- Power Device Input */
		case .inputID: return (kHIDPage_PowerDevice, kHIDUsage_PD_InputID)                /* SV IF- Power Device Input ID */
		case .output: return (kHIDPage_PowerDevice, kHIDUsage_PD_Output)                    /* CP- Power Device Output */
		case .outputID: return (kHIDPage_PowerDevice, kHIDUsage_PD_OutputID)                /* SV IF- Power Device Output ID */
		case .flow: return (kHIDPage_PowerDevice, kHIDUsage_PD_Flow)                    /* CP- Power Device Flow */
		case .flowID: return (kHIDPage_PowerDevice, kHIDUsage_PD_FlowID)                    /* Item IF- Power Device Flow ID */
		case .outlet: return (kHIDPage_PowerDevice, kHIDUsage_PD_Outlet)                    /* CP- Power Device Outlet */
		case .outletID: return (kHIDPage_PowerDevice, kHIDUsage_PD_OutletID)                /* SV IF- Power Device Outlet ID */
		case .gang: return (kHIDPage_PowerDevice, kHIDUsage_PD_Gang)                    /* CL/CP- Power Device Gang */
		case .gangID: return (kHIDPage_PowerDevice, kHIDUsage_PD_GangID)                    /* SV IF- Power Device Gang ID */
		case .powerSummary: return (kHIDPage_PowerDevice, kHIDUsage_PD_PowerSummary)            /* CL/CP- Power Device Power Summary */
		case .powerSummaryID: return (kHIDPage_PowerDevice, kHIDUsage_PD_PowerSummaryID)            /* SV IF- Power Device Power Summary ID */
			/* Reserved 0x26 - 0x2F */
		case .voltage: return (kHIDPage_PowerDevice, kHIDUsage_PD_Voltage)                /* DV IF- Power Device Voltage */
		case .current: return (kHIDPage_PowerDevice, kHIDUsage_PD_Current)                /* DV IF- Power Device Current */
		case .frequency: return (kHIDPage_PowerDevice, kHIDUsage_PD_Frequency)                /* DV IF- Power Device Frequency */
		case .apparentPower: return (kHIDPage_PowerDevice, kHIDUsage_PD_ApparentPower)            /* DV IF- Power Device Apparent Power */
		case .activePower: return (kHIDPage_PowerDevice, kHIDUsage_PD_ActivePower)            /* DV IF- Power Device RMS Power */
		case .percentLoad: return (kHIDPage_PowerDevice, kHIDUsage_PD_PercentLoad)            /* DV IF- Power Device Percent Load */
		case .temperature: return (kHIDPage_PowerDevice, kHIDUsage_PD_Temperature)            /* DV IF- Power Device Temperature */
		case .humidity: return (kHIDPage_PowerDevice, kHIDUsage_PD_Humidity)                /* DV IF- Power Device Humidity */
		case .badCount: return (kHIDPage_PowerDevice, kHIDUsage_PD_BadCount)                /* DV IF- Power Device Bad Condition Count */
			/* Reserved 0x39 - 0x3F */
		case .configVoltage: return (kHIDPage_PowerDevice, kHIDUsage_PD_ConfigVoltage)            /* SV/DV F- Power Device Nominal Voltage */
		case .configCurrent: return (kHIDPage_PowerDevice, kHIDUsage_PD_ConfigCurrent)            /* SV/DV F- Power Device Nominal Current */
		case .configFrequency: return (kHIDPage_PowerDevice, kHIDUsage_PD_ConfigFrequency)        /* SV/DV F- Power Device Nominal Frequency */
		case .configApparentPower: return (kHIDPage_PowerDevice, kHIDUsage_PD_ConfigApparentPower)    /* SV/DV F- Power Device Nominal Apparent Power */
		case .configActivePower: return (kHIDPage_PowerDevice, kHIDUsage_PD_ConfigActivePower)        /* SV/DV F- Power Device Nominal RMS Power */
		case .configPercentLoad: return (kHIDPage_PowerDevice, kHIDUsage_PD_ConfigPercentLoad)        /* SV/DV F- Power Device Nominal Percent Load */
		case .configTemperature: return (kHIDPage_PowerDevice, kHIDUsage_PD_ConfigTemperature)        /* SV/DV F- Power Device Nominal Temperature */
		case .configHumidity: return (kHIDPage_PowerDevice, kHIDUsage_PD_ConfigHumidity)            /* SV/DV F- Power Device Nominal Humidity */
			/* Reserved 0x48 - 0x4F */
		case .switchOnControl: return (kHIDPage_PowerDevice, kHIDUsage_PD_SwitchOnControl)        /* DV F- Power Device Switch On Control */
		case .switchOffControl: return (kHIDPage_PowerDevice, kHIDUsage_PD_SwitchOffControl)        /* DV F- Power Device Switch Off Control */
		case .toggleControl: return (kHIDPage_PowerDevice, kHIDUsage_PD_ToggleControl)            /* DV F- Power Device Toogle Sequence Control */
		case .lowVoltageTransfer: return (kHIDPage_PowerDevice, kHIDUsage_PD_LowVoltageTransfer)        /* DV F- Power Device Min Transfer Voltage */
		case .highVoltageTransfer: return (kHIDPage_PowerDevice, kHIDUsage_PD_HighVoltageTransfer)    /* DV F- Power Device Max Transfer Voltage */
		case .delayBeforeReboot: return (kHIDPage_PowerDevice, kHIDUsage_PD_DelayBeforeReboot)        /* DV F- Power Device Delay Before Reboot */
		case .delayBeforeStartup: return (kHIDPage_PowerDevice, kHIDUsage_PD_DelayBeforeStartup)        /* DV F- Power Device Delay Before Startup */
		case .delayBeforeShutdown: return (kHIDPage_PowerDevice, kHIDUsage_PD_DelayBeforeShutdown)    /* DV F- Power Device Delay Before Shutdown */
		case .test: return (kHIDPage_PowerDevice, kHIDUsage_PD_Test)                    /* DV F- Power Device Test Request/Result */
		case .moduleReset: return (kHIDPage_PowerDevice, kHIDUsage_PD_ModuleReset)            /* DV F- Power Device Reset Request/Result */
		case .audibleAlarmControl: return (kHIDPage_PowerDevice, kHIDUsage_PD_AudibleAlarmControl)    /* DV F- Power Device Audible Alarm Control */
			/* Reserved 0x5B - 0x5F */
		case .present: return (kHIDPage_PowerDevice, kHIDUsage_PD_Present)                /* DV IOF- Power Device Present */
		case .good: return (kHIDPage_PowerDevice, kHIDUsage_PD_Good)                    /* DV IOF- Power Device Good */
		case .internalFailure: return (kHIDPage_PowerDevice, kHIDUsage_PD_InternalFailure)        /* DV IOF- Power Device Internal Failure */
		case .voltageOutOfRange: return (kHIDPage_PowerDevice, kHIDUsage_PD_VoltageOutOfRange)        /* DV IOF- Power Device Voltage Out Of Range */
		case .frequencyOutOfRange: return (kHIDPage_PowerDevice, kHIDUsage_PD_FrequencyOutOfRange)    /* DV IOF- Power Device Frequency Out Of Range */
		case .overload: return (kHIDPage_PowerDevice, kHIDUsage_PD_Overload)                /* DV IOF- Power Device Overload */
		case .overCharged: return (kHIDPage_PowerDevice, kHIDUsage_PD_OverCharged)            /* DV IOF- Power Device Over Charged */
		case .overTemperature: return (kHIDPage_PowerDevice, kHIDUsage_PD_OverTemperature)        /* DV IOF- Power Device Over Temperature */
		case .shutdownRequested: return (kHIDPage_PowerDevice, kHIDUsage_PD_ShutdownRequested)        /* DV IOF- Power Device Shutdown Requested */
		case .shutdownImminent: return (kHIDPage_PowerDevice, kHIDUsage_PD_ShutdownImminent)        /* DV IOF- Power Device Shutdown Imminent */
			/* Reserved 0x6A */
		case .switchOnOff: return (kHIDPage_PowerDevice, kHIDUsage_PD_SwitchOnOff)            /* DV IOF- Power Device On/Off Switch Status */
		case .switchable: return (kHIDPage_PowerDevice, kHIDUsage_PD_Switchable)                /* DV IOF- Power Device Switchable */
		case .used: return (kHIDPage_PowerDevice, kHIDUsage_PD_Used)                    /* DV IOF- Power Device Used */
		case .boost: return (kHIDPage_PowerDevice, kHIDUsage_PD_Boost)                    /* DV IOF- Power Device Boosted */
		case .buck: return (kHIDPage_PowerDevice, kHIDUsage_PD_Buck)                    /* DV IOF- Power Device Bucked */
		case .initialized: return (kHIDPage_PowerDevice, kHIDUsage_PD_Initialized)            /* DV IOF- Power Device Initialized */
		case .tested: return (kHIDPage_PowerDevice, kHIDUsage_PD_Tested)                    /* DV IOF- Power Device Tested */
		case .awaitingPower: return (kHIDPage_PowerDevice, kHIDUsage_PD_AwaitingPower)            /* DV IOF- Power Device Awaiting Power */
		case .communicationLost: return (kHIDPage_PowerDevice, kHIDUsage_PD_CommunicationLost)        /* DV IOF- Power Device Communication Lost */
			/* Reserved 0x74 - 0xFC */
		case .iManufacturer: return (kHIDPage_PowerDevice, kHIDUsage_PD_iManufacturer)            /* SV F- Power Device Manufacturer String Index */
		case .iProduct: return (kHIDPage_PowerDevice, kHIDUsage_PD_iProduct)                /* SV F- Power Device Product String Index */
		case .iserialNumber: return (kHIDPage_PowerDevice, kHIDUsage_PD_iserialNumber) /* SV F- Power Device Serial Number String Index */
		case .reserved(let val): return (kHIDPage_PowerDevice, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_PD_Undefined: self = .undefined
		case kHIDUsage_PD_iName: self = .iName
		case kHIDUsage_PD_PresentStatus: self = .presentStatus
		case kHIDUsage_PD_ChangedStatus: self = .changedStatus
		case kHIDUsage_PD_UPS: self = .uPS
		case kHIDUsage_PD_PowerSupply: self = .powerSupply
		case kHIDUsage_PD_PeripheralDevice: self = .peripheralDevice
			/* Reserved 0x07 - 0x0F */
		case kHIDUsage_PD_BatterySystem: self = .batterySystem
		case kHIDUsage_PD_BatterySystemID: self = .batterySystemID
		case kHIDUsage_PD_Battery: self = .battery
		case kHIDUsage_PD_BatteryID: self = .batteryID
		case kHIDUsage_PD_Charger: self = .charger
		case kHIDUsage_PD_ChargerID: self = .chargerID
		case kHIDUsage_PD_PowerConverter: self = .powerConverter
		case kHIDUsage_PD_PowerConverterID: self = .powerConverterID
		case kHIDUsage_PD_OutletSystem: self = .outletSystem
		case kHIDUsage_PD_OutletSystemID: self = .outletSystemID
		case kHIDUsage_PD_Input: self = .input
		case kHIDUsage_PD_InputID: self = .inputID
		case kHIDUsage_PD_Output: self = .output
		case kHIDUsage_PD_OutputID: self = .outputID
		case kHIDUsage_PD_Flow: self = .flow
		case kHIDUsage_PD_FlowID: self = .flowID
		case kHIDUsage_PD_Outlet: self = .outlet
		case kHIDUsage_PD_OutletID: self = .outletID
		case kHIDUsage_PD_Gang: self = .gang
		case kHIDUsage_PD_GangID: self = .gangID
		case kHIDUsage_PD_PowerSummary: self = .powerSummary
		case kHIDUsage_PD_PowerSummaryID: self = .powerSummaryID
			/* Reserved 0x26 - 0x2F */
		case kHIDUsage_PD_Voltage: self = .voltage
		case kHIDUsage_PD_Current: self = .current
		case kHIDUsage_PD_Frequency: self = .frequency
		case kHIDUsage_PD_ApparentPower: self = .apparentPower
		case kHIDUsage_PD_ActivePower: self = .activePower
		case kHIDUsage_PD_PercentLoad: self = .percentLoad
		case kHIDUsage_PD_Temperature: self = .temperature
		case kHIDUsage_PD_Humidity: self = .humidity
		case kHIDUsage_PD_BadCount: self = .badCount
			/* Reserved 0x39 - 0x3F */
		case kHIDUsage_PD_ConfigVoltage: self = .configVoltage
		case kHIDUsage_PD_ConfigCurrent: self = .configCurrent
		case kHIDUsage_PD_ConfigFrequency: self = .configFrequency
		case kHIDUsage_PD_ConfigApparentPower: self = .configApparentPower
		case kHIDUsage_PD_ConfigActivePower: self = .configActivePower
		case kHIDUsage_PD_ConfigPercentLoad: self = .configPercentLoad
		case kHIDUsage_PD_ConfigTemperature: self = .configTemperature
		case kHIDUsage_PD_ConfigHumidity: self = .configHumidity
			/* Reserved 0x48 - 0x4F */
		case kHIDUsage_PD_SwitchOnControl: self = .switchOnControl
		case kHIDUsage_PD_SwitchOffControl: self = .switchOffControl
		case kHIDUsage_PD_ToggleControl: self = .toggleControl
		case kHIDUsage_PD_LowVoltageTransfer: self = .lowVoltageTransfer
		case kHIDUsage_PD_HighVoltageTransfer: self = .highVoltageTransfer
		case kHIDUsage_PD_DelayBeforeReboot: self = .delayBeforeReboot
		case kHIDUsage_PD_DelayBeforeStartup: self = .delayBeforeStartup
		case kHIDUsage_PD_DelayBeforeShutdown: self = .delayBeforeShutdown
		case kHIDUsage_PD_Test: self = .test
		case kHIDUsage_PD_ModuleReset: self = .moduleReset
		case kHIDUsage_PD_AudibleAlarmControl: self = .audibleAlarmControl
			/* Reserved 0x5B - 0x5F */
		case kHIDUsage_PD_Present: self = .present
		case kHIDUsage_PD_Good: self = .good
		case kHIDUsage_PD_InternalFailure: self = .internalFailure
		case kHIDUsage_PD_VoltageOutOfRange: self = .voltageOutOfRange
		case kHIDUsage_PD_FrequencyOutOfRange: self = .frequencyOutOfRange
		case kHIDUsage_PD_Overload: self = .overload
		case kHIDUsage_PD_OverCharged: self = .overCharged
		case kHIDUsage_PD_OverTemperature: self = .overTemperature
		case kHIDUsage_PD_ShutdownRequested: self = .shutdownRequested
		case kHIDUsage_PD_ShutdownImminent: self = .shutdownImminent
			/* Reserved 0x6A */
		case kHIDUsage_PD_SwitchOnOff: self = .switchOnOff
		case kHIDUsage_PD_Switchable: self = .switchable
		case kHIDUsage_PD_Used: self = .used
		case kHIDUsage_PD_Boost: self = .boost
		case kHIDUsage_PD_Buck: self = .buck
		case kHIDUsage_PD_Initialized: self = .initialized
		case kHIDUsage_PD_Tested: self = .tested
		case kHIDUsage_PD_AwaitingPower: self = .awaitingPower
		case kHIDUsage_PD_CommunicationLost: self = .communicationLost
			/* Reserved 0x74 - 0xFC */
		case kHIDUsage_PD_iManufacturer: self = .iManufacturer
		case kHIDUsage_PD_iProduct: self = .iProduct
		case kHIDUsage_PD_iserialNumber: self = .iserialNumber
		default: self = .reserved(usage)
		}
	}
}

/**
 Battery System Page (x85)

 This section provides detailed descriptions of the usages employed by Battery Systems.
 */
public enum BatterySystemUsage: IUsagePageUsage
{
	case undefined                /* Battery System Undefined */
	case smbBatteryMode            /* CL - SMB Mode */
	case smbBatteryStatus        /* CL - SMB Status */
	case smbAlarmWarning        /* CL - SMB Alarm Warning */
	case smbChargerMode            /* CL - SMB Charger Mode */
	case smbChargerStatus        /* CL - SMB Charger Status */
	case smbChargerSpecInfo        /* CL - SMB Charger Extended Status */
	case smbSelectorState        /* CL - SMB Selector State */
	case smbSelectorPresets        /* CL - SMB Selector Presets */
	case smbSelectorInfo        /* CL - SMB Selector Info */
	/* Reserved 0x0A - 0x0F */
	case optionalMfgFunction1    /* DV F - Battery System Optional SMB Mfg Function 1 */
	case optionalMfgFunction2    /* DV F - Battery System Optional SMB Mfg Function 2 */
	case optionalMfgFunction3    /* DV F - Battery System Optional SMB Mfg Function 3 */
	case optionalMfgFunction4    /* DV F - Battery System Optional SMB Mfg Function 4 */
	case optionalMfgFunction5    /* DV F - Battery System Optional SMB Mfg Function 5 */
	case connectionToSMBus        /* DF F - Battery System Connection To System Management Bus */
	case outputConnection        /* DF F - Battery System Output Connection Status */
	case chargerConnection        /* DF F - Battery System Charger Connection */
	case batteryInsertion        /* DF F - Battery System Battery Insertion */
	case usenext                /* DF F - Battery System Use Next */
	case okToUse                /* DF F - Battery System OK To Use */
	case batterySupported        /* DF F - Battery System Battery Supported */
	case selectorRevision        /* DF F - Battery System Selector Revision */
	case chargingIndicator        /* DF F - Battery System Charging Indicator */
	/* Reserved 0x1E - 0x27 */
	case manufacturerAccess        /* DV F - Battery System Manufacturer Access */
	case remainingCapacityLimit    /* DV F - Battery System Remaining Capacity Limit */
	case remainingTimeLimit        /* DV F - Battery System Remaining Time Limit */
	case atRate                    /* DV F - Battery System At Rate... */
	case capacityMode            /* DV F - Battery System Capacity Mode */
	case broadcastToCharger        /* DV F - Battery System Broadcast To Charger */
	case primaryBattery            /* DV F - Battery System Primary Battery */
	case chargeController        /* DV F - Battery System Charge Controller */
	/* Reserved 0x30 - 0x3F */
	case terminateCharge        /* DF IOF - Battery System Terminate Charge */
	case terminateDischarge        /* DF IOF - Battery System Terminate Discharge */
	case belowRemainingCapacityLimit /* DF IOF - Battery System Below Remaining Capacity Limit */
	case remainingTimeLimitExpired /* DF IOF - Battery System Remaining Time Limit Expired */
	case charging                /* DF IOF - Battery System Charging */
	case discharging            /* DV IOF - Battery System Discharging */
	case fullyCharged            /* DF IOF - Battery System Fully Charged */
	case fullyDischarged        /* DV IOF - Battery System Fully Discharged */
	case conditioningFlag        /* DV IOF - Battery System Conditioning Flag */
	case atRateOK                /* DV IOF - Battery System At Rate OK */
	case smbErrorCode            /* DF IOF - Battery System SMB Error Code */
	case needReplacement        /* DF IOF - Battery System Need Replacement */
	/* Reserved 0x4C - 0x5F */
	case atRateTimeToFull        /* DV IF - Battery System At Rate Time To Full */
	case atRateTimeToEmpty        /* DV IF - Battery System At Rate Time To Empty */
	case averageCurrent            /* DV IF - Battery System Average Current */
	case maxerror                /* DV IF - Battery System Max Error */
	case relativeStateOfCharge    /* DV IF - Battery System Relative State Of Charge */
	case absoluteStateOfCharge    /* DV IF - Battery System Absolute State Of Charge */
	case remainingCapacity        /* DV IF - Battery System Remaining Capacity */
	case fullChargeCapacity        /* DV IF - Battery System Full Charge Capacity */
	case runTimeToEmpty            /* DV IF - Battery System Run Time To Empty */
	case averageTimeToEmpty        /* DV IF - Battery System Average Time To Empty */
	case averageTimeToFull        /* DV IF - Battery System Average Time To Full */
	case cycleCount                /* DV IF - Battery System Cycle Count */
	/* Reserved 0x6C - 0x7F */
	case battPackModelLevel        /* SV F - Battery System Batt Pack Model Level */
	case internalChargeController /* SF F - Battery System Internal Charge Controller */
	case primaryBatterySupport    /* SF F - Battery System Primary Battery Support */
	case designCapacity            /* SV F - Battery System Design Capacity */
	case specificationInfo        /* SV F - Battery System Specification Info */
	case manufacturerDate        /* SV F - Battery System Manufacturer Date */
	case serialNumber            /* SV F - Battery System Serial Number */
	case iManufacturerName        /* SV F - Battery System Manufacturer Name Index */
	case iDevicename            /* SV F - Battery System Device Name Index */
	case iDeviceChemistry        /* SV F - Battery System Device Chemistry Index */
	case manufacturerData        /* SV F - Battery System Manufacturer Data */
	case rechargable            /* SV F - Battery System Rechargable */
	case warningCapacityLimit    /* SV F - Battery System Warning Capacity Limit */
	case capacityGranularity1    /* SV F - Battery System Capacity Granularity 1 */
	case capacityGranularity2    /* SV F - Battery System Capacity Granularity 2 */
	case iOEMInformation        /* SV F - Battery System OEM Information Index */
	/* Reserved 0x90 - 0xBF */
	case inhibitCharge            /* DF IOF - Battery System Inhibit Charge */
	case enablePolling            /* DF IOF - Battery System Enable Polling */
	case resetToZero            /* DF IOF - Battery System Reset To Zero */
	/* Reserved 0xC3 - 0xCF */
	case acPresent                /* DF IOF - Battery System AC Present */
	case batteryPresent            /* DF IOF - Battery System Battery Present */
	case powerFail                /* DF IOF - Battery System Power Fail */
	case alarmInhibited            /* DF IOF - Battery System Alarm Inhibited */
	case thermistorUnderRange    /* DF IOF - Battery System Thermistor Under Range */
	case thermistorHot            /* DF IOF - Battery System Thermistor Hot */
	case thermistorCold            /* DF IOF - Battery System Thermistor Cold */
	case thermistorOverRange    /* DF IOF - Battery System Thermistor Over Range */
	case voltageOutOfRange        /* DF IOF - Battery System Voltage Out Of Range */
	case currentOutOfRange        /* DF IOF - Battery System Current Out Of Range */
	case currentNotRegulated    /* DF IOF - Battery System Current Not Regulated */
	case voltageNotRegulated    /* DF IOF - Battery System Voltage Not Regulated */
	case masterMode                /* DF IOF - Battery System Master Mode */
	/* Reserved 0xDD - 0xEF */
	case chargerSelectorSupport    /* SF F- Battery System Charger Support Selector */
	case chargerSpec            /* SF F- Battery System Charger Specification */
	case level2                    /* SF F- Battery System Charger Level 2 */
	case level3                   /* SF F- Battery System Charger Level 3 */
	/* Reserved 0x	F2 - 0xFF */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_BatterySystem, kHIDUsage_BS_Undefined)                /* Battery System Undefined */
		case .smbBatteryMode: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBBatteryMode)            /* CL - SMB Mode */
		case .smbBatteryStatus: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBBatteryStatus)        /* CL - SMB Status */
		case .smbAlarmWarning: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBAlarmWarning)        /* CL - SMB Alarm Warning */
		case .smbChargerMode: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBChargerMode)            /* CL - SMB Charger Mode */
		case .smbChargerStatus: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBChargerStatus)        /* CL - SMB Charger Status */
		case .smbChargerSpecInfo: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBChargerSpecInfo)        /* CL - SMB Charger Extended Status */
		case .smbSelectorState: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBSelectorState)        /* CL - SMB Selector State */
		case .smbSelectorPresets: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBSelectorPresets)        /* CL - SMB Selector Presets */
		case .smbSelectorInfo: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBSelectorInfo)        /* CL - SMB Selector Info */
			/* Reserved 0x0A - 0x0F */
		case .optionalMfgFunction1: return (kHIDPage_BatterySystem, kHIDUsage_BS_OptionalMfgFunction1)    /* DV F - Battery System Optional SMB Mfg Function 1 */
		case .optionalMfgFunction2: return (kHIDPage_BatterySystem, kHIDUsage_BS_OptionalMfgFunction2)    /* DV F - Battery System Optional SMB Mfg Function 2 */
		case .optionalMfgFunction3: return (kHIDPage_BatterySystem, kHIDUsage_BS_OptionalMfgFunction3)    /* DV F - Battery System Optional SMB Mfg Function 3 */
		case .optionalMfgFunction4: return (kHIDPage_BatterySystem, kHIDUsage_BS_OptionalMfgFunction4)    /* DV F - Battery System Optional SMB Mfg Function 4 */
		case .optionalMfgFunction5: return (kHIDPage_BatterySystem, kHIDUsage_BS_OptionalMfgFunction5)    /* DV F - Battery System Optional SMB Mfg Function 5 */
		case .connectionToSMBus: return (kHIDPage_BatterySystem, kHIDUsage_BS_ConnectionToSMBus)        /* DF F - Battery System Connection To System Management Bus */
		case .outputConnection: return (kHIDPage_BatterySystem, kHIDUsage_BS_OutputConnection)        /* DF F - Battery System Output Connection Status */
		case .chargerConnection: return (kHIDPage_BatterySystem, kHIDUsage_BS_ChargerConnection)        /* DF F - Battery System Charger Connection */
		case .batteryInsertion: return (kHIDPage_BatterySystem, kHIDUsage_BS_BatteryInsertion)        /* DF F - Battery System Battery Insertion */
		case .usenext: return (kHIDPage_BatterySystem, kHIDUsage_BS_Usenext)                /* DF F - Battery System Use Next */
		case .okToUse: return (kHIDPage_BatterySystem, kHIDUsage_BS_OKToUse)                /* DF F - Battery System OK To Use */
		case .batterySupported: return (kHIDPage_BatterySystem, kHIDUsage_BS_BatterySupported)        /* DF F - Battery System Battery Supported */
		case .selectorRevision: return (kHIDPage_BatterySystem, kHIDUsage_BS_SelectorRevision)        /* DF F - Battery System Selector Revision */
		case .chargingIndicator: return (kHIDPage_BatterySystem, kHIDUsage_BS_ChargingIndicator)        /* DF F - Battery System Charging Indicator */
			/* Reserved 0x1E - 0x27 */
		case .manufacturerAccess: return (kHIDPage_BatterySystem, kHIDUsage_BS_ManufacturerAccess)        /* DV F - Battery System Manufacturer Access */
		case .remainingCapacityLimit: return (kHIDPage_BatterySystem, kHIDUsage_BS_RemainingCapacityLimit)    /* DV F - Battery System Remaining Capacity Limit */
		case .remainingTimeLimit: return (kHIDPage_BatterySystem, kHIDUsage_BS_RemainingTimeLimit)        /* DV F - Battery System Remaining Time Limit */
		case .atRate: return (kHIDPage_BatterySystem, kHIDUsage_BS_AtRate)                    /* DV F - Battery System At Rate... */
		case .capacityMode: return (kHIDPage_BatterySystem, kHIDUsage_BS_CapacityMode)            /* DV F - Battery System Capacity Mode */
		case .broadcastToCharger: return (kHIDPage_BatterySystem, kHIDUsage_BS_BroadcastToCharger)        /* DV F - Battery System Broadcast To Charger */
		case .primaryBattery: return (kHIDPage_BatterySystem, kHIDUsage_BS_PrimaryBattery)            /* DV F - Battery System Primary Battery */
		case .chargeController: return (kHIDPage_BatterySystem, kHIDUsage_BS_ChargeController)        /* DV F - Battery System Charge Controller */
			/* Reserved 0x30 - 0x3F */
		case .terminateCharge: return (kHIDPage_BatterySystem, kHIDUsage_BS_TerminateCharge)        /* DF IOF - Battery System Terminate Charge */
		case .terminateDischarge: return (kHIDPage_BatterySystem, kHIDUsage_BS_TerminateDischarge)        /* DF IOF - Battery System Terminate Discharge */
		case .belowRemainingCapacityLimit: return (kHIDPage_BatterySystem, kHIDUsage_BS_BelowRemainingCapacityLimit) /* DF IOF - Battery System Below Remaining Capacity Limit */
		case .remainingTimeLimitExpired: return (kHIDPage_BatterySystem, kHIDUsage_BS_RemainingTimeLimitExpired) /* DF IOF - Battery System Remaining Time Limit Expired */
		case .charging: return (kHIDPage_BatterySystem, kHIDUsage_BS_Charging)                /* DF IOF - Battery System Charging */
		case .discharging: return (kHIDPage_BatterySystem, kHIDUsage_BS_Discharging)            /* DV IOF - Battery System Discharging */
		case .fullyCharged: return (kHIDPage_BatterySystem, kHIDUsage_BS_FullyCharged)            /* DF IOF - Battery System Fully Charged */
		case .fullyDischarged: return (kHIDPage_BatterySystem, kHIDUsage_BS_FullyDischarged)        /* DV IOF - Battery System Fully Discharged */
		case .conditioningFlag: return (kHIDPage_BatterySystem, kHIDUsage_BS_ConditioningFlag)        /* DV IOF - Battery System Conditioning Flag */
		case .atRateOK: return (kHIDPage_BatterySystem, kHIDUsage_BS_AtRateOK)                /* DV IOF - Battery System At Rate OK */
		case .smbErrorCode: return (kHIDPage_BatterySystem, kHIDUsage_BS_SMBErrorCode)            /* DF IOF - Battery System SMB Error Code */
		case .needReplacement: return (kHIDPage_BatterySystem, kHIDUsage_BS_NeedReplacement)        /* DF IOF - Battery System Need Replacement */
			/* Reserved 0x4C - 0x5F */
		case .atRateTimeToFull: return (kHIDPage_BatterySystem, kHIDUsage_BS_AtRateTimeToFull)        /* DV IF - Battery System At Rate Time To Full */
		case .atRateTimeToEmpty: return (kHIDPage_BatterySystem, kHIDUsage_BS_AtRateTimeToEmpty)        /* DV IF - Battery System At Rate Time To Empty */
		case .averageCurrent: return (kHIDPage_BatterySystem, kHIDUsage_BS_AverageCurrent)            /* DV IF - Battery System Average Current */
		case .maxerror: return (kHIDPage_BatterySystem, kHIDUsage_BS_Maxerror)                /* DV IF - Battery System Max Error */
		case .relativeStateOfCharge: return (kHIDPage_BatterySystem, kHIDUsage_BS_RelativeStateOfCharge)    /* DV IF - Battery System Relative State Of Charge */
		case .absoluteStateOfCharge: return (kHIDPage_BatterySystem, kHIDUsage_BS_AbsoluteStateOfCharge)    /* DV IF - Battery System Absolute State Of Charge */
		case .remainingCapacity: return (kHIDPage_BatterySystem, kHIDUsage_BS_RemainingCapacity)        /* DV IF - Battery System Remaining Capacity */
		case .fullChargeCapacity: return (kHIDPage_BatterySystem, kHIDUsage_BS_FullChargeCapacity)        /* DV IF - Battery System Full Charge Capacity */
		case .runTimeToEmpty: return (kHIDPage_BatterySystem, kHIDUsage_BS_RunTimeToEmpty)            /* DV IF - Battery System Run Time To Empty */
		case .averageTimeToEmpty: return (kHIDPage_BatterySystem, kHIDUsage_BS_AverageTimeToEmpty)        /* DV IF - Battery System Average Time To Empty */
		case .averageTimeToFull: return (kHIDPage_BatterySystem, kHIDUsage_BS_AverageTimeToFull)        /* DV IF - Battery System Average Time To Full */
		case .cycleCount: return (kHIDPage_BatterySystem, kHIDUsage_BS_CycleCount)                /* DV IF - Battery System Cycle Count */
			/* Reserved 0x6C - 0x7F */
		case .battPackModelLevel: return (kHIDPage_BatterySystem, kHIDUsage_BS_BattPackModelLevel)        /* SV F - Battery System Batt Pack Model Level */
		case .internalChargeController: return (kHIDPage_BatterySystem, kHIDUsage_BS_InternalChargeController) /* SF F - Battery System Internal Charge Controller */
		case .primaryBatterySupport: return (kHIDPage_BatterySystem, kHIDUsage_BS_PrimaryBatterySupport)    /* SF F - Battery System Primary Battery Support */
		case .designCapacity: return (kHIDPage_BatterySystem, kHIDUsage_BS_DesignCapacity)            /* SV F - Battery System Design Capacity */
		case .specificationInfo: return (kHIDPage_BatterySystem, kHIDUsage_BS_SpecificationInfo)        /* SV F - Battery System Specification Info */
		case .manufacturerDate: return (kHIDPage_BatterySystem, kHIDUsage_BS_ManufacturerDate)        /* SV F - Battery System Manufacturer Date */
		case .serialNumber: return (kHIDPage_BatterySystem, kHIDUsage_BS_SerialNumber)            /* SV F - Battery System Serial Number */
		case .iManufacturerName: return (kHIDPage_BatterySystem, kHIDUsage_BS_iManufacturerName)        /* SV F - Battery System Manufacturer Name Index */
		case .iDevicename: return (kHIDPage_BatterySystem, kHIDUsage_BS_iDevicename)            /* SV F - Battery System Device Name Index */
		case .iDeviceChemistry: return (kHIDPage_BatterySystem, kHIDUsage_BS_iDeviceChemistry)        /* SV F - Battery System Device Chemistry Index */
		case .manufacturerData: return (kHIDPage_BatterySystem, kHIDUsage_BS_ManufacturerData)        /* SV F - Battery System Manufacturer Data */
		case .rechargable: return (kHIDPage_BatterySystem, kHIDUsage_BS_Rechargable)            /* SV F - Battery System Rechargable */
		case .warningCapacityLimit: return (kHIDPage_BatterySystem, kHIDUsage_BS_WarningCapacityLimit)    /* SV F - Battery System Warning Capacity Limit */
		case .capacityGranularity1: return (kHIDPage_BatterySystem, kHIDUsage_BS_CapacityGranularity1)    /* SV F - Battery System Capacity Granularity 1 */
		case .capacityGranularity2: return (kHIDPage_BatterySystem, kHIDUsage_BS_CapacityGranularity2)    /* SV F - Battery System Capacity Granularity 2 */
		case .iOEMInformation: return (kHIDPage_BatterySystem, kHIDUsage_BS_iOEMInformation)        /* SV F - Battery System OEM Information Index */
			/* Reserved 0x90 - 0xBF */
		case .inhibitCharge: return (kHIDPage_BatterySystem, kHIDUsage_BS_InhibitCharge)            /* DF IOF - Battery System Inhibit Charge */
		case .enablePolling: return (kHIDPage_BatterySystem, kHIDUsage_BS_EnablePolling)            /* DF IOF - Battery System Enable Polling */
		case .resetToZero: return (kHIDPage_BatterySystem, kHIDUsage_BS_ResetToZero)            /* DF IOF - Battery System Reset To Zero */
			/* Reserved 0xC3 - 0xCF */
		case .acPresent: return (kHIDPage_BatterySystem, kHIDUsage_BS_ACPresent)                /* DF IOF - Battery System AC Present */
		case .batteryPresent: return (kHIDPage_BatterySystem, kHIDUsage_BS_BatteryPresent)            /* DF IOF - Battery System Battery Present */
		case .powerFail: return (kHIDPage_BatterySystem, kHIDUsage_BS_PowerFail)                /* DF IOF - Battery System Power Fail */
		case .alarmInhibited: return (kHIDPage_BatterySystem, kHIDUsage_BS_AlarmInhibited)            /* DF IOF - Battery System Alarm Inhibited */
		case .thermistorUnderRange: return (kHIDPage_BatterySystem, kHIDUsage_BS_ThermistorUnderRange)    /* DF IOF - Battery System Thermistor Under Range */
		case .thermistorHot: return (kHIDPage_BatterySystem, kHIDUsage_BS_ThermistorHot)            /* DF IOF - Battery System Thermistor Hot */
		case .thermistorCold: return (kHIDPage_BatterySystem, kHIDUsage_BS_ThermistorCold)            /* DF IOF - Battery System Thermistor Cold */
		case .thermistorOverRange: return (kHIDPage_BatterySystem, kHIDUsage_BS_ThermistorOverRange)    /* DF IOF - Battery System Thermistor Over Range */
		case .voltageOutOfRange: return (kHIDPage_BatterySystem, kHIDUsage_BS_VoltageOutOfRange)        /* DF IOF - Battery System Voltage Out Of Range */
		case .currentOutOfRange: return (kHIDPage_BatterySystem, kHIDUsage_BS_CurrentOutOfRange)        /* DF IOF - Battery System Current Out Of Range */
		case .currentNotRegulated: return (kHIDPage_BatterySystem, kHIDUsage_BS_CurrentNotRegulated)    /* DF IOF - Battery System Current Not Regulated */
		case .voltageNotRegulated: return (kHIDPage_BatterySystem, kHIDUsage_BS_VoltageNotRegulated)    /* DF IOF - Battery System Voltage Not Regulated */
		case .masterMode: return (kHIDPage_BatterySystem, kHIDUsage_BS_MasterMode)                /* DF IOF - Battery System Master Mode */
			/* Reserved 0xDD - 0xEF */
		case .chargerSelectorSupport: return (kHIDPage_BatterySystem, kHIDUsage_BS_ChargerSelectorSupport)    /* SF F- Battery System Charger Support Selector */
		case .chargerSpec: return (kHIDPage_BatterySystem, kHIDUsage_BS_ChargerSpec)            /* SF F- Battery System Charger Specification */
		case .level2: return (kHIDPage_BatterySystem, kHIDUsage_BS_Level2)                    /* SF F- Battery System Charger Level 2 */
		case .level3: return (kHIDPage_BatterySystem, kHIDUsage_BS_Level3)                   /* SF F- Battery System Charger Level 3 */
			/* Reserved 0xF2 - 0xFF */
		case .reserved(let val): return (kHIDPage_BatterySystem, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_BS_Undefined: self = .undefined
		case kHIDUsage_BS_SMBBatteryMode: self = .smbBatteryMode
		case kHIDUsage_BS_SMBBatteryStatus: self = .smbBatteryStatus
		case kHIDUsage_BS_SMBAlarmWarning: self = .smbAlarmWarning
		case kHIDUsage_BS_SMBChargerMode: self = .smbChargerMode
		case kHIDUsage_BS_SMBChargerStatus: self = .smbChargerStatus
		case kHIDUsage_BS_SMBChargerSpecInfo: self = .smbChargerSpecInfo
		case kHIDUsage_BS_SMBSelectorState: self = .smbSelectorState
		case kHIDUsage_BS_SMBSelectorPresets: self = .smbSelectorPresets
		case kHIDUsage_BS_SMBSelectorInfo: self = .smbSelectorInfo
			/* Reserved 0x0A - 0x0F */
		case kHIDUsage_BS_OptionalMfgFunction1: self = .optionalMfgFunction1
		case kHIDUsage_BS_OptionalMfgFunction2: self = .optionalMfgFunction2
		case kHIDUsage_BS_OptionalMfgFunction3: self = .optionalMfgFunction3
		case kHIDUsage_BS_OptionalMfgFunction4: self = .optionalMfgFunction4
		case kHIDUsage_BS_OptionalMfgFunction5: self = .optionalMfgFunction5
		case kHIDUsage_BS_ConnectionToSMBus: self = .connectionToSMBus
		case kHIDUsage_BS_OutputConnection: self = .outputConnection
		case kHIDUsage_BS_ChargerConnection: self = .chargerConnection
		case kHIDUsage_BS_BatteryInsertion: self = .batteryInsertion
		case kHIDUsage_BS_Usenext: self = .usenext
		case kHIDUsage_BS_OKToUse: self = .okToUse
		case kHIDUsage_BS_BatterySupported: self = .batterySupported
		case kHIDUsage_BS_SelectorRevision: self = .selectorRevision
		case kHIDUsage_BS_ChargingIndicator: self = .chargingIndicator
			/* Reserved 0x1E - 0x27 */
		case kHIDUsage_BS_ManufacturerAccess: self = .manufacturerAccess
		case kHIDUsage_BS_RemainingCapacityLimit: self = .remainingCapacityLimit
		case kHIDUsage_BS_RemainingTimeLimit: self = .remainingTimeLimit
		case kHIDUsage_BS_AtRate: self = .atRate
		case kHIDUsage_BS_CapacityMode: self = .capacityMode
		case kHIDUsage_BS_BroadcastToCharger: self = .broadcastToCharger
		case kHIDUsage_BS_PrimaryBattery: self = .primaryBattery
		case kHIDUsage_BS_ChargeController: self = .chargeController
			/* Reserved 0x30 - 0x3F */
		case kHIDUsage_BS_TerminateCharge: self = .terminateCharge
		case kHIDUsage_BS_TerminateDischarge: self = .terminateDischarge
		case kHIDUsage_BS_BelowRemainingCapacityLimit: self = .belowRemainingCapacityLimit
		case kHIDUsage_BS_RemainingTimeLimitExpired: self = .remainingTimeLimitExpired
		case kHIDUsage_BS_Charging: self = .charging
		case kHIDUsage_BS_Discharging: self = .discharging
		case kHIDUsage_BS_FullyCharged: self = .fullyCharged
		case kHIDUsage_BS_FullyDischarged: self = .fullyDischarged
		case kHIDUsage_BS_ConditioningFlag: self = .conditioningFlag
		case kHIDUsage_BS_AtRateOK: self = .atRateOK
		case kHIDUsage_BS_SMBErrorCode: self = .smbErrorCode
		case kHIDUsage_BS_NeedReplacement: self = .needReplacement
			/* Reserved 0x4C - 0x5F */
		case kHIDUsage_BS_AtRateTimeToFull: self = .atRateTimeToFull
		case kHIDUsage_BS_AtRateTimeToEmpty: self = .atRateTimeToEmpty
		case kHIDUsage_BS_AverageCurrent: self = .averageCurrent
		case kHIDUsage_BS_Maxerror: self = .maxerror
		case kHIDUsage_BS_RelativeStateOfCharge: self = .relativeStateOfCharge
		case kHIDUsage_BS_AbsoluteStateOfCharge: self = .absoluteStateOfCharge
		case kHIDUsage_BS_RemainingCapacity: self = .remainingCapacity
		case kHIDUsage_BS_FullChargeCapacity: self = .fullChargeCapacity
		case kHIDUsage_BS_RunTimeToEmpty: self = .runTimeToEmpty
		case kHIDUsage_BS_AverageTimeToEmpty: self = .averageTimeToEmpty
		case kHIDUsage_BS_AverageTimeToFull: self = .averageTimeToFull
		case kHIDUsage_BS_CycleCount: self = .cycleCount
			/* Reserved 0x6C - 0x7F */
		case kHIDUsage_BS_BattPackModelLevel: self = .battPackModelLevel
		case kHIDUsage_BS_InternalChargeController: self = .internalChargeController
		case kHIDUsage_BS_PrimaryBatterySupport: self = .primaryBatterySupport
		case kHIDUsage_BS_DesignCapacity: self = .designCapacity
		case kHIDUsage_BS_SpecificationInfo: self = .specificationInfo
		case kHIDUsage_BS_ManufacturerDate: self = .manufacturerDate
		case kHIDUsage_BS_SerialNumber: self = .serialNumber
		case kHIDUsage_BS_iManufacturerName: self = .iManufacturerName
		case kHIDUsage_BS_iDevicename: self = .iDevicename
		case kHIDUsage_BS_iDeviceChemistry: self = .iDeviceChemistry
		case kHIDUsage_BS_ManufacturerData: self = .manufacturerData
		case kHIDUsage_BS_Rechargable: self = .rechargable
		case kHIDUsage_BS_WarningCapacityLimit: self = .warningCapacityLimit
		case kHIDUsage_BS_CapacityGranularity1: self = .capacityGranularity1
		case kHIDUsage_BS_CapacityGranularity2: self = .capacityGranularity2
		case kHIDUsage_BS_iOEMInformation: self = .iOEMInformation
			/* Reserved 0x90 - 0xBF */
		case kHIDUsage_BS_InhibitCharge: self = .inhibitCharge
		case kHIDUsage_BS_EnablePolling: self = .enablePolling
		case kHIDUsage_BS_ResetToZero: self = .resetToZero
			/* Reserved 0xC3 - 0xCF */
		case kHIDUsage_BS_ACPresent: self = .acPresent
		case kHIDUsage_BS_BatteryPresent: self = .batteryPresent
		case kHIDUsage_BS_PowerFail: self = .powerFail
		case kHIDUsage_BS_AlarmInhibited: self = .alarmInhibited
		case kHIDUsage_BS_ThermistorUnderRange: self = .thermistorUnderRange
		case kHIDUsage_BS_ThermistorHot: self = .thermistorHot
		case kHIDUsage_BS_ThermistorCold: self = .thermistorCold
		case kHIDUsage_BS_ThermistorOverRange: self = .thermistorOverRange
		case kHIDUsage_BS_VoltageOutOfRange: self = .voltageOutOfRange
		case kHIDUsage_BS_CurrentOutOfRange: self = .currentOutOfRange
		case kHIDUsage_BS_CurrentNotRegulated: self = .currentNotRegulated
		case kHIDUsage_BS_VoltageNotRegulated: self = .voltageNotRegulated
		case kHIDUsage_BS_MasterMode: self = .masterMode
			/* Reserved 0xDD - 0xEF */
		case kHIDUsage_BS_ChargerSelectorSupport: self = .chargerSelectorSupport
		case kHIDUsage_BS_ChargerSpec: self = .chargerSpec
		case kHIDUsage_BS_Level2: self = .level2
		case kHIDUsage_BS_Level3: self = .level3
			/* Reserved 0xF2 - 0xFF */
		default: self = .reserved(usage)
		}
	}
}

/**
 Bar Code Scanner Page (0x8C)

 This section provides detailed descriptions of the usages employed by Bar Code Scanner Devices.
 */
public enum BarCodeScannerUsage: IUsagePageUsage
{
	case undefined /* Bar Code Scanner Undefined Usage */
	case badgeReader /* CA - Bar Code Badge Reader */
	case barCodeScanner /* CA -Bar Code Scanner */
	case dumbBarCodeScanner /* CA -Dumb Bar Code Scanner  Usage */
	case cordlessScannerBase /* CA -Cordless Base Usage */
	case barCodeScannerCradle /* CA -Bar Code Scanner Cradle Usage */
	/* Reserved 0x06 - 0x0F */
	case attributeReport /* CL - Attribute Report */
	case settingsReport /* CL - Settings Report */
	case scannedDataReport /* CL - Scanned Data Report */
	case rawScannedDataReport /* CL - Raw Scanned Data Report */
	case triggerReport /* CL - Trigger Report */
	case statusReport /* CL - Status Report */
	case upc_EANControlReport /* CL - UPC/EAN Control Report */
	case ean2_3LabelControlReport /* CL - EAN 2/3 Label Control Report */
	case code39ControlReport /* CL - Code 39 Control Report */
	case interleaved2of5ControlReport /* CL - Interleaved 2 of 5 Control Report */
	case standard2of5ControlReport /* CL - Standard 2 of 5 Control Report */
	case mSIPlesseyControlReport /* CL - MSI Plessey Control Report */
	case codabarControlReport /* CL - Codabar Control Report */
	case code128ControlReport /* CL - Code 128 Control Report */
	case misc1DControlReport /* CL - Misc 1D Control Report */
	case twoDControlReport /* CL - 2D Control Report */
	/* Reserved 0x20 - 0x2F */
	case aiming_PointerMide /* SF - Aiming Pointer Mode */
	case barCodePresentSensor /* SF - Bar Code Present Sensor */
	case class1ALaser /* SF - Class 1A Laser */
	case class2Laser /* SF - Class 2 Laser */
	case heaterPresent /* SF - Heater Present */
	case contactScanner /* SF - Contact Scanner */
	case electronicArticleSurveillanceNotification /* SF - Electronic Article Surveillance Notification */
	case constantElectronicArticleSurveillance /* SF - Constant Electronic Article Surveillance */
	case errorIndication /* SF - Error Indication */
	case fixedBeeper /* SF - Fixed Beeper */
	case goodDecodeIndication /* SF - Good Decode Indication */
	case handsFreeScanning /* SF - Hands Free Scanning */
	case intrinsicallySafe /* SF - Intrinsically Safe */
	case klasseEinsLaser /* SF - Klasse Eins Laser */
	case longRangeScanner /* SF - Long Range Scanner */
	case mirrorSpeedControl /* SF - Mirror Speed Control */
	case notOnFileIndication /* SF - Not On File Indication */
	case programmableBeeper /* SF - Programmable Beeper */
	case triggerless /* SF - Triggerless */
	case wand /* SF - Wand */
	case waterResistant /* SF - Water Resistant */
	case multiRangeScanner /* SF - Multi-Range Scanner */
	case proximitySensor /* SF - Proximity Sensor */
	/* Reserved 0x47 - 0x4C */
	case fragmentDecoding /* DF - Fragment Decoding */
	case scannerReadConfidence /* DV - Scanner Read Confidence */
	case dataPrefix /* NAry - Data Prefix  */
	case prefixAIMI /* SEL - Prefix AIMI */
	case prefixNone /* SEL - Prefix None */
	case prefixProprietary /* SEL - Prefix Proprietary */
	/* Reserved 0x53 - 0x54 */
	case activeTime /* DV - Active Time */
	case aimingLaserPattern /* DF - Aiming Laser Pattern */
	case barCodePresent /* OOC - Bar Code Present */
	case beeperState /* OOC - Beeper State */
	case laserOnTime /* DV - Laser On Time */
	case laserState /* OOC - Laser State */
	case lockoutTime /* DV - Lockout Time */
	case motorState /* OOC - Motor State */
	case motorTimeout /* DV - Motor Timeout */
	case powerOnResetScanner /* DF - Power On Reset Scanner */
	case preventReadOfBarcodes /* DF - Prevent Read of Barcodes */
	case initiateBarcodeRead /* DF - Initiate Barcode Read */
	case triggerState /* DF - Trigger State */
	case triggerMode /* NAry - Trigger Mode */
	case triggerModeBlinkingLaserOn /* SEL - Trigger Mode Blinking Laser On */
	case triggerModeContinuousLaserOn /* SEL - Trigger Mode Continuous Laser On */
	case triggerModeLaserOnWhilePulled /* SEL - Trigger Mode Laser on while Pulled */
	case triggerModeLaserStaysOnAfterTriggerRelease /* SEL - Trigger Mode Laser stays on after Trigger Release */
	/* Reserved 0x67 - 0x6C */
	case commitParametersToNVM /* DF - Commit Parameters to NVM */
	case parameterScanning /* DF - Parameter Scanning */
	case parametersChanged /* OOC - Parameters Changed */
	case setParameterDefaultValues /* DF - Set parameter default values */
	/* Reserved 0x71 - 0x74 */
	case scannerInCradle /* OOC - Scanner In Cradle */
	case scannerInRange /* OOC - Scanner In Range */
	/* Reserved 0x77 - 0x79 */
	case aimDuration /* DV - Aim Duration */
	case goodReadLampDuration /* DV - Good Read Lamp Duration */
	case goodReadLampIntensity /* DV - Good Read Lamp Intensity */
	case goodReadLED /* DF - Good Read LED */
	case goodReadToneFrequency /* DV - Good Read Tone Frequency*/
	case goodReadToneLength /* DV - Good Read Tone Length */
	case goodReadToneVolume /* DV - Good Read Tone Volume */
	/* Reserved 0x81 */
	case noReadMessage /* DF - No Read Message */
	case notOnFileVolume /* DV - Not on File Volume */
	case powerupBeep /* DF - Powerup Beep */
	case soundErrorBeep /* DF - Sound Error Beep */
	case soundGoodReadBeep /* DF - Sound Good Read Beep */
	case soundNotOnFileBeep /* DF - Sound Not On File Beep */
	case goodReadWhenToWrite /* NArry - Good Read When to Write */
	case grwtiAfterDecode /* SEL - GRWTI After Decode */
	case grwtiBeep_LampAfterTransmit /* SEL - GRWTI Beep/Lamp after transmit */
	case grwtiNoBeep_LampUseAtAll /* SEL - GRWTI No Beep/Lamp at all */
	/* Reserved 0x8C - 0x90 */
	case booklandEAN /* DF - Bookland EAN */
	case convertEAN8To13Type /* DF - Convert EAN 8 to 13 Type */
	case convertUPCAToEAN_13 /* DF - Convert UPC A to EAN-13 */
	case convertUPC_EToA /* DF - Convert UPC-E to A */
	case ean_13 /* DF - EAN-13 */
	case ean_8 /* DF - EAN_8 */
	case ean_99_128_Mandatory /* DF - EAN-99 128_Mandatory  */
	case ean_99_P5_128_Optional /* DF - EAN-99 P5/128_Optional */
	/* Reserved 0x99 */
	case upc_EAN /* DF - UPC/EAN */
	case upc_EANCouponCode /* DF - UPC/EAN Coupon Code */
	case upc_EANPeriodicals /* DV - UPC/EAN Periodicals */
	case upc_A /* DF - UPC-A */
	case upc_AWith128Mandatory /* DF - UPC-A with 128 Mandatory */
	case upc_AWith128Optical /* DF - UPC-A with 128 Optical */
	case upc_AWithP5Optional /* DF - UPC-A with P5 Optional */
	case upc_E /* DF - UPC-E */
	case upc_E1 /* DF - UPC-E1 */
	/* Reserved 0xA3 - 0xA8 */
	case periodical /* NArry - Periodical */
	case periodicalAutoDiscriminatePlus2 /* SEL - Periodical Auto-Discriminate + 2 */
	case periodicalOnlyDecodeWithPlus2 /* SEL - Periodical Only Decode with + 2 */
	case periodicalIgnorePlus2 /* SEL - Periodical Ignore + 2 */
	case periodicalAutoDiscriminatePlus5 /* SEL - Periodical Auto-Discriminate + 5 */
	case periodicalOnlyDecodeWithPlus5 /* SEL - Periodical Only Decode with + 5 */
	case periodicalIgnorePlus5 /* SEL - Periodical Ignore + 5 */
	case check /* NArry - Check */
	case checkDisablePrice /* SEL - Check Disable Price */
	case checkEnable4DigitPrice /* SEL - Check Enable 4 digit Price */
	case checkEnable5DigitPrice /* SEL - Check Enable 5 digit Price */
	case checkEnableEuropean4DigitPrice /* SEL - Check Enable European 4 digit Price */
	case checkEnableEuropean5DigitPrice /* SEL - Check Enable European 5 digit Price */
	/* Reserved 0xB6 */
	case eanTwoLabel /* DF - EAN Two Label  */
	case eanThreeLabel /* DF - EAN Thread Label */
	case ean8FlagDigit1 /* DV - EAN 8 Flag Digit 1 */
	case ean8FlagDigit2 /* DV - EAN 8 Flag Digit 2 */
	case ean8FlagDigit3 /* DV - EAN 8 Flag Digit 3 */
	case ean13FlagDigit1 /* DV - EAN 13 Flag Digit 1 */
	case ean13FlagDigit2 /* DV - EAN 13 Flag Digit 2 */
	case ean13FlagDigit3 /* DV - EAN 13 Flag Digit 3 */
	case addEAN2_3LabelDefinition /* DF - Add EAN 2/3 Label Definition */
	case clearAllEAN2_3LabelDefinitions /* DF - Clear all EAN 2/3 Label Definitions */
	/* Reserved 0xC1 - 0xC2 */
	case codabar /* DF - Codabar */
	case code128 /* DF - Code 128 */
	/* Reserved 0xC5 - 0xC6 */
	case code39 /* DF - Code 39 */
	case code93 /* DF - Code 93 */
	case fullASCIIConversion /* DF - Full ASCII Conversion */
	case interleaved2of5 /* DF - Interleaved 2 of 5 */
	case italianPharmacyCode /* DF - Italian Pharmacy Code */
	case msi_Plessey /* DF - MSI/Plessey */
	case standard2of5IATA /* DF - Standard 2 of 5 IATA */
	case standard2of5 /* DF - Standard 2 of 5 */
	/* Reserved 0xCF - 0xD2 */
	case transmitStart_Stop /* DF - Transmit Start/Stop */
	case triOptic /* DF - Tri-Optic  */
	case ucc_EAN_128 /* DF - UCC/EAN-128  */
	case checkDigit /* NArry - Check Digit */
	case checkDigitDisable /* SEL - Check Digit Disable */
	case checkDigitEnableInterleaved2of5OPCC /* SEL - Check Digit Enable Interleaved 2 of 5 OPCC */
	case checkDigitEnableInterleaved2of5USS /* SEL - Check Digit Enable Interleaved 2 of 5 USS */
	case checkDigitEnableStandard2of5OPCC /* SEL - Check Digit Enable Standard 2 of 5 OPCC */
	case checkDigitEnableStandard2of5USS /* SEL - Check Digit Enable Standard 2 of 5 USS */
	case checkDigitEnableOneMSIPlessey /* SEL - Check Digit Enable One MSI Plessey */
	case checkDigitEnableTwoMSIPlessey /* SEL - Check Digit Enable Two MSI Plessey */
	case checkDigitCodabarEnable /* SEL - Check Digit Codabar Enable */
	case checkDigitCode99Enable /* SEL - Check Digit Code 99 Enable */
	/* Reserved 0xE0 - 0xEF */
	case transmitCheckDigit /* NArry - Transmit Check Digit */
	case disableCheckDigitTransmit /* SEL - Disable Check Digit Transmit */
	case enableCheckDigitTransmit /* SEL - Enable Check Digit Transmit */
	/* Reserved 0xF3 - 0xFA */
	case symbologyIdentifier1 /* DV - Symbology Identifier 1 */
	case symbologyIdentifier2 /* DV - Symbology Identifier 2 */
	case symbologyIdentifier3 /* DV - Symbology Identifier 3 */
	case decodedData /* DV - Decoded Data */
	case decodeDataContinued /* DF - Decode Data Continued */
	case barSpaceData /* DV - Bar Space Data */
	case scannerDataAccuracy /* DV - Scanner Data Accuracy */
	case rawDataPolarity /* NArry - Raw Data Polarity */
	case polarityInvertedBarCode /* SEL - Polarity Inverted Bar Code */
	case polarityNormalBarCode /* SEL - Polarity Normal Bar Code */
	/* Reserved 0x105 */
	case minimumLengthToDecode /* DV - Minimum Length to Decode */
	case maximumLengthToDecode /* DV - Maximum Length to Decode */
	case firstDiscreteLengthToDecode /* DV - First Discrete Length to Decode */
	case secondDiscreteLengthToDecode /* DV - Second Discrete Length to Decode */
	case dataLengthMethod /* NArry - Data Length Method */
	case dlMethodReadAny /* DF - DL Method Read any */
	case dlMethodCheckInRange /* DF - DL Method Check in Range */
	case dlMethodCheckForDiscrete /* DF - DL Method Check for Discrete */
	/* Reserved 0x10E - 0x10F */
	case aztecCode /* DF - Aztec Code */
	case bC412 /* DF - BC412 */
	case channelCode /* DF - Channel Code */
	case code16 /* DF - Code 16 */
	case code32 /* DF - Code 32 */
	case code49 /* DF - Code 49 */
	case codeOne /* DF - Code One */
	case colorcode /* DF - Colorcode */
	case dataMatrix /* DF - Data Matrix */
	case maxiCode /* DF - MaxiCode */
	case microPDF /* DF - MicroPDF */
	case pdf_417 /* DF - PDF-417 */
	case posiCode /* DF - PosiCode */
	case qrCode /* DF - QR Code */
	case superCode /* DF - SuperCode */
	case ultraCode /* DF - UltraCode */
	case usb_5_SlugCode /* DF - USD-5 (Slug Code) */
	case veriCode /* DF - VeriCode */
	/* Reserved 0x122 - 0xFFFF */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Undefined) /* Bar Code Scanner Undefined Usage */
		case .badgeReader: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BadgeReader) /* CA - Bar Code Badge Reader */
		case .barCodeScanner: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BarCodeScanner) /* CA -Bar Code Scanner */
		case .dumbBarCodeScanner: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DumbBarCodeScanner) /* CA -Dumb Bar Code Scanner  Usage */
		case .cordlessScannerBase: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CordlessScannerBase) /* CA -Cordless Base Usage */
		case .barCodeScannerCradle: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BarCodeScannerCradle) /* CA -Bar Code Scanner Cradle Usage */
			/* Reserved 0x06 - 0x0F */
		case .attributeReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_AttributeReport) /* CL - Attribute Report */
		case .settingsReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SettingsReport) /* CL - Settings Report */
		case .scannedDataReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ScannedDataReport) /* CL - Scanned Data Report */
		case .rawScannedDataReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_RawScannedDataReport) /* CL - Raw Scanned Data Report */
		case .triggerReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TriggerReport) /* CL - Trigger Report */
		case .statusReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_StatusReport) /* CL - Status Report */
		case .upc_EANControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_EANControlReport) /* CL - UPC/EAN Control Report */
		case .ean2_3LabelControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN2_3LabelControlReport) /* CL - EAN 2/3 Label Control Report */
		case .code39ControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Code39ControlReport) /* CL - Code 39 Control Report */
		case .interleaved2of5ControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Interleaved2of5ControlReport) /* CL - Interleaved 2 of 5 Control Report */
		case .standard2of5ControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Standard2of5ControlReport) /* CL - Standard 2 of 5 Control Report */
		case .mSIPlesseyControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MSIPlesseyControlReport) /* CL - MSI Plessey Control Report */
		case .codabarControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CodabarControlReport) /* CL - Codabar Control Report */
		case .code128ControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Code128ControlReport) /* CL - Code 128 Control Report */
		case .misc1DControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Misc1DControlReport) /* CL - Misc 1D Control Report */
		case .twoDControlReport: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_2DControlReport) /* CL - 2D Control Report */
			/* Reserved 0x20 - 0x2F */
		case .aiming_PointerMide: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Aiming_PointerMide) /* SF - Aiming Pointer Mode */
		case .barCodePresentSensor: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BarCodePresentSensor) /* SF - Bar Code Present Sensor */
		case .class1ALaser: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Class1ALaser) /* SF - Class 1A Laser */
		case .class2Laser: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Class2Laser) /* SF - Class 2 Laser */
		case .heaterPresent: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_HeaterPresent) /* SF - Heater Present */
		case .contactScanner: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ContactScanner) /* SF - Contact Scanner */
		case .electronicArticleSurveillanceNotification: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ElectronicArticleSurveillanceNotification) /* SF - Electronic Article Surveillance Notification */
		case .constantElectronicArticleSurveillance: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ConstantElectronicArticleSurveillance) /* SF - Constant Electronic Article Surveillance */
		case .errorIndication: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ErrorIndication) /* SF - Error Indication */
		case .fixedBeeper: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_FixedBeeper) /* SF - Fixed Beeper */
		case .goodDecodeIndication: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GoodDecodeIndication) /* SF - Good Decode Indication */
		case .handsFreeScanning: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_HandsFreeScanning) /* SF - Hands Free Scanning */
		case .intrinsicallySafe: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_IntrinsicallySafe) /* SF - Intrinsically Safe */
		case .klasseEinsLaser: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_KlasseEinsLaser) /* SF - Klasse Eins Laser */
		case .longRangeScanner: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_LongRangeScanner) /* SF - Long Range Scanner */
		case .mirrorSpeedControl: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MirrorSpeedControl) /* SF - Mirror Speed Control */
		case .notOnFileIndication: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_NotOnFileIndication) /* SF - Not On File Indication */
		case .programmableBeeper: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ProgrammableBeeper) /* SF - Programmable Beeper */
		case .triggerless: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Triggerless) /* SF - Triggerless */
		case .wand: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Wand) /* SF - Wand */
		case .waterResistant: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_WaterResistant) /* SF - Water Resistant */
		case .multiRangeScanner: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MultiRangeScanner) /* SF - Multi-Range Scanner */
		case .proximitySensor: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ProximitySensor) /* SF - Proximity Sensor */
			/* Reserved 0x47 - 0x4C */
		case .fragmentDecoding: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_FragmentDecoding) /* DF - Fragment Decoding */
		case .scannerReadConfidence: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ScannerReadConfidence) /* DV - Scanner Read Confidence */
		case .dataPrefix: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DataPrefix) /* NAry - Data Prefix  */
		case .prefixAIMI: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PrefixAIMI) /* SEL - Prefix AIMI */
		case .prefixNone: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PrefixNone) /* SEL - Prefix None */
		case .prefixProprietary: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PrefixProprietary) /* SEL - Prefix Proprietary */
			/* Reserved 0x53 - 0x54 */
		case .activeTime: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ActiveTime) /* DV - Active Time */
		case .aimingLaserPattern: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_AimingLaserPattern) /* DF - Aiming Laser Pattern */
		case .barCodePresent: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BarCodePresent) /* OOC - Bar Code Present */
		case .beeperState: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BeeperState) /* OOC - Beeper State */
		case .laserOnTime: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_LaserOnTime) /* DV - Laser On Time */
		case .laserState: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_LaserState) /* OOC - Laser State */
		case .lockoutTime: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_LockoutTime) /* DV - Lockout Time */
		case .motorState: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MotorState) /* OOC - Motor State */
		case .motorTimeout: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MotorTimeout) /* DV - Motor Timeout */
		case .powerOnResetScanner: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PowerOnResetScanner) /* DF - Power On Reset Scanner */
		case .preventReadOfBarcodes: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PreventReadOfBarcodes) /* DF - Prevent Read of Barcodes */
		case .initiateBarcodeRead: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_InitiateBarcodeRead) /* DF - Initiate Barcode Read */
		case .triggerState: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TriggerState) /* DF - Trigger State */
		case .triggerMode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TriggerMode) /* NAry - Trigger Mode */
		case .triggerModeBlinkingLaserOn: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TriggerModeBlinkingLaserOn) /* SEL - Trigger Mode Blinking Laser On */
		case .triggerModeContinuousLaserOn: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TriggerModeContinuousLaserOn) /* SEL - Trigger Mode Continuous Laser On */
		case .triggerModeLaserOnWhilePulled: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TriggerModeLaserOnWhilePulled) /* SEL - Trigger Mode Laser on while Pulled */
		case .triggerModeLaserStaysOnAfterTriggerRelease: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TriggerModeLaserStaysOnAfterTriggerRelease) /* SEL - Trigger Mode Laser stays on after Trigger Release */
			/* Reserved 0x67 - 0x6C */
		case .commitParametersToNVM: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CommitParametersToNVM) /* DF - Commit Parameters to NVM */
		case .parameterScanning: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ParameterScanning) /* DF - Parameter Scanning */
		case .parametersChanged: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ParametersChanged) /* OOC - Parameters Changed */
		case .setParameterDefaultValues: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SetParameterDefaultValues) /* DF - Set parameter default values */
			/* Reserved 0x71 - 0x74 */
		case .scannerInCradle: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ScannerInCradle) /* OOC - Scanner In Cradle */
		case .scannerInRange: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ScannerInRange) /* OOC - Scanner In Range */
			/* Reserved 0x77 - 0x79 */
		case .aimDuration: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_AimDuration) /* DV - Aim Duration */
		case .goodReadLampDuration: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GoodReadLampDuration) /* DV - Good Read Lamp Duration */
		case .goodReadLampIntensity: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GoodReadLampIntensity) /* DV - Good Read Lamp Intensity */
		case .goodReadLED: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GoodReadLED) /* DF - Good Read LED */
		case .goodReadToneFrequency: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GoodReadToneFrequency) /* DV - Good Read Tone Frequency*/
		case .goodReadToneLength: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GoodReadToneLength) /* DV - Good Read Tone Length */
		case .goodReadToneVolume: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GoodReadToneVolume) /* DV - Good Read Tone Volume */
			/* Reserved 0x81 */
		case .noReadMessage: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_NoReadMessage) /* DF - No Read Message */
		case .notOnFileVolume: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_NotOnFileVolume) /* DV - Not on File Volume */
		case .powerupBeep: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PowerupBeep) /* DF - Powerup Beep */
		case .soundErrorBeep: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SoundErrorBeep) /* DF - Sound Error Beep */
		case .soundGoodReadBeep: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SoundGoodReadBeep) /* DF - Sound Good Read Beep */
		case .soundNotOnFileBeep: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SoundNotOnFileBeep) /* DF - Sound Not On File Beep */
		case .goodReadWhenToWrite: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GoodReadWhenToWrite) /* NArry - Good Read When to Write */
		case .grwtiAfterDecode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GRWTIAfterDecode) /* SEL - GRWTI After Decode */
		case .grwtiBeep_LampAfterTransmit: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GRWTIBeep_LampAfterTransmit) /* SEL - GRWTI Beep/Lamp after transmit */
		case .grwtiNoBeep_LampUseAtAll: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_GRWTINoBeep_LampUseAtAll) /* SEL - GRWTI No Beep/Lamp at all */
			/* Reserved 0x8C - 0x90 */
		case .booklandEAN: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BooklandEAN) /* DF - Bookland EAN */
		case .convertEAN8To13Type: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ConvertEAN8To13Type) /* DF - Convert EAN 8 to 13 Type */
		case .convertUPCAToEAN_13: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ConvertUPCAToEAN_13) /* DF - Convert UPC A to EAN-13 */
		case .convertUPC_EToA: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ConvertUPC_EToA) /* DF - Convert UPC-E to A */
		case .ean_13: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN_13) /* DF - EAN-13 */
		case .ean_8: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN_8) /* DF - EAN_8 */
		case .ean_99_128_Mandatory: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN_99_128_Mandatory) /* DF - EAN-99 128_Mandatory  */
		case .ean_99_P5_128_Optional: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN_99_P5_128_Optional) /* DF - EAN-99 P5/128_Optional */
			/* Reserved 0x99 */
		case .upc_EAN: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_EAN) /* DF - UPC/EAN */
		case .upc_EANCouponCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_EANCouponCode) /* DF - UPC/EAN Coupon Code */
		case .upc_EANPeriodicals: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_EANPeriodicals) /* DV - UPC/EAN Periodicals */
		case .upc_A: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_A) /* DF - UPC-A */
		case .upc_AWith128Mandatory: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_AWith128Mandatory) /* DF - UPC-A with 128 Mandatory */
		case .upc_AWith128Optical: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_AWith128Optical) /* DF - UPC-A with 128 Optical */
		case .upc_AWithP5Optional: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_AWithP5Optional) /* DF - UPC-A with P5 Optional */
		case .upc_E: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_E) /* DF - UPC-E */
		case .upc_E1: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UPC_E1) /* DF - UPC-E1 */
			/* Reserved 0xA3 - 0xA8 */
		case .periodical: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Periodical) /* NArry - Periodical */
		case .periodicalAutoDiscriminatePlus2: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PeriodicalAutoDiscriminatePlus2) /* SEL - Periodical Auto-Discriminate + 2 */
		case .periodicalOnlyDecodeWithPlus2: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PeriodicalOnlyDecodeWithPlus2) /* SEL - Periodical Only Decode with + 2 */
		case .periodicalIgnorePlus2: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PeriodicalIgnorePlus2) /* SEL - Periodical Ignore + 2 */
		case .periodicalAutoDiscriminatePlus5: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PeriodicalAutoDiscriminatePlus5) /* SEL - Periodical Auto-Discriminate + 5 */
		case .periodicalOnlyDecodeWithPlus5: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PeriodicalOnlyDecodeWithPlus5) /* SEL - Periodical Only Decode with + 5 */
		case .periodicalIgnorePlus5: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PeriodicalIgnorePlus5) /* SEL - Periodical Ignore + 5 */
		case .check: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Check) /* NArry - Check */
		case .checkDisablePrice: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDisablePrice) /* SEL - Check Disable Price */
		case .checkEnable4DigitPrice: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckEnable4DigitPrice) /* SEL - Check Enable 4 digit Price */
		case .checkEnable5DigitPrice: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckEnable5DigitPrice) /* SEL - Check Enable 5 digit Price */
		case .checkEnableEuropean4DigitPrice: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckEnableEuropean4DigitPrice) /* SEL - Check Enable European 4 digit Price */
		case .checkEnableEuropean5DigitPrice: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckEnableEuropean5DigitPrice) /* SEL - Check Enable European 5 digit Price */
			/* Reserved 0xB6 */
		case .eanTwoLabel: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EANTwoLabel) /* DF - EAN Two Label  */
		case .eanThreeLabel: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EANThreeLabel) /* DF - EAN Thread Label */
		case .ean8FlagDigit1: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN8FlagDigit1) /* DV - EAN 8 Flag Digit 1 */
		case .ean8FlagDigit2: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN8FlagDigit2) /* DV - EAN 8 Flag Digit 2 */
		case .ean8FlagDigit3: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN8FlagDigit3) /* DV - EAN 8 Flag Digit 3 */
		case .ean13FlagDigit1: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN13FlagDigit1) /* DV - EAN 13 Flag Digit 1 */
		case .ean13FlagDigit2: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN13FlagDigit2) /* DV - EAN 13 Flag Digit 2 */
		case .ean13FlagDigit3: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EAN13FlagDigit3) /* DV - EAN 13 Flag Digit 3 */
		case .addEAN2_3LabelDefinition: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_AddEAN2_3LabelDefinition) /* DF - Add EAN 2/3 Label Definition */
		case .clearAllEAN2_3LabelDefinitions: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ClearAllEAN2_3LabelDefinitions) /* DF - Clear all EAN 2/3 Label Definitions */
			/* Reserved 0xC1 - 0xC2 */
		case .codabar: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Codabar) /* DF - Codabar */
		case .code128: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Code128) /* DF - Code 128 */
			/* Reserved 0xC5 - 0xC6 */
		case .code39: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Code39) /* DF - Code 39 */
		case .code93: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Code93) /* DF - Code 93 */
		case .fullASCIIConversion: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_FullASCIIConversion) /* DF - Full ASCII Conversion */
		case .interleaved2of5: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Interleaved2of5) /* DF - Interleaved 2 of 5 */
		case .italianPharmacyCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ItalianPharmacyCode) /* DF - Italian Pharmacy Code */
		case .msi_Plessey: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MSI_Plessey) /* DF - MSI/Plessey */
		case .standard2of5IATA: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Standard2of5IATA) /* DF - Standard 2 of 5 IATA */
		case .standard2of5: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Standard2of5) /* DF - Standard 2 of 5 */
			/* Reserved 0xCF - 0xD2 */
		case .transmitStart_Stop: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TransmitStart_Stop) /* DF - Transmit Start/Stop */
		case .triOptic: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TriOptic) /* DF - Tri-Optic  */
		case .ucc_EAN_128: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UCC_EAN_128) /* DF - UCC/EAN-128  */
		case .checkDigit: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigit) /* NArry - Check Digit */
		case .checkDigitDisable: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitDisable) /* SEL - Check Digit Disable */
		case .checkDigitEnableInterleaved2of5OPCC: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitEnableInterleaved2of5OPCC) /* SEL - Check Digit Enable Interleaved 2 of 5 OPCC */
		case .checkDigitEnableInterleaved2of5USS: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitEnableInterleaved2of5USS) /* SEL - Check Digit Enable Interleaved 2 of 5 USS */
		case .checkDigitEnableStandard2of5OPCC: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitEnableStandard2of5OPCC) /* SEL - Check Digit Enable Standard 2 of 5 OPCC */
		case .checkDigitEnableStandard2of5USS: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitEnableStandard2of5USS) /* SEL - Check Digit Enable Standard 2 of 5 USS */
		case .checkDigitEnableOneMSIPlessey: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitEnableOneMSIPlessey) /* SEL - Check Digit Enable One MSI Plessey */
		case .checkDigitEnableTwoMSIPlessey: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitEnableTwoMSIPlessey) /* SEL - Check Digit Enable Two MSI Plessey */
		case .checkDigitCodabarEnable: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitCodabarEnable) /* SEL - Check Digit Codabar Enable */
		case .checkDigitCode99Enable: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CheckDigitCode99Enable) /* SEL - Check Digit Code 99 Enable */
			/* Reserved 0xE0 - 0xEF */
		case .transmitCheckDigit: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_TransmitCheckDigit) /* NArry - Transmit Check Digit */
		case .disableCheckDigitTransmit: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DisableCheckDigitTransmit) /* SEL - Disable Check Digit Transmit */
		case .enableCheckDigitTransmit: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_EnableCheckDigitTransmit) /* SEL - Enable Check Digit Transmit */
			/* Reserved 0xF3 - 0xFA */
		case .symbologyIdentifier1: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SymbologyIdentifier1) /* DV - Symbology Identifier 1 */
		case .symbologyIdentifier2: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SymbologyIdentifier2) /* DV - Symbology Identifier 2 */
		case .symbologyIdentifier3: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SymbologyIdentifier3) /* DV - Symbology Identifier 3 */
		case .decodedData: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DecodedData) /* DV - Decoded Data */
		case .decodeDataContinued: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DecodeDataContinued) /* DF - Decode Data Continued */
		case .barSpaceData: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BarSpaceData) /* DV - Bar Space Data */
		case .scannerDataAccuracy: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ScannerDataAccuracy) /* DV - Scanner Data Accuracy */
		case .rawDataPolarity: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_RawDataPolarity) /* NArry - Raw Data Polarity */
		case .polarityInvertedBarCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PolarityInvertedBarCode) /* SEL - Polarity Inverted Bar Code */
		case .polarityNormalBarCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PolarityNormalBarCode) /* SEL - Polarity Normal Bar Code */
			/* Reserved 0x105 */
		case .minimumLengthToDecode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MinimumLengthToDecode) /* DV - Minimum Length to Decode */
		case .maximumLengthToDecode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MaximumLengthToDecode) /* DV - Maximum Length to Decode */
		case .firstDiscreteLengthToDecode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_FirstDiscreteLengthToDecode) /* DV - First Discrete Length to Decode */
		case .secondDiscreteLengthToDecode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SecondDiscreteLengthToDecode) /* DV - Second Discrete Length to Decode */
		case .dataLengthMethod: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DataLengthMethod) /* NArry - Data Length Method */
		case .dlMethodReadAny: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DLMethodReadAny) /* DF - DL Method Read any */
		case .dlMethodCheckInRange: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DLMethodCheckInRange) /* DF - DL Method Check in Range */
		case .dlMethodCheckForDiscrete: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DLMethodCheckForDiscrete) /* DF - DL Method Check for Discrete */
			/* Reserved 0x10E - 0x10F */
		case .aztecCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_AztecCode) /* DF - Aztec Code */
		case .bC412: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_BC412) /* DF - BC412 */
		case .channelCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_ChannelCode) /* DF - Channel Code */
		case .code16: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Code16) /* DF - Code 16 */
		case .code32: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Code32) /* DF - Code 32 */
		case .code49: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Code49) /* DF - Code 49 */
		case .codeOne: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_CodeOne) /* DF - Code One */
		case .colorcode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_Colorcode) /* DF - Colorcode */
		case .dataMatrix: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_DataMatrix) /* DF - Data Matrix */
		case .maxiCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MaxiCode) /* DF - MaxiCode */
		case .microPDF: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_MicroPDF) /* DF - MicroPDF */
		case .pdf_417: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PDF_417) /* DF - PDF-417 */
		case .posiCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_PosiCode) /* DF - PosiCode */
		case .qrCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_QRCode) /* DF - QR Code */
		case .superCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_SuperCode) /* DF - SuperCode */
		case .ultraCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_UltraCode) /* DF - UltraCode */
		case .usb_5_SlugCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_USB_5_SlugCode) /* DF - USD-5 (Slug Code) */
		case .veriCode: return (kHIDPage_BarCodeScanner, kHIDUsage_BCS_VeriCode) /* DF - VeriCode */
			/* Reserved 0x122 - 0xFFFF */
		case .reserved(let val): return (kHIDPage_BarCodeScanner, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_BCS_Undefined: self = .undefined
		case kHIDUsage_BCS_BadgeReader: self = .badgeReader
		case kHIDUsage_BCS_BarCodeScanner: self = .barCodeScanner
		case kHIDUsage_BCS_DumbBarCodeScanner: self = .dumbBarCodeScanner
		case kHIDUsage_BCS_CordlessScannerBase: self = .cordlessScannerBase
		case kHIDUsage_BCS_BarCodeScannerCradle: self = .barCodeScannerCradle
			/* Reserved 0x06 - 0x0F */
		case kHIDUsage_BCS_AttributeReport: self = .attributeReport
		case kHIDUsage_BCS_SettingsReport: self = .settingsReport
		case kHIDUsage_BCS_ScannedDataReport: self = .scannedDataReport
		case kHIDUsage_BCS_RawScannedDataReport: self = .rawScannedDataReport
		case kHIDUsage_BCS_TriggerReport: self = .triggerReport
		case kHIDUsage_BCS_StatusReport: self = .statusReport
		case kHIDUsage_BCS_UPC_EANControlReport: self = .upc_EANControlReport
		case kHIDUsage_BCS_EAN2_3LabelControlReport: self = .ean2_3LabelControlReport
		case kHIDUsage_BCS_Code39ControlReport: self = .code39ControlReport
		case kHIDUsage_BCS_Interleaved2of5ControlReport: self = .interleaved2of5ControlReport
		case kHIDUsage_BCS_Standard2of5ControlReport: self = .standard2of5ControlReport
		case kHIDUsage_BCS_MSIPlesseyControlReport: self = .mSIPlesseyControlReport
		case kHIDUsage_BCS_CodabarControlReport: self = .codabarControlReport
		case kHIDUsage_BCS_Code128ControlReport: self = .code128ControlReport
		case kHIDUsage_BCS_Misc1DControlReport: self = .misc1DControlReport
		case kHIDUsage_BCS_2DControlReport: self = .twoDControlReport
			/* Reserved 0x20 - 0x2F */
		case kHIDUsage_BCS_Aiming_PointerMide: self = .aiming_PointerMide
		case kHIDUsage_BCS_BarCodePresentSensor: self = .barCodePresentSensor
		case kHIDUsage_BCS_Class1ALaser: self = .class1ALaser
		case kHIDUsage_BCS_Class2Laser: self = .class2Laser
		case kHIDUsage_BCS_HeaterPresent: self = .heaterPresent
		case kHIDUsage_BCS_ContactScanner: self = .contactScanner
		case kHIDUsage_BCS_ElectronicArticleSurveillanceNotification: self = .electronicArticleSurveillanceNotification
		case kHIDUsage_BCS_ConstantElectronicArticleSurveillance: self = .constantElectronicArticleSurveillance
		case kHIDUsage_BCS_ErrorIndication: self = .errorIndication
		case kHIDUsage_BCS_FixedBeeper: self = .fixedBeeper
		case kHIDUsage_BCS_GoodDecodeIndication: self = .goodDecodeIndication
		case kHIDUsage_BCS_HandsFreeScanning: self = .handsFreeScanning
		case kHIDUsage_BCS_IntrinsicallySafe: self = .intrinsicallySafe
		case kHIDUsage_BCS_KlasseEinsLaser: self = .klasseEinsLaser
		case kHIDUsage_BCS_LongRangeScanner: self = .longRangeScanner
		case kHIDUsage_BCS_MirrorSpeedControl: self = .mirrorSpeedControl
		case kHIDUsage_BCS_NotOnFileIndication: self = .notOnFileIndication
		case kHIDUsage_BCS_ProgrammableBeeper: self = .programmableBeeper
		case kHIDUsage_BCS_Triggerless: self = .triggerless
		case kHIDUsage_BCS_Wand: self = .wand
		case kHIDUsage_BCS_WaterResistant: self = .waterResistant
		case kHIDUsage_BCS_MultiRangeScanner: self = .multiRangeScanner
		case kHIDUsage_BCS_ProximitySensor: self = .proximitySensor
			/* Reserved 0x47 - 0x4C */
		case kHIDUsage_BCS_FragmentDecoding: self = .fragmentDecoding
		case kHIDUsage_BCS_ScannerReadConfidence: self = .scannerReadConfidence
		case kHIDUsage_BCS_DataPrefix: self = .dataPrefix
		case kHIDUsage_BCS_PrefixAIMI: self = .prefixAIMI
		case kHIDUsage_BCS_PrefixNone: self = .prefixNone
		case kHIDUsage_BCS_PrefixProprietary: self = .prefixProprietary
			/* Reserved 0x53 - 0x54 */
		case kHIDUsage_BCS_ActiveTime: self = .activeTime
		case kHIDUsage_BCS_AimingLaserPattern: self = .aimingLaserPattern
		case kHIDUsage_BCS_BarCodePresent: self = .barCodePresent
		case kHIDUsage_BCS_BeeperState: self = .beeperState
		case kHIDUsage_BCS_LaserOnTime: self = .laserOnTime
		case kHIDUsage_BCS_LaserState: self = .laserState
		case kHIDUsage_BCS_LockoutTime: self = .lockoutTime
		case kHIDUsage_BCS_MotorState: self = .motorState
		case kHIDUsage_BCS_MotorTimeout: self = .motorTimeout
		case kHIDUsage_BCS_PowerOnResetScanner: self = .powerOnResetScanner
		case kHIDUsage_BCS_PreventReadOfBarcodes: self = .preventReadOfBarcodes
		case kHIDUsage_BCS_InitiateBarcodeRead: self = .initiateBarcodeRead
		case kHIDUsage_BCS_TriggerState: self = .triggerState
		case kHIDUsage_BCS_TriggerMode: self = .triggerMode
		case kHIDUsage_BCS_TriggerModeBlinkingLaserOn: self = .triggerModeBlinkingLaserOn
		case kHIDUsage_BCS_TriggerModeContinuousLaserOn: self = .triggerModeContinuousLaserOn
		case kHIDUsage_BCS_TriggerModeLaserOnWhilePulled: self = .triggerModeLaserOnWhilePulled
		case kHIDUsage_BCS_TriggerModeLaserStaysOnAfterTriggerRelease: self = .triggerModeLaserStaysOnAfterTriggerRelease
			/* Reserved 0x67 - 0x6C */
		case kHIDUsage_BCS_CommitParametersToNVM: self = .commitParametersToNVM
		case kHIDUsage_BCS_ParameterScanning: self = .parameterScanning
		case kHIDUsage_BCS_ParametersChanged: self = .parametersChanged
		case kHIDUsage_BCS_SetParameterDefaultValues: self = .setParameterDefaultValues
			/* Reserved 0x71 - 0x74 */
		case kHIDUsage_BCS_ScannerInCradle: self = .scannerInCradle
		case kHIDUsage_BCS_ScannerInRange: self = .scannerInRange
			/* Reserved 0x77 - 0x79 */
		case kHIDUsage_BCS_AimDuration: self = .aimDuration
		case kHIDUsage_BCS_GoodReadLampDuration: self = .goodReadLampDuration
		case kHIDUsage_BCS_GoodReadLampIntensity: self = .goodReadLampIntensity
		case kHIDUsage_BCS_GoodReadLED: self = .goodReadLED
		case kHIDUsage_BCS_GoodReadToneFrequency: self = .goodReadToneFrequency
		case kHIDUsage_BCS_GoodReadToneLength: self = .goodReadToneLength
		case kHIDUsage_BCS_GoodReadToneVolume: self = .goodReadToneVolume
			/* Reserved 0x81 */
		case kHIDUsage_BCS_NoReadMessage: self = .noReadMessage
		case kHIDUsage_BCS_NotOnFileVolume: self = .notOnFileVolume
		case kHIDUsage_BCS_PowerupBeep: self = .powerupBeep
		case kHIDUsage_BCS_SoundErrorBeep: self = .soundErrorBeep
		case kHIDUsage_BCS_SoundGoodReadBeep: self = .soundGoodReadBeep
		case kHIDUsage_BCS_SoundNotOnFileBeep: self = .soundNotOnFileBeep
		case kHIDUsage_BCS_GoodReadWhenToWrite: self = .goodReadWhenToWrite
		case kHIDUsage_BCS_GRWTIAfterDecode: self = .grwtiAfterDecode
		case kHIDUsage_BCS_GRWTIBeep_LampAfterTransmit: self = .grwtiBeep_LampAfterTransmit
		case kHIDUsage_BCS_GRWTINoBeep_LampUseAtAll: self = .grwtiNoBeep_LampUseAtAll
			/* Reserved 0x8C - 0x90 */
		case kHIDUsage_BCS_BooklandEAN: self = .booklandEAN
		case kHIDUsage_BCS_ConvertEAN8To13Type: self = .convertEAN8To13Type
		case kHIDUsage_BCS_ConvertUPCAToEAN_13: self = .convertUPCAToEAN_13
		case kHIDUsage_BCS_ConvertUPC_EToA: self = .convertUPC_EToA
		case kHIDUsage_BCS_EAN_13: self = .ean_13
		case kHIDUsage_BCS_EAN_8: self = .ean_8
		case kHIDUsage_BCS_EAN_99_128_Mandatory: self = .ean_99_128_Mandatory
		case kHIDUsage_BCS_EAN_99_P5_128_Optional: self = .ean_99_P5_128_Optional
			/* Reserved 0x99 */
		case kHIDUsage_BCS_UPC_EAN: self = .upc_EAN
		case kHIDUsage_BCS_UPC_EANCouponCode: self = .upc_EANCouponCode
		case kHIDUsage_BCS_UPC_EANPeriodicals: self = .upc_EANPeriodicals
		case kHIDUsage_BCS_UPC_A: self = .upc_A
		case kHIDUsage_BCS_UPC_AWith128Mandatory: self = .upc_AWith128Mandatory
		case kHIDUsage_BCS_UPC_AWith128Optical: self = .upc_AWith128Optical
		case kHIDUsage_BCS_UPC_AWithP5Optional: self = .upc_AWithP5Optional
		case kHIDUsage_BCS_UPC_E: self = .upc_E
		case kHIDUsage_BCS_UPC_E1: self = .upc_E1
			/* Reserved 0xA3 - 0xA8 */
		case kHIDUsage_BCS_Periodical: self = .periodical
		case kHIDUsage_BCS_PeriodicalAutoDiscriminatePlus2: self = .periodicalAutoDiscriminatePlus2
		case kHIDUsage_BCS_PeriodicalOnlyDecodeWithPlus2: self = .periodicalOnlyDecodeWithPlus2
		case kHIDUsage_BCS_PeriodicalIgnorePlus2: self = .periodicalIgnorePlus2
		case kHIDUsage_BCS_PeriodicalAutoDiscriminatePlus5: self = .periodicalAutoDiscriminatePlus5
		case kHIDUsage_BCS_PeriodicalOnlyDecodeWithPlus5: self = .periodicalOnlyDecodeWithPlus5
		case kHIDUsage_BCS_PeriodicalIgnorePlus5: self = .periodicalIgnorePlus5
		case kHIDUsage_BCS_Check: self = .check
		case kHIDUsage_BCS_CheckDisablePrice: self = .checkDisablePrice
		case kHIDUsage_BCS_CheckEnable4DigitPrice: self = .checkEnable4DigitPrice
		case kHIDUsage_BCS_CheckEnable5DigitPrice: self = .checkEnable5DigitPrice
		case kHIDUsage_BCS_CheckEnableEuropean4DigitPrice: self = .checkEnableEuropean4DigitPrice
		case kHIDUsage_BCS_CheckEnableEuropean5DigitPrice: self = .checkEnableEuropean5DigitPrice
			/* Reserved 0xB6 */
		case kHIDUsage_BCS_EANTwoLabel: self = .eanTwoLabel
		case kHIDUsage_BCS_EANThreeLabel: self = .eanThreeLabel
		case kHIDUsage_BCS_EAN8FlagDigit1: self = .ean8FlagDigit1
		case kHIDUsage_BCS_EAN8FlagDigit2: self = .ean8FlagDigit2
		case kHIDUsage_BCS_EAN8FlagDigit3: self = .ean8FlagDigit3
		case kHIDUsage_BCS_EAN13FlagDigit1: self = .ean13FlagDigit1
		case kHIDUsage_BCS_EAN13FlagDigit2: self = .ean13FlagDigit2
		case kHIDUsage_BCS_EAN13FlagDigit3: self = .ean13FlagDigit3
		case kHIDUsage_BCS_AddEAN2_3LabelDefinition: self = .addEAN2_3LabelDefinition
		case kHIDUsage_BCS_ClearAllEAN2_3LabelDefinitions: self = .clearAllEAN2_3LabelDefinitions
			/* Reserved 0xC1 - 0xC2 */
		case kHIDUsage_BCS_Codabar: self = .codabar
		case kHIDUsage_BCS_Code128: self = .code128
			/* Reserved 0xC5 - 0xC6 */
		case kHIDUsage_BCS_Code39: self = .code39
		case kHIDUsage_BCS_Code93: self = .code93
		case kHIDUsage_BCS_FullASCIIConversion: self = .fullASCIIConversion
		case kHIDUsage_BCS_Interleaved2of5: self = .interleaved2of5
		case kHIDUsage_BCS_ItalianPharmacyCode: self = .italianPharmacyCode
		case kHIDUsage_BCS_MSI_Plessey: self = .msi_Plessey
		case kHIDUsage_BCS_Standard2of5IATA: self = .standard2of5IATA
		case kHIDUsage_BCS_Standard2of5: self = .standard2of5
			/* Reserved 0xCF - 0xD2 */
		case kHIDUsage_BCS_TransmitStart_Stop: self = .transmitStart_Stop
		case kHIDUsage_BCS_TriOptic: self = .triOptic
		case kHIDUsage_BCS_UCC_EAN_128: self = .ucc_EAN_128
		case kHIDUsage_BCS_CheckDigit: self = .checkDigit
		case kHIDUsage_BCS_CheckDigitDisable: self = .checkDigitDisable
		case kHIDUsage_BCS_CheckDigitEnableInterleaved2of5OPCC: self = .checkDigitEnableInterleaved2of5OPCC
		case kHIDUsage_BCS_CheckDigitEnableInterleaved2of5USS: self = .checkDigitEnableInterleaved2of5USS
		case kHIDUsage_BCS_CheckDigitEnableStandard2of5OPCC: self = .checkDigitEnableStandard2of5OPCC
		case kHIDUsage_BCS_CheckDigitEnableStandard2of5USS: self = .checkDigitEnableStandard2of5USS
		case kHIDUsage_BCS_CheckDigitEnableOneMSIPlessey: self = .checkDigitEnableOneMSIPlessey
		case kHIDUsage_BCS_CheckDigitEnableTwoMSIPlessey: self = .checkDigitEnableTwoMSIPlessey
		case kHIDUsage_BCS_CheckDigitCodabarEnable: self = .checkDigitCodabarEnable
		case kHIDUsage_BCS_CheckDigitCode99Enable: self = .checkDigitCode99Enable
			/* Reserved 0xE0 - 0xEF */
		case kHIDUsage_BCS_TransmitCheckDigit: self = .transmitCheckDigit
		case kHIDUsage_BCS_DisableCheckDigitTransmit: self = .disableCheckDigitTransmit
		case kHIDUsage_BCS_EnableCheckDigitTransmit: self = .enableCheckDigitTransmit
			/* Reserved 0xF3 - 0xFA */
		case kHIDUsage_BCS_SymbologyIdentifier1: self = .symbologyIdentifier1
		case kHIDUsage_BCS_SymbologyIdentifier2: self = .symbologyIdentifier2
		case kHIDUsage_BCS_SymbologyIdentifier3: self = .symbologyIdentifier3
		case kHIDUsage_BCS_DecodedData: self = .decodedData
		case kHIDUsage_BCS_DecodeDataContinued: self = .decodeDataContinued
		case kHIDUsage_BCS_BarSpaceData: self = .barSpaceData
		case kHIDUsage_BCS_ScannerDataAccuracy: self = .scannerDataAccuracy
		case kHIDUsage_BCS_RawDataPolarity: self = .rawDataPolarity
		case kHIDUsage_BCS_PolarityInvertedBarCode: self = .polarityInvertedBarCode
		case kHIDUsage_BCS_PolarityNormalBarCode: self = .polarityNormalBarCode
			/* Reserved 0x105 */
		case kHIDUsage_BCS_MinimumLengthToDecode: self = .minimumLengthToDecode
		case kHIDUsage_BCS_MaximumLengthToDecode: self = .maximumLengthToDecode
		case kHIDUsage_BCS_FirstDiscreteLengthToDecode: self = .firstDiscreteLengthToDecode
		case kHIDUsage_BCS_SecondDiscreteLengthToDecode: self = .secondDiscreteLengthToDecode
		case kHIDUsage_BCS_DataLengthMethod: self = .dataLengthMethod
		case kHIDUsage_BCS_DLMethodReadAny: self = .dlMethodReadAny
		case kHIDUsage_BCS_DLMethodCheckInRange: self = .dlMethodCheckInRange
		case kHIDUsage_BCS_DLMethodCheckForDiscrete: self = .dlMethodCheckForDiscrete
			/* Reserved 0x10E - 0x10F */
		case kHIDUsage_BCS_AztecCode: self = .aztecCode
		case kHIDUsage_BCS_BC412: self = .bC412
		case kHIDUsage_BCS_ChannelCode: self = .channelCode
		case kHIDUsage_BCS_Code16: self = .code16
		case kHIDUsage_BCS_Code32: self = .code32
		case kHIDUsage_BCS_Code49: self = .code49
		case kHIDUsage_BCS_CodeOne: self = .codeOne
		case kHIDUsage_BCS_Colorcode: self = .colorcode
		case kHIDUsage_BCS_DataMatrix: self = .dataMatrix
		case kHIDUsage_BCS_MaxiCode: self = .maxiCode
		case kHIDUsage_BCS_MicroPDF: self = .microPDF
		case kHIDUsage_BCS_PDF_417: self = .pdf_417
		case kHIDUsage_BCS_PosiCode: self = .posiCode
		case kHIDUsage_BCS_QRCode: self = .qrCode
		case kHIDUsage_BCS_SuperCode: self = .superCode
		case kHIDUsage_BCS_UltraCode: self = .ultraCode
		case kHIDUsage_BCS_USB_5_SlugCode: self = .usb_5_SlugCode
		case kHIDUsage_BCS_VeriCode: self = .veriCode
			/* Reserved 0x122 - 0xFFFF */
		default: self = .reserved(usage)
		}
	}
}

/**
 Weighing Devices Page (0x8D)

 This section provides detailed descriptions of the usages employed by Weighing Devices.
 */
public enum WeighDevicesUsage: IUsagePageUsage
{
	case undefined /* Weighing Device Undefined Usage */
	case weighingDevice /* CA - Weighing Device */
	/* Reserved 0x02 - 0x1F */
	case scaleScaleDevice /* CL - Scale Device */
	case scaleScaleClassIMetricCL /* CL - Scale Class I Metric */
	case scaleScaleClassIMetric /* SEL - Scale Class I Metric */
	case scaleScaleClassIIMetric /* SEL - Scale Class II Metric */
	case scaleScaleClassIIIMetric /* SEL - Scale Class III Metric */
	case scaleScaleClassIIILMetric /* SEL - Scale Class IIIL Metric */
	case scaleScaleClassIVMetric /* SEL - Scale Class IV Metric */
	case scaleScaleClassIIIEnglish /* SEL - Scale Class III English */
	case scaleScaleClassIIILEnglish /* SEL - Scale Class IIIL English */
	case scaleScaleClassIVEnglish /* SEL - Scale Class IV English */
	case scaleScaleClassGeneric /* SEL - Scale Class Generic */
	/* Reserved 0x2B - 0x2F */
	case scaleAtrributeReport /* CL - Scale Attribute Report */
	case scaleControlReport /* CL - Scale Control Report */
	case scaleDataReport /* CL - Scale Data Report */
	case scaleStatusReport /* CL - Scale Status Report */
	case scaleWeightLimitReport /* CL - Scale Weight Limit Report */
	case scaleStatisticsReport /* CL - Scale Statistics Report */
	/* Reserved 0x36 - 0x3F */
	case dataWeight /* DV - Data Weight */
	case dataScaling /* DV - Data Scaling */
	/* Reserved 0x42 - 0x4F */
	case weightUnit /* CL - Weight Unit */
	case weightUnitMilligram /* SEL - Weight Unit Milligram */
	case weightUnitGram /* SEL - Weight Unit Gram */
	case weightUnitKilogram /* SEL - Weight Unit Kilogram */
	case weightUnitCarats /* SEL - Weight Unit Carats */
	case weightUnitTaels /* SEL - Weight Unit Taels */
	case weightUnitGrains /* SEL - Weight Unit Grains */
	case weightUnitPennyweights /* SEL - Weight Unit Pennyweights */
	case weightUnitMetricTon /* SEL - Weight Unit Metric Ton */
	case weightUnitAvoirTon /* SEL - Weight Unit Avoir Ton */
	case weightUnitTroyOunce /* SEL - Weight Unit Troy Ounce */
	case weightUnitOunce /* SEL - Weight Unit Ounce */
	case weightUnitPound /* SEL - Weight Unit Pound */
	/* Reserved 0x5D - 0x5F */
	case calibrationCount /* DV - Calibration Count */
	case rezeroCount /* DV - Re-Zero Count*/
	/* Reserved 0x62 - 0x6F */
	case scaleStatus /* CL - Scale Status */
	case scaleStatusFault /* SEL - Scale Status Fault */
	case scaleStatusStableAtZero /* SEL - Scale Status Stable at Center of  Zero */
	case scaleStatusInMotion /* SEL - Scale Status In Motion */
	case scaleStatusWeightStable /* SEL - Scale Status Weight Stable */
	case scaleStatusUnderZero /* SEL - Scale Status Under Zero */
	case scaleStatusOverWeightLimit /* SEL - Scale Status Over Weight Limit */
	case scaleStatusRequiresCalibration /* SEL - Scale Status Requires Calibration */
	case scaleStatusRequiresRezeroing /* SEL - Scale Status Requires Re-zeroing */
	/* Reserved 0x79 - 0x7F */
	case zeroScale /* OOC - Zero Scale */
	case enforcedZeroReturn /* OOC - Enforced Zero Return */
	/* Reserved 0x82 - 0xFFFF */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_WeighingDevice, kHIDUsage_WD_Undefined) /* Weighing Device Undefined Usage */
		case .weighingDevice: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeighingDevice) /* CA - Weighing Device */
			/* Reserved 0x02 - 0x1F */
		case .scaleScaleDevice: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleDevice) /* CL - Scale Device */
		case .scaleScaleClassIMetricCL: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIMetricCL) /* CL - Scale Class I Metric */
		case .scaleScaleClassIMetric: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIMetric) /* SEL - Scale Class I Metric */
		case .scaleScaleClassIIMetric: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIIMetric) /* SEL - Scale Class II Metric */
		case .scaleScaleClassIIIMetric: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIIIMetric) /* SEL - Scale Class III Metric */
		case .scaleScaleClassIIILMetric: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIIILMetric) /* SEL - Scale Class IIIL Metric */
		case .scaleScaleClassIVMetric: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIVMetric) /* SEL - Scale Class IV Metric */
		case .scaleScaleClassIIIEnglish: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIIIEnglish) /* SEL - Scale Class III English */
		case .scaleScaleClassIIILEnglish: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIIILEnglish) /* SEL - Scale Class IIIL English */
		case .scaleScaleClassIVEnglish: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassIVEnglish) /* SEL - Scale Class IV English */
		case .scaleScaleClassGeneric: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleScaleClassGeneric) /* SEL - Scale Class Generic */
			/* Reserved 0x2B - 0x2F */
		case .scaleAtrributeReport: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleAtrributeReport) /* CL - Scale Attribute Report */
		case .scaleControlReport: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleControlReport) /* CL - Scale Control Report */
		case .scaleDataReport: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleDataReport) /* CL - Scale Data Report */
		case .scaleStatusReport: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusReport) /* CL - Scale Status Report */
		case .scaleWeightLimitReport: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleWeightLimitReport) /* CL - Scale Weight Limit Report */
		case .scaleStatisticsReport: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatisticsReport) /* CL - Scale Statistics Report */
			/* Reserved 0x36 - 0x3F */
		case .dataWeight: return (kHIDPage_WeighingDevice, kHIDUsage_WD_DataWeight) /* DV - Data Weight */
		case .dataScaling: return (kHIDPage_WeighingDevice, kHIDUsage_WD_DataScaling) /* DV - Data Scaling */
			/* Reserved 0x42 - 0x4F */
		case .weightUnit: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnit) /* CL - Weight Unit */
		case .weightUnitMilligram: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitMilligram) /* SEL - Weight Unit Milligram */
		case .weightUnitGram: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitGram) /* SEL - Weight Unit Gram */
		case .weightUnitKilogram: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitKilogram) /* SEL - Weight Unit Kilogram */
		case .weightUnitCarats: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitCarats) /* SEL - Weight Unit Carats */
		case .weightUnitTaels: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitTaels) /* SEL - Weight Unit Taels */
		case .weightUnitGrains: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitGrains) /* SEL - Weight Unit Grains */
		case .weightUnitPennyweights: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitPennyweights) /* SEL - Weight Unit Pennyweights */
		case .weightUnitMetricTon: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitMetricTon) /* SEL - Weight Unit Metric Ton */
		case .weightUnitAvoirTon: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitAvoirTon) /* SEL - Weight Unit Avoir Ton */
		case .weightUnitTroyOunce: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitTroyOunce) /* SEL - Weight Unit Troy Ounce */
		case .weightUnitOunce: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitOunce) /* SEL - Weight Unit Ounce */
		case .weightUnitPound: return (kHIDPage_WeighingDevice, kHIDUsage_WD_WeightUnitPound) /* SEL - Weight Unit Pound */
			/* Reserved 0x5D - 0x5F */
		case .calibrationCount: return (kHIDPage_WeighingDevice, kHIDUsage_WD_CalibrationCount) /* DV - Calibration Count */
		case .rezeroCount: return (kHIDPage_WeighingDevice, kHIDUsage_WD_RezeroCount) /* DV - Re-Zero Count*/
			/* Reserved 0x62 - 0x6F */
		case .scaleStatus: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatus) /* CL - Scale Status */
		case .scaleStatusFault: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusFault) /* SEL - Scale Status Fault */
		case .scaleStatusStableAtZero: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusStableAtZero) /* SEL - Scale Status Stable at Center of  Zero */
		case .scaleStatusInMotion: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusInMotion) /* SEL - Scale Status In Motion */
		case .scaleStatusWeightStable: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusWeightStable) /* SEL - Scale Status Weight Stable */
		case .scaleStatusUnderZero: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusUnderZero) /* SEL - Scale Status Under Zero */
		case .scaleStatusOverWeightLimit: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusOverWeightLimit) /* SEL - Scale Status Over Weight Limit */
		case .scaleStatusRequiresCalibration: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusRequiresCalibration) /* SEL - Scale Status Requires Calibration */
		case .scaleStatusRequiresRezeroing: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ScaleStatusRequiresRezeroing) /* SEL - Scale Status Requires Re-zeroing */
			/* Reserved 0x79 - 0x7F */
		case .zeroScale: return (kHIDPage_WeighingDevice, kHIDUsage_WD_ZeroScale) /* OOC - Zero Scale */
		case .enforcedZeroReturn: return (kHIDPage_WeighingDevice, kHIDUsage_WD_EnforcedZeroReturn) /* OOC - Enforced Zero Return */
			/* Reserved 0x82 - 0xFFFF */
		case .reserved(let val): return (kHIDPage_WeighingDevice, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_WD_Undefined: self = .undefined
		case kHIDUsage_WD_WeighingDevice: self = .weighingDevice
			/* Reserved 0x02 - 0x1F */
		case kHIDUsage_WD_ScaleScaleDevice: self = .scaleScaleDevice
		case kHIDUsage_WD_ScaleScaleClassIMetricCL: self = .scaleScaleClassIMetricCL
		case kHIDUsage_WD_ScaleScaleClassIMetric: self = .scaleScaleClassIMetric
		case kHIDUsage_WD_ScaleScaleClassIIMetric: self = .scaleScaleClassIIMetric
		case kHIDUsage_WD_ScaleScaleClassIIIMetric: self = .scaleScaleClassIIIMetric
		case kHIDUsage_WD_ScaleScaleClassIIILMetric: self = .scaleScaleClassIIILMetric
		case kHIDUsage_WD_ScaleScaleClassIVMetric: self = .scaleScaleClassIVMetric
		case kHIDUsage_WD_ScaleScaleClassIIIEnglish: self = .scaleScaleClassIIIEnglish
		case kHIDUsage_WD_ScaleScaleClassIIILEnglish: self = .scaleScaleClassIIILEnglish
		case kHIDUsage_WD_ScaleScaleClassIVEnglish: self = .scaleScaleClassIVEnglish
		case kHIDUsage_WD_ScaleScaleClassGeneric: self = .scaleScaleClassGeneric
			/* Reserved 0x2B - 0x2F */
		case kHIDUsage_WD_ScaleAtrributeReport: self = .scaleAtrributeReport
		case kHIDUsage_WD_ScaleControlReport: self = .scaleControlReport
		case kHIDUsage_WD_ScaleDataReport: self = .scaleDataReport
		case kHIDUsage_WD_ScaleStatusReport: self = .scaleStatusReport
		case kHIDUsage_WD_ScaleWeightLimitReport: self = .scaleWeightLimitReport
		case kHIDUsage_WD_ScaleStatisticsReport: self = .scaleStatisticsReport
			/* Reserved 0x36 - 0x3F */
		case kHIDUsage_WD_DataWeight: self = .dataWeight
		case kHIDUsage_WD_DataScaling: self = .dataScaling
			/* Reserved 0x42 - 0x4F */
		case kHIDUsage_WD_WeightUnit: self = .weightUnit
		case kHIDUsage_WD_WeightUnitMilligram: self = .weightUnitMilligram
		case kHIDUsage_WD_WeightUnitGram: self = .weightUnitGram
		case kHIDUsage_WD_WeightUnitKilogram: self = .weightUnitKilogram
		case kHIDUsage_WD_WeightUnitCarats: self = .weightUnitCarats
		case kHIDUsage_WD_WeightUnitTaels: self = .weightUnitTaels
		case kHIDUsage_WD_WeightUnitGrains: self = .weightUnitGrains
		case kHIDUsage_WD_WeightUnitPennyweights: self = .weightUnitPennyweights
		case kHIDUsage_WD_WeightUnitMetricTon: self = .weightUnitMetricTon
		case kHIDUsage_WD_WeightUnitAvoirTon: self = .weightUnitAvoirTon
		case kHIDUsage_WD_WeightUnitTroyOunce: self = .weightUnitTroyOunce
		case kHIDUsage_WD_WeightUnitOunce: self = .weightUnitOunce
		case kHIDUsage_WD_WeightUnitPound: self = .weightUnitPound
			/* Reserved 0x5D - 0x5F */
		case kHIDUsage_WD_CalibrationCount: self = .calibrationCount
		case kHIDUsage_WD_RezeroCount: self = .rezeroCount
			/* Reserved 0x62 - 0x6F */
		case kHIDUsage_WD_ScaleStatus: self = .scaleStatus
		case kHIDUsage_WD_ScaleStatusFault: self = .scaleStatusFault
		case kHIDUsage_WD_ScaleStatusStableAtZero: self = .scaleStatusStableAtZero
		case kHIDUsage_WD_ScaleStatusInMotion: self = .scaleStatusInMotion
		case kHIDUsage_WD_ScaleStatusWeightStable: self = .scaleStatusWeightStable
		case kHIDUsage_WD_ScaleStatusUnderZero: self = .scaleStatusUnderZero
		case kHIDUsage_WD_ScaleStatusOverWeightLimit: self = .scaleStatusOverWeightLimit
		case kHIDUsage_WD_ScaleStatusRequiresCalibration: self = .scaleStatusRequiresCalibration
		case kHIDUsage_WD_ScaleStatusRequiresRezeroing: self = .scaleStatusRequiresRezeroing
			/* Reserved 0x79 - 0x7F */
		case kHIDUsage_WD_ZeroScale: self = .zeroScale
		case kHIDUsage_WD_EnforcedZeroReturn: self = .enforcedZeroReturn
			/* Reserved 0x82 - 0xFFFF */
		default: self = .reserved(usage)
		}
	}
}

/**
 Magnetic Stripe Reader Page (0x8E)

 This section provides detailed descriptions of the usages employed by Magnetic Stripe Reader Devices.
 */
public enum MagneticStripeReaderUsage: IUsagePageUsage
{
	case undefined /* MagStripe Undefined Usage */
	case deviceReadOnly /* CA - MSR Device Read-Only */
	/* Reserved 0x02 - 0x10 */
	case track1Length /* SF, DF, SEL - Track 1 Length */
	case track2Length /* SF, DF, SEL - Track 2 Length */
	case track3Length /* SF, DF, SEL - Track 3 Length */
	case trackJISLength /* SF, DF, SEL - Track JIS Length */
	/* Reserved 0x15 - 0x1F */
	case trackData /* SF, DF, SEL - Track Data */
	case track1Data /* SF, DF, SEL - Track 1 Data */
	case track2Data /* SF, DF, SEL - Track 2 Data */
	case track3Data /* SF, DF, SEL - Track 3 Data */
	case trackJISData /* SF, DF, SEL - Track JIS Data */
	/* Reserved 0x25 - 0xFFFF */
	case reserved(Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .undefined: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_Undefined) /* MagStripe Undefined Usage */
		case .deviceReadOnly: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_DeviceReadOnly) /* CA - MSR Device Read-Only */
			/* Reserved 0x02 - 0x10 */
		case .track1Length: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_Track1Length) /* SF, DF, SEL - Track 1 Length */
		case .track2Length: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_Track2Length) /* SF, DF, SEL - Track 2 Length */
		case .track3Length: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_Track3Length) /* SF, DF, SEL - Track 3 Length */
		case .trackJISLength: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_TrackJISLength) /* SF, DF, SEL - Track JIS Length */
			/* Reserved 0x15 - 0x1F */
		case .trackData: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_TrackData) /* SF, DF, SEL - Track Data */
		case .track1Data: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_Track1Data) /* SF, DF, SEL - Track 1 Data */
		case .track2Data: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_Track2Data) /* SF, DF, SEL - Track 2 Data */
		case .track3Data: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_Track3Data) /* SF, DF, SEL - Track 3 Data */
		case .trackJISData: return (kHIDPage_MagneticStripeReader, kHIDUsage_MSR_TrackJISData) /* SF, DF, SEL - Track JIS Data */
			/* Reserved 0x25 - 0xFFFF */
		case .reserved(let val): return (kHIDPage_MagneticStripeReader, val)
		}
	}
	
	init(with usage: Int) {
		switch usage {
		case kHIDUsage_MSR_Undefined: self = .undefined
		case kHIDUsage_MSR_DeviceReadOnly: self = .deviceReadOnly
			/* Reserved 0x02 - 0x10 */
		case kHIDUsage_MSR_Track1Length: self = .track1Length
		case kHIDUsage_MSR_Track2Length: self = .track2Length
		case kHIDUsage_MSR_Track3Length: self = .track3Length
		case kHIDUsage_MSR_TrackJISLength: self = .trackJISLength
			/* Reserved 0x15 - 0x1F */
		case kHIDUsage_MSR_TrackData: self = .trackData
		case kHIDUsage_MSR_Track1Data: self = .track1Data
		case kHIDUsage_MSR_Track2Data: self = .track2Data
		case kHIDUsage_MSR_Track3Data: self = .track3Data
		case kHIDUsage_MSR_TrackJISData: self = .trackJISData
			/* Reserved 0x25 - 0xFFFF */
		default: self = .reserved(usage)
		}
	}
}

public enum ReservedUsage: IUsagePageUsage
{
	case reserved(Int, Int)
	
	var usage: UsagePageUsage {
		switch self {
		case .reserved(let page, let usage): return (page, usage)
		}
	}
	
	init(withUsagePage usagePage: Int, usage: Int) {
		self = .reserved(usagePage, usage)
	}
}
