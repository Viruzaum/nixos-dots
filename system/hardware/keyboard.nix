{pkgs, ...}: let
  br-workman = pkgs.writeText "br-workman" ''
    partial alphanumeric_keys
    xkb_symbols "workman" {
      include "br(abnt2)"

      name[Group1]="Portuguese (Brazil, Dvorak)";

      key <AE01> { [            1,          exclam,          onesuperior,       exclamdown ] };
      key <AE02> { [            2,              at,          twosuperior,          onehalf ] };
      key <AE03> { [            3,      numbersign,        threesuperior,    threequarters ] };
      key <AE04> { [            4,          dollar,             sterling,       onequarter ] };
      key <AE05> { [            5,         percent,                 cent,       0x01002030 ] };
      key <AE06> { [            6,  dead_diaeresis,              notsign,        diaeresis ] };
      key <AE07> { [            7,       ampersand,        dead_belowdot,    dead_abovedot ] };
      key <AE08> { [            8,        asterisk,          dead_ogonek,        dead_horn ] };
      key <AE09> { [            9,       parenleft,         dead_cedilla,        dead_hook ] };
      key <AE10> { [            0,      parenright,          dead_macron,       dead_breve ] };

      key <AD01> { [            q,               Q ] };
      key <AD02> { [            d,               D ] };
      key <AD03> { [            r,               R ] };
      key <AD04> { [            w,               W ] };
      key <AD05> { [            b,               B ] };
      key <AD06> { [            j,               J ] };
      key <AD07> { [            f,               F ] };
      key <AD08> { [            u,               U ] };
      key <AD09> { [            p,               P ] };
      key <AD10> { [     ccedilla,        Ccedilla ] };

      key <AC01> { [            a,               A ] };
      key <AC02> { [            s,               S ] };
      key <AC03> { [            h,               H ] };
      key <AC04> { [            t,               T ] };
      key <AC05> { [            g,               G ] };
      key <AC06> { [            y,               Y ] };
      key <AC07> { [            n,               N ] };
      key <AC08> { [            e,               E ] };
      key <AC09> { [            o,               O ] };
      key <AC10> { [            i,               I ] };

      key <AB01> { [            z,               Z] };
      key <AB02> { [            x,               X] };
      key <AB03> { [            m,               M] };
      key <AB04> { [            c,               C] };
      key <AB05> { [            v,               V] };
      key <AB06> { [            k,               K] };
      key <AB07> { [            l,               L] };

    // Configures the "," for the numeric keypad
      include "kpdl(comma)"

    // Configures the use of the AltGr key
      include "level3(ralt_switch)"
    };'';
in {
  services.xserver.xkb.extraLayouts = {
    br-workman = {
      description = "Workman for abnt2.";
      languages = ["br"];
      symbolsFile = br-workman;
    };
  };
}
