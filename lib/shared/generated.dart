import 'package:gtfo_rundown_roulette/shared/classes_loadout.dart';
import 'package:gtfo_rundown_roulette/shared/classes_runs.dart';

final class Preset {
  final Rundowns rundowns;
  final Melees melees;
  final Tools tools;
  final PrimaryGuns primaries;
  final SpecialGuns specials;

  Preset(this.rundowns, this.melees, this.tools, this.primaries, this.specials);

  static final Preset vanilla = Preset(
    <Rundown>[
      Rundown("ALT://Rundown 1.0 \"Deviation\"", const <Mission>[
        Mission(canonicalName: "R1A1 \"THE ADMIN\"", tier: "A", number: 1),
        Mission(canonicalName: "R1B1 \"PID SEARCH\"", tier: "B", number: 1),
        Mission(canonicalName: "R1B2 \"THE OFFICER\"", tier: "B", number: 2),
        Mission(canonicalName: "R1C1 \"RECONNECT\"", tier: "C", number: 1),
        Mission(canonicalName: "R1C2 \"DECODE\"", tier: "C", number: 2),
        Mission(canonicalName: "R1D1 \"DEEPER\"", tier: "D", number: 1),
      ]),
      Rundown("ALT://Rundown 2.0 \"Infection\"", const <Mission>[
        Mission(canonicalName: "R2A1 \"THE DIG\"", tier: "A", number: 1),

        Mission(canonicalName: "R2B1 \"SACRIFICE\"", tier: "B", number: 1),
        Mission(canonicalName: "R2B2 \"POWER CORRUPTS\"", tier: "B", number: 2),
        Mission(canonicalName: "R2B3 \"PATHFINDER\"", tier: "B", number: 3),
        Mission(canonicalName: "R2B4 \"SEPTIC\"", tier: "B", number: 4),
        Mission(canonicalName: "R2C1 \"TRIANGULATION\"", tier: "C", number: 1),
        Mission(canonicalName: "R2C2 \"???\"", tier: "C", number: 2),
        Mission(canonicalName: "R2D1 \"STATISTICS\"", tier: "D", number: 1),
        Mission(canonicalName: "R2D2 \"POWERLESS\"", tier: "D", number: 2),
        Mission(canonicalName: "R2E1 \"CRIB\"", tier: "E", number: 1),
      ]),
      Rundown("ALT://Rundown 3.0 \"The Vessel\"", const <Mission>[
        Mission(canonicalName: "R3A1 \"RESUSCITATION\"", tier: "A", number: 1),
        Mission(canonicalName: "R3A2 \"PURIFICATION\"", tier: "A", number: 2),
        Mission(canonicalName: "R3A3 \"BOLT\"", tier: "A", number: 3),
        Mission(canonicalName: "R3B1 \"THRESHOLD\"", tier: "B", number: 1),
        Mission(canonicalName: "R3B2 \"PRESSURE\"", tier: "B", number: 2),
        Mission(canonicalName: "R3C1 \"ALPHA\"", tier: "C", number: 1),
        Mission(canonicalName: "R3D1 \"BIANHUA\"", tier: "D", number: 1),
      ]),
      Rundown("ALT://Rundown 4.0 \"Contact\"", const <Mission>[
        Mission.secondary(canonicalName: "R4A1 \"CYTOLOGY\"", tier: "A", number: 1),
        Mission.prisonerEfficiency(canonicalName: "R4A2 \"FOSTER\"", tier: "A", number: 2),
        Mission.prisonerEfficiency(canonicalName: "R4A3 \"ONWARDS\"", tier: "A", number: 3),
        Mission.secondary(canonicalName: "R4B1 \"MALACHITE\"", tier: "B", number: 1),
        Mission.prisonerEfficiency(canonicalName: "R4B2 \"VARISCITE\"", tier: "B", number: 2),
        Mission.prisonerEfficiency(canonicalName: "R4B3 \"CHRYSOLITE\"", tier: "B", number: 3),
        Mission.secondary(canonicalName: "R4C1 \"COGNITION\"", tier: "C", number: 1),
        Mission.prisonerEfficiency(canonicalName: "R4C2 \"PABULUM\"", tier: "C", number: 2),
        Mission.prisonerEfficiency(canonicalName: "R4C3 \"CUERNOS\"", tier: "C", number: 3),
        Mission.secondary(canonicalName: "R4D1 \"NUCLEUS\"", tier: "D", number: 1),
        Mission.prisonerEfficiency(canonicalName: "R4D2 \"GROWTH\"", tier: "D", number: 2),
        Mission.secondary(canonicalName: "R4E1 \"DOWNWARDS\"", tier: "E", number: 1),
      ]),
      Rundown("ALT://Rundown 5.0 \"Rebirth\"", const <Mission>[
        Mission.secondary(canonicalName: "R5A1 \"FLOODWAYS\"", tier: "A", number: 1),
        Mission.prisonerEfficiency(canonicalName: "R5A2 \"RECOLLECT\"", tier: "A", number: 2),
        Mission.prisonerEfficiency(canonicalName: "R5A3 \"MINING\"", tier: "A", number: 3),
        Mission.prisonerEfficiency(canonicalName: "R5B1 \"SMOTHER\"", tier: "B", number: 1),
        Mission.prisonerEfficiency(canonicalName: "R5B2 \"DISCHARGE\"", tier: "B", number: 2),
        Mission.secondary(canonicalName: "R5B3 \"UNSEAL\"", tier: "B", number: 3),
        Mission(canonicalName: "R5B4 \"DIVERSION\"", tier: "B", number: 4),
        Mission.secondary(canonicalName: "R5C1 \"BINARY\"", tier: "C", number: 1),
        Mission.prisonerEfficiency(canonicalName: "R5C2 \"ACCESS\"", tier: "C", number: 2),
        Mission.secondary(canonicalName: "R5C3 \"STARVATION\"", tier: "C", number: 3),
        Mission.secondary(canonicalName: "R5D1 \"EVEN DEEPER\"", tier: "D", number: 1),
        Mission(canonicalName: "R5D2 \"ERROR\"", tier: "D", number: 2),
        Mission(canonicalName: "R5E1 \"KDS DEEP\"", tier: "E", number: 1),
      ]),
      Rundown("ALT://Rundown 6.0 \"Destination\"", const <Mission>[
        Mission(canonicalName: "R6A1 \"ARTIFACT 7\"", tier: "A", number: 1),
        Mission(canonicalName: "R6AX \"DUST\"", tier: "A", number: 10),
        Mission(canonicalName: "R6B1 \"HEXAHEDRONS\"", tier: "B", number: 1),
        Mission.secondary(canonicalName: "R6B2 \"CONTAMINANT\"", tier: "B", number: 2),
        Mission.secondary(canonicalName: "R6BX \"FLUX\"", tier: "B", number: 10),
        Mission(canonicalName: "R6C1 \"NAVIGATION\"", tier: "C", number: 1),
        Mission.secondary(canonicalName: "R6C2 \"BLIND\"", tier: "C", number: 2),
        Mission.prisonerEfficiency(canonicalName: "R6C3 \"PRESSURE POINT\"", tier: "C", number: 3),
        Mission(canonicalName: "R6CX \"ASCENT\"", tier: "C", number: 10),
        Mission(canonicalName: "R6D1 \"NEMESIS\"", tier: "D", number: 1),
        Mission.secondary(canonicalName: "R6D2 \"CROSSWAYS\"", tier: "D", number: 2),
        Mission.prisonerEfficiency(canonicalName: "R6D3 \"POWER HUNGRY\"", tier: "D", number: 3),
        Mission(canonicalName: "R6D4 \"CRYPTOMNESIA\"", tier: "D", number: 4),
      ]),
      Rundown("Rundown 7.0 \"RISE\"", const <Mission>[
        Mission(canonicalName: "R7A1 \"UNIT 23\"", tier: "A", number: 1),
        Mission(canonicalName: "R7B1 \"CARGO\"", tier: "B", number: 1),
        Mission.secondary(canonicalName: "R7B2 \"DENSE\"", tier: "B", number: 2),
        Mission.prisonerEfficiency(canonicalName: "R7B3 \"VAULT\"", tier: "B", number: 3),
        Mission(canonicalName: "R7C1 \"MONSTER\"", tier: "C", number: 1),
        Mission.prisonerEfficiency(canonicalName: "R7C2 \"SUBLIMATION\"", tier: "C", number: 2),
        Mission.prisonerEfficiency(canonicalName: "R7C3 \"RECKLESS\"", tier: "C", number: 3),
        Mission.secondary(canonicalName: "R7D1 \"MOTHER\"", tier: "D", number: 1),
        Mission(canonicalName: "R7D2 \"AWOL\"", tier: "C", number: 2),
        Mission(canonicalName: "R7E1 \"CHAOS\"", tier: "E", number: 1),
      ]),
      Rundown("Rundown 8.0 \"Duality\"", const <Mission>[
        Mission(canonicalName: "R8A1 \"ORDER\"", tier: "A", number: 1),
        Mission.secondary(canonicalName: "R8A2 \"PERSPECTIVE\"", tier: "A", number: 2),
        Mission.secondary(canonicalName: "R8B1 \"EFFECT\"", tier: "B", number: 1),
        Mission.secondary(canonicalName: "R8B2 \"WARP\"", tier: "B", number: 2),
        Mission.secondary(canonicalName: "R8B3 \"CAUSE\"", tier: "B", number: 3),
        Mission.secondary(canonicalName: "R8B4 \"INSURRECTION\"", tier: "B", number: 4),
        Mission.prisonerEfficiency(canonicalName: "R8C1 \"LINK\"", tier: "C", number: 1),
        Mission(canonicalName: "R8C2 \"UNPLUGGED\"", tier: "C", number: 2),
        Mission(canonicalName: "R8D1 \"TANDEM\"", tier: "D", number: 1),
        Mission.secondary(canonicalName: "R8D2 \"SLAUGHTER\"", tier: "D", number: 2),
        Mission.secondary(canonicalName: "R8E1 \"VALIANT\"", tier: "E", number: 1),
        Mission.secondary(canonicalName: "R8E2 \"RELEASE\"", tier: "E", number: 2),
      ]),
    ],
    const <MeleeWeapon>[
      MeleeWeapon.bat(),
      MeleeWeapon.hammer(),
      MeleeWeapon.knife(),
      MeleeWeapon.spear(),
    ],
    const <ToolItem>[
      ToolItem(assetPath: "assets/ingame/biotracker.png", canonicalName: "Bio Tracker"),
      ToolItem(assetPath: "assets/ingame/cfoam.png", canonicalName: "C-Foam Launcher"),
      ToolItem(assetPath: "assets/ingame/minedeployer.png", canonicalName: "Mine Deployer"),
      ToolItem(assetPath: "assets/ingame/snipersentry.png", canonicalName: "Sniper Sentry"),
      ToolItem(assetPath: "assets/ingame/burstsentry.png", canonicalName: "Burst Sentry"),
      ToolItem(assetPath: "assets/ingame/shotgunsentry.png", canonicalName: "Shotgun Sentry"),
      ToolItem(assetPath: "assets/ingame/autosentry.png", canonicalName: "HEL Auto Sentry"),
    ],
    const <Gun>[
      Gun(
        assetPath: "assets/ingame/pistol.png",
        canonicalName: "Pistol",
        gameName: "Shelling S49",
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/burstpistol.png",
        canonicalName: "Burst Pistol",
        gameName: "Shelling Nano",
        isHEL: false,
        isSpecial: false,
        firemode: GunFiremode.burst,
      ),
      Gun(
        assetPath: "assets/ingame/helrevolver.png",
        canonicalName: "HEL Revolver",
        gameName: "Bataldo 3RB",
        isHEL: true,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/machinepistol.png",
        canonicalName: "Machine Pistol",
        firemode: GunFiremode.auto,
        gameName: "Raptus Treffen 2",
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/helautopistol.png",
        canonicalName: "HEL Austopistol",
        firemode: GunFiremode.auto,
        gameName: "Raptus Steigro",
        isHEL: true,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/bullpuprifle.png",
        canonicalName: "Bullpup Rifle",
        firemode: GunFiremode.auto,
        gameName: "Accrat Golok DA",
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/smg.png",
        canonicalName: "SMG",
        gameName: "Van Auken LTC5",
        firemode: GunFiremode.auto,
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/pdw.png",
        canonicalName: "PDW",
        gameName: "Accrat STB",
        firemode: GunFiremode.auto,
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/heavysmg.png",
        canonicalName: "Heavy SMG",
        firemode: GunFiremode.auto,
        gameName: "Accrat ND6",
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/carbine.png",
        canonicalName: "Carbine",
        gameName: "Van Auken CAB F4",
        firemode: GunFiremode.burst,
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/dmr.png",
        gameName: "TR22 Hanaway",
        canonicalName: "DMR",
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/doubletaprifle.png",
        canonicalName: "Double Tap Rifle",
        gameName: "Hanaway PSB",
        isHEL: false,
        firemode: GunFiremode.burst,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/assaultrifle.png",
        canonicalName: "Assault Rifle",
        gameName: "Malatack LX",
        firemode: GunFiremode.auto,
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/burstrifle.png",
        canonicalName: "Burst Rifle",
        gameName: "Malatack CH 4",
        firemode: GunFiremode.burst,
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/rifle.png",
        canonicalName: "Rifle",
        gameName: "Drekker Pres MOD 556",
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/sawedoffshotgun.png",
        canonicalName: "Sawed-off Shotgun",
        gameName: "Buckland SBS III",
        firemode: GunFiremode.semi_auto,
        isHEL: false,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/helshotgun.png",
        canonicalName: "HEL Shotgun",
        gameName: "Bataldo J 300",
        firemode: GunFiremode.auto,
        isHEL: true,
        isSpecial: false,
      ),
      Gun(
        assetPath: "assets/ingame/slugshotgun.png",
        canonicalName: "Slug Shotgun",
        gameName: "Bataldo Custom K330",
        isHEL: false,
        isSpecial: false,
      ),
    ],
    const <Gun>[
      Gun(
        assetPath: "assets/ingame/heavyassaultrifle.png",
        canonicalName: "Heavy Assault Rifle",
        gameName: "Malatack HXC",
        firemode: GunFiremode.auto,
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/shortrifle.png",
        canonicalName: "Short Rifle",
        gameName: "Drekker CLR",
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/shotgun.png",
        canonicalName: "Shotgun",
        gameName: "Buckland S870",
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/combatshotgun.png",
        canonicalName: "Combat Shotgun",
        firemode: GunFiremode.auto,
        gameName: "Buckland AF6",
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/scattergun.png",
        canonicalName: "Scattergun",
        gameName: "Drekker INEX Drei",
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/chokemodshotgun.png",
        canonicalName: "Choke Mod Shotgun",
        gameName: "Buckland XDIST2",
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/revolver.png",
        gameName: "Mastaba R66",
        canonicalName: "Revolver",
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/machinegunarbalist.png",
        canonicalName: "Machine Gun",
        firemode: GunFiremode.auto,
        gameName: "Techman Arbalist V",

        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/machinegunveruta.png",
        canonicalName: "Machine Gun",
        gameName: "Techman Veruta XII",
        firemode: GunFiremode.auto,
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/burstcannon.png",
        canonicalName: "Burst Cannon",
        gameName: "Techman Klust 6",
        firemode: GunFiremode.burst,
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/helgun.png",
        canonicalName: "HEL Gun",
        gameName: "Omneco EXP1",
        isHEL: true,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/highcalpistol.png",
        canonicalName: "High Caliber Pistol",
        gameName: "Shelling Arid 5",
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/precisionrifle.png",
        canonicalName: "Precision Rifle",
        gameName: "Drekker Del P1",
        firemode: GunFiremode.auto,
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/sniper.png",
        canonicalName: "Sniper",
        gameName: "Köning PR 11",
        isHEL: false,
        isSpecial: true,
      ),
      Gun(
        assetPath: "assets/ingame/helrifle.png",
        canonicalName: "HEL Rifle",
        gameName: "Omneco LRG",
        isHEL: true,
        isSpecial: true,
      ),
    ],
  );

  List<Mission> get allMissions {
    final List<Mission> res = <Mission>[];
    for (Rundown rundown in rundowns) {
      res.addAll(rundown.allMissions);
    }
    return res;
  }
}

class GeneratedRun {
  final Mission mission;
  final Rundown rundown;
  final PlayerPool players;
  final List<Sector> sectors;

  GeneratedRun({
    required this.mission,
    required this.players,
    required this.sectors,
    required this.rundown,
  });
}
